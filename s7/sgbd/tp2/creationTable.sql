DROP TABLE R;
CREATE Table R (
    i INTEGER,
    j INTEGER,
    k INTEGER,
    PRIMARY KEY (i)
);

INSERT INTO R VALUES (3, 3, 3);
INSERT INTO R VALUES (2, 2, 2);
INSERT INTO R VALUES (5, 5, 5);
INSERT INTO R VALUES (1, 1, 1);
INSERT INTO R VALUES (4, 4, 4);
INSERT INTO R VALUES (8, 8, 8);
INSERT INTO R VALUES (7, 7, 7);
INSERT INTO R VALUES (9, 9, 9);
INSERT INTO R VALUES (6, 9, 6);
-- 
-- --Requêtes demandées:
-- 
-- SELECT * FROM R;
-- SELECT i FROM R;
-- SELECT j FROM R;
-- SELECT k FROM R;
-- 
-- --Vérification hypothèses
-- 
--  SELECT Index_Name, Column_name, Descend
--  FROM USER_IND_COLUMNS
--  WHERE Table_Name='R';
-- 
-- -- index Secondaire
-- 
--  CREATE INDEX index_j ON R (j);
-- SELECT * FROM R;
-- SELECT i FROM R;
-- SELECT j FROM R;
-- SELECT k FROM R;
-- SELECT j FROM R WHERE j>5;
-- SELECT k FROM R WHERE k>5;
-- SELECT j FROM R WHERE k>5;

-- ANALYZE INDEX index_j VALIDATE STRUCTURE;
-- SELECT height, name FROM INDEX_STATS;

-- ALTER INDEX index_j DEALLOCATE UNUSED;