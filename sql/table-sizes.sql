SELECT
  schema_name
, relname
, pg_size_pretty(table_size) AS size
, pg_size_pretty(table_size_indecies) AS size_with_indecies
FROM (
  SELECT
    pg_catalog.pg_namespace.nspname AS schema_name
  , relname
  , pg_relation_size(pg_catalog.pg_class.oid) AS table_size
  , pg_total_relation_size(pg_catalog.pg_class.oid) AS table_size_indecies
  FROM pg_catalog.pg_class
    JOIN pg_catalog.pg_namespace ON relnamespace = pg_catalog.pg_namespace.oid
) t
WHERE schema_name NOT LIKE 'pg_%'
ORDER BY table_size DESC
;

