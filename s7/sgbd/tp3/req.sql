--SELECT Blocks
--FROM user_tables
--WHERE table_name='T';

-- SELECT vsize(i) + NVL(vsize(a), 0) + NVL(vsize(b), 0) + NVL(vsize(c), 0) +NVL(vsize(d), 0) + NVL(vsize(e), 0)
-- FROM T;

-- column a noprint
-- column b noprint
-- column c noprint
-- column d noprint
-- column e noprint
-- SELECT * FROM T;
-- 
-- SELECT a.name, b.value
-- FROM v$statname a, v$mystat b
-- WHERE a.statistic# = b. statistic# AND lower(a.name) ='table fetch continued row';
-- 
-- UPDATE T SET a = 'z1', b = 'z2', c = 'z3' WHERE i = 3;
-- COMMIT;
-- SELECT * FROM T;
-- SELECT a.name, b.value
-- FROM v$statname a, v$mystat b
-- WHERE a.statistic# = b. statistic# AND lower(a.name) ='table fetch continued row';
-- 
-- UPDATE T SET a = 'y1', b = 'y2', c = 'y3' WHERE i = 2;
-- COMMIT;
-- SELECT * FROM T;
-- SELECT a.name, b.value
-- FROM v$statname a, v$mystat b
-- WHERE a.statistic# = b. statistic# AND lower(a.name) ='table fetch continued row';
-- 
-- UPDATE T SET a = 'w1', b = 'w2', c = 'w3' WHERE i = 1;
-- COMMIT;
-- SELECT * FROM T;
-- SELECT a.name, b.value
-- FROM v$statname a, v$mystat b
-- WHERE a.statistic# = b. statistic# AND lower(a.name) ='table fetch continued row';
-- 
-- SELECT * FROM T WHERE i = 3;
-- SELECT a.name, b.value
-- FROM v$statname a, v$mystat b
-- WHERE a.statistic# = b. statistic# AND lower(a.name) ='table fetch continued row';
-- 
-- SELECT * FROM T WHERE i = 1;
-- SELECT a.name, b.value
-- FROM v$statname a, v$mystat b
-- WHERE a.statistic# = b. statistic# AND lower(a.name) ='table fetch continued row';
-- 
-- SELECT i, a FROM T;
-- SELECT a.name, b.value
-- FROM v$statname a, v$mystat b
-- WHERE a.statistic# = b. statistic# AND lower(a.name) ='table fetch continued row';

-- SELECT NUM_ROWS
-- FROM user_tables
-- WHERE table_name='T'
-- GROUP BY Blocks;
-- ALTER TABLE T MOVE;

SELECT COUNT(*)
FROM user_tables
WHERE table_name='T'
GROUP BY Blocks;