-- Source: https://russ.garrett.co.uk/2015/10/02/postgres-monitoring-cheatsheet/
--
-- Long-running transactions are bad because they prevent Postgres from vacuuming old data.
-- This causes database bloat and, in extreme circumstances, shutdown due to transaction ID (xid) wraparound.
-- Transactions should be kept as short as possible, ideally less than a minute.
-- Alert if this number gets greater than an hour or so.
--
-- https://www.postgresql.org/docs/14/routine-vacuuming.html#VACUUM-FOR-WRAPAROUND

SELECT max(now() - xact_start)
FROM pg_stat_activity
WHERE state IN ('idle in transaction', 'active')
;
