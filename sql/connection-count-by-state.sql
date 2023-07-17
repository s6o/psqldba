-- Source: https://russ.garrett.co.uk/2015/10/02/postgres-monitoring-cheatsheet/
--
-- The possible states of interest are:
-- active                        | Connections currently executing queries. A large number tends to indicate DB slowness.
-- idle                          | Idle connections, not in a transaction.
-- idle in transaction           | Connections with an open transaction, not executing a query. Lots of these can indicate long-running transactions.
-- idle in transaction (aborted) | Connection is in a transaction, but an error has occurred and the transaction hasn’t been rolled back. 
--

SELECT
  state
, count(*)
FROM pg_stat_activity
GROUP BY state
;
