--QUESTION 1
SELECT table_name, column_name, Data_type, Data_length, Data_precision, Nullable
FROM USER_TAB_COLUMNS;

--QUESTION 2
SELECT tablespace_name 
FROM ALL_TABLES
WHERE OWNER = 'NomUtil'
UNION
SELECT tablespace_name
FROM ALL_INDEXES
WHERE OWNER = 'NomUtil' ;

--QUESTION 3
show parameter --- => montre tout les param de la BDD avec type+valeur
--- si param bool => false/true
--- si param entier => taille table.

SELECT value
FROM VsPARAMETER
WHERE name='db_block_size';

--QUESTION 4
SELECT Segment_name, Blocks
FROM USER_SEGMENTS
WHERE Segment_TYPE = 'TABLE';

--QUESTION 5
SELECT y.table_name, Blocks
FROM USER_segment x, USER_indexes y
WHERE x.segement_name = y.index_name AND y.table_type = 'TABLE'

--QUESTION 6
SELECT COUNT(*), Segment_name
FROM USER_segment
WHERE Segment_TYPE = 'TABLE'
GROUP BY Segment_name;

--QUESTION 7
SELECT tablespace_name.COUNT(*)
FROM USER_TABLES
GROUP BY tablespace_name;

--QUESTION 8
SELECT tablespace_name,
       COUNT(*) as extents_libre,
       round(AVG(blocks)),
       round(AVG(Bytes)),
       MIN(blocks),
       MAX(blocks),
       SUM(blocks)
FROM USER_FREE_SPACE
GROUP BY tablespace_name;

--QUESTION 9
SELECT f.file_id,
       f.file_name,
       SUM(s.blocks)_taille_disponible

FROM USER_FREE_SPACE s, DBA_DATA_FILES f
WHERE s.file_id = f.filSQL synthaxe_id
GROUP BY f.file_id, f.file_name;

--QUESTION 10
SELECT f.file_id, f.file_name, SUM(e.blocks)_taille_occupee
FROM DBA_DATA_FILES f, dba_EXTENTS e
WHERE f.file_id = e.file_id AND e.owner = 'UserName'
GROUP BY f.file_id, f.file_name;

--QUESTION 11
SELECT e.segment_name, f.file_name, (sum(e.blocks)/u.blocks) *100 as répartition
FROM dba_segment u, dba_data_files f, dba_extents, dba_EXTENTS
WHERE u.segment_name = e.segment_name
AND e.file_id = f.file_id
GROUP BY e.segment_name, f.file_name, u.blocks;

--QUESTION 12
SELECT s.segment_name
FROM user_segments s, user_extents e
WHERE s.segment_name = e.segment_name
AND s.extents > 5
AND e.bytes < 10240;

-- OU

SELECT e.segment_name
FROM user_extents e
WHERE bytes < 1024
GROUP BY e.segment_name
HAVING COUNT(*) > 5

-- 2façons de faire cette requete, soit avec la table des extents, soit avec la table des segments

--QUESTION 13
SELECT t.tablespace_name, nvl(sum(s.blocks), 0) as taille_occupee
FROM user_tablespace t, user_segments s
WHERE t.tablespace_name = s.tablespace_name(+)
GROUP BY t.tablespace_name;

--QUESTION 14
SELECT tablespace_name, 'de ',
TRUNC(blocks/5000, 0)* 5000,
'jusqu a', (TRUNC(blocks/5000, 0) +1) * 5000,
COUNT(*) as blocks_libre
FROM user_free_space u
GROUP BY tablespace_name, blocks;

--OU

SELECT tablespace_name, tailles_extents, COUNT(*)
FROM (SELECT CASE WHEN blocks between  and 5000 then '0-5000'
             when blocks between 5000 and 10000 then '5000-10000'
             when blocks > 10000 then '> 10000'
      end tailles_extents,
             u.tablespace_nSQL synthaxame, u.blocks
FROM user_free_space u)
GROUP BY tablespace_name, tailles_extents;

--QUESTION 15
SELECT SUM(vsize(etu_id)), SUM(vsize(etu_name)), SUM(vsize(etu_note))
FROM etudiant;

--QUESTION 16
SELECT SUM(vsize(etu_id))+ SUM(vsize(etu_name))+ SUM(vsize(etu_note))+ 5 * COUNT(*) + blocks * 50 / 4096
FROM etudiant, dba_segment
WHERE segment_name = 'ETUDIANT'
GROUP BY blocks;

--QUTESION 17
SELECT DBMS_ROWID.ROWID_BLOCK_NUMER5(ROWID) "Bloc",
       DBMS_ROWID.ROWID_OBJECT(ROWID) "N° d'objet", --att. Object_Id de la table ALL_OBJECT
       DBMS_ROWID.ROWID_RELATIVE_FNO(ROWID) "Numéro de fichier relatif",
       DBMS_ROWID.ROWID_ROW_NUMBER(ROWID) "Numéro de ligne dans le bloc",
       DBMS_ROWID.ROWID_TYPE(ROWID) "Type"
FROM etudiant;

SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(e1.ROWID) "Bloc"
FROM etudiant e1
GROUP BY DBMS_ROWID.ROWID_BLOCK_NUMBER(ROWID)
HAVING (SELECT SUM(vsize(etu_id))+ SUM(vsize(etu_name))+ SUM(vsize(etu_note)) + 5 * COUNT(*)
        FROM etudiant e2
        WHERE DBMS_ROWID.ROWID_BLOCK_NUMBER(e1.ROWID) = 
              DBMS_ROWID.ROWID_BLOCK_NUMBER(e2.ROWID)) < (4096 / 4) * 3 - 50; -- 3022

--QUESTION 18
CREATE TABLE T_BLOC (block_id) as
SELECT DBMS_ROWID.ROWID_BLOCK_NUMBER(e1.ROWID)
FROM user_tables u, etudiant e1,
WHERE u.table_name = 'ETUDIANT'
GROUP BY DBMS_ROWID.ROWID_BLOCK_NUMBER(e1.ROWID), nvl(u.PCT_USED, 0)
HAVING nvl(u.PCT_USED, 0) < (
       SELECT (SUM(vsize(etu_id))+ SUM(vsize(etu_name))+ SUM(vsize(etu_note)) + 5 * COUNT(*)) / 4096 * 100
       FROM etudiant e2
       WHERE DBMS_ROWID.ROWID_BLOCK_NUMBER(e1.ROWID) = 
              DBMS_ROWID.ROWID_BLOCK_NUMBER(e2.ROWID));

--QUESTION 19
SELECT SUM(decode(substr (segment_type, 1, 5), 'TABLE', bytes/1024/1024)) as partie_tables,
       SUM(decode(substr (segment_type, 1, 5), 'INDEX', bytes/1024/1024)) as partie_index
FROM user_segments;

--QUESTION 20
SELECT u.table_name, u.next_extent * POWER(1+(nvl(u.pct_increase, 0)/100), count(*) - 2) as taille_dernier_extent
FROM user_tables u, user_extents e
WHERE u.table_name = e.segment_name
GROUP BY u.table_name, nvl(u.pct_increase, 0), u.next_extent
HAVING COUNT(*) > 1;

--QUESTION 21
SELECT u.table_name
FROM user_tables u
WHERE not exists(SELECT 1 FROM user_free_space f WHERE f.tablespace_name = u.tablespace_name --la verification est necessaire pour dba_table
                                                 AND f.blocks * 4096 >= u.next_extent)
OR
u.max_extents = (SELECT COUNT(*) from user_extents e WHERE e.segment_name = u.table_name);

--QUESTION 22
SPOOL destruction
SELECT 'select drop' || table_name || ' ;' 
FROM all_tables
WHERE owner = 'USERNAME';
SPOOL off

--QUESTION 23
SELECT USER as nom, userenv('TERMINAL') as client,
userenv('SESSIONID') || '-' || userenv('ENTYID') as session_courante
from dual;
--OU
SELECT * FROM v$session;