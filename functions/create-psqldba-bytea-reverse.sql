CREATE OR REPLACE FUNCTION psqldba_bytea_reverse(bytea)
RETURNS bytea AS $$
  SELECT string_agg(byte,''::bytea)
  FROM (
    SELECT substr($1, i, 1) byte
    FROM generate_series(length($1), 1 , -1) i
  ) s
$$ LANGUAGE sql;
