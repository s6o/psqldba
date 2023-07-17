-- Source: https://gist.github.com/ruckus/5718112#start-of-content
--
-- 'heap_blks_hit' = the number of blocks that were satisfied from the page cache
-- 'heap_blks_read' = the number of blocks that had to hit disk/IO layer for reads
--
-- When 'heap_blks_hit' is significantly greater than 'heap_blks_read' than it means
-- we have a well-cached DB and most of the queries can be satisfied from the cache

SELECT
  relname
, cast(heap_blks_hit as numeric) / (heap_blks_hit + heap_blks_read) AS hit_pct
, heap_blks_hit
, heap_blks_read
FROM pg_statio_user_tables
WHERE (heap_blks_hit + heap_blks_read) > 0
ORDER BY hit_pct
;

