/*
SELECT ROWID FROM R;
SELECT ROWID FROM R2;
*/

/*
SELECT * FROM R2;
SELECT i from R2;
SELECT j FROM R2;
SELECT k FROM R2;
*/

--CREATE INDEX index_secondaire ON R2(j);
--CREATE INDEX index_fonction ON R2(i+j);

SELECT j FROM R2;
SELECT i+j FROM R2;

ANALYZE INDEX index_secondaire VALIDATE STRUCTURE;
SELECT LF_BLKS+BR_BLKS FROM INDEX_STATS;
ANALYZE INDEX index_fonction VALIDATE STRUCTURE;
SELECT LF_BLKS+BR_BLKS FROM INDEX_STATS;
SELECT Index_name, index_type FROM USER_INDEXES;
ANALYZE TABLE R COMPUTE STATISTICS;
SELECT table_name, BLOCKS FROM user_tables;