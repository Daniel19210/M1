-- Question 1
--SELECT value FROM V$PARAMETER WHERE name ='db_block_size'

-- Question 2
-- SELECT Tablespace_name, pct_increase, Contents, extent_management, Segment_Space_Management
-- FROM DBA_TABLESPACES;
SELECT file_name, bytes, blocks, autoextensible, Increment_by
FROM DBA_DATA_FILES;