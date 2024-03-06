-- Source: https://gist.github.com/ruckus/5718112#start-of-content
--
-- 'heap_blks_hit' = the number of blocks that were satisfied from the page cache
-- 'heap_blks_read' = the number of blocks that had to hit disk/IO layer for reads
--
-- When 'heap_blks_hit' is significantly greater than 'heap_blks_read' than it means
-- we have a well-cached DB and most of the indexes can be satisfied from the cache

SELECT
  indexrelname
, cast(idx_blks_hit as numeric) / (idx_blks_hit + idx_blks_read) AS hit_pct
, idx_blks_hit
, idx_blks_read
FROM pg_statio_user_indexes
WHERE (idx_blks_hit + idx_blks_read) > 0
ORDER BY hit_pct
;
