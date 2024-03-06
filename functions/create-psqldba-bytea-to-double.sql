-- Convert a bytea: 4 or 8 bytes, little-endian or big-endian to a double.
-- The `endianess` values can be: 'LE' or 'BE'.
CREATE OR REPLACE FUNCTION psqldba_bytea_to_double(bytes BYTEA, endianess TEXT)
RETURNS DOUBLE PRECISION AS $$
DECLARE
  byte_array INTEGER ARRAY;
  byte_count SMALLINT;
  binary_value BIT VARYING(64);
  binary_consts BIT VARYING(64) ARRAY;
  sign CHARACTER(1);
  exponent BIT VARYING(11);
  exp SMALLINT;
  exp_max SMALLINT;
  mantissa BIT VARYING(52);
  mantissa_index SMALLINT;
  mantissa_max SMALLINT;
  return_value DOUBLE PRECISION;
BEGIN
  -- validate argument values
  byte_count := length(bytes);
  IF byte_count <> 4 AND byte_count <> 8 THEN
    RAISE EXCEPTION 'Invalid `bytes` argument length: % | Expecting: 4 or 8', bytes;
  END IF;
  IF endianess <> 'LE' AND endianess <> 'BE' THEN
    RAISE EXCEPTION 'Invalid `endianess` argument value % | Expecting: LE or BE', endianess;
  END IF;

  -- set index bounderies
  IF byte_count = 4 THEN
    exp_max = 8;
    mantissa_max = 23;
  ELSE
    exp_max = 11;
    mantissa_max = 52;
  END IF;

  -- construct byte array
  FOR i IN 1..byte_count LOOP
    byte_array[i - 1]:= get_byte(bytes, i - 1);
  END LOOP;

  -- construct bit sequence accordingly to endianness
  binary_value := '';
  IF endianess = 'BE' THEN
    FOR i IN 1..byte_count LOOP
      binary_value := binary_value || byte_array[i - 1]::bit(8);
    END LOOP;
  ELSE
    FOR i IN 1..byte_count LOOP
      binary_value := binary_value || byte_array[byte_count - i]::bit(8);
    END LOOP;
  END IF;
  
  -- generate 32 bit or 64 bit binary zeros
  binary_consts[0] := lpad('', byte_count * 8, '0')::bit varying;
  binary_consts[1] := lpad('1', (byte_count * 8) - 1, '0')::bit varying;
  -- exponent max, 8 or 11 bits
  binary_consts[2] := lpad('', exp_max, '1')::bit varying;
  -- mantissa min, 23 bits or 52 bits
  binary_consts[3] := lpad('', mantissa_max, '0')::bit varying;

  IF binary_value = binary_consts[0] OR binary_value = binary_consts[1] THEN
    RETURN 0.0;
  END IF;

  sign := substring(binary_value from 1 for 1);
  exponent := substring(binary_value from 2 for exp_max);
  mantissa := substring(binary_value from (2 + exp_max) for mantissa_max);

  IF exponent = binary_consts[2] THEN
    IF mantissa = binary_consts[3] THEN   -- IEEE754-1985 negative and positive infinity
      IF sign = '1' THEN
          RETURN '-Infinity';
      ELSE
          RETURN 'Infinity';
      END IF;
    ELSE
      RETURN 'NaN'; -- IEEE754-1985 Not a number
    END IF; 
  END IF;

  exp := lpad(exponent::text, 16, '0')::bit(16)::integer;
  IF byte_count = 4 THEN
    IF exp > 126 THEN
      exp := exp - 127;
    ELSE
      exp:= -exp;
    END IF;
  ELSE
    IF exp > 1022 THEN
      exp := exp - 1023;
    ELSE
      exp:= -exp;
    END IF;
  END IF;

  return_value := 1.0;
  mantissa_index := 1;
  WHILE mantissa_index < mantissa_max + 1 LOOP
    IF substring(mantissa from mantissa_index for 1) = '1' THEN
      return_value := return_value + power(2, -(mantissa_index))::double precision;
    END IF;
    mantissa_index = mantissa_index + 1;
  END LOOP;

  return_value := return_value * power(2, exp)::double precision;

  IF sign = '1' THEN
    return_value = -return_value;
  END IF;

  RETURN return_value;
END;
$$ LANGUAGE plpgsql;
