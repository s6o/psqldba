-- Source: https://gist.github.com/ruckus/5718112#start-of-content
--
-- Show sizes & usage of indexes that are not used very often.
-- We define 'usage' by # of times used, in this case we use '200' - change accordingly

SELECT
  idstat.relname AS table_name
, indexrelname AS index_name
, idstat.idx_scan AS times_used
, pg_size_pretty(pg_relation_size(tabstat.relid)) AS table_size
, pg_size_pretty(pg_relation_size(indexrelid)) AS index_size
, n_tup_upd + n_tup_ins + n_tup_del AS num_writes
, indexdef AS definition
FROM pg_stat_user_indexes AS idstat JOIN pg_indexes ON indexrelname = indexname
JOIN pg_stat_user_tables AS tabstat ON idstat.relname = tabstat.relname
WHERE 
  idstat.idx_scan < 200
  AND indexdef !~* 'unique'
ORDER BY
  idstat.relname
, indexrelname
;
