-- Source: https://russ.garrett.co.uk/2015/10/02/postgres-monitoring-cheatsheet/
-- The number of connections blocked waiting for a lock can be an indicator of a slow transaction with an exclusive lock.

SELECT
  count(distinct pid)
FROM pg_locks
WHERE granted = false
;
