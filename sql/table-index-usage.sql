-- Source: https://gist.github.com/ruckus/5718112#start-of-content
-- For each row, because "idx_tup_pct" is low than it means that essentially no indexes are being used.
-- In the case of "facebook_oauths" it turns out we are commonly running a query like:
-- "SELECT * FROM facebook_oauths WHERE fb_user_id = X" and it turns out there isnt an index on "fb_user_id"

SELECT 
  relname
, seq_tup_read
, idx_tup_fetch
, cast(idx_tup_fetch AS numeric) / (idx_tup_fetch + seq_tup_read) AS idx_tup_pct
FROM pg_stat_user_tables
WHERE (idx_tup_fetch + seq_tup_read) > 0
ORDER BY idx_tup_pct
;

