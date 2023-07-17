-- Source: https://gist.github.com/ruckus/5718112#start-of-content

SELECT
  schemaname
, relname
, indexrelname
, idx_scan
, pg_size_pretty(pg_relation_size(i.indexrelid)) AS index_size
FROM
  pg_stat_user_indexes i
  JOIN pg_index USING (indexrelid)
WHERE
  indisunique IS false
ORDER BY
  idx_scan
, relname
;
