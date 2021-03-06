
DROP TABLE IF EXISTS t0;
CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;


DROP TABLE IF EXISTS dataT; 
CREATE TABLE dataT (c2 ARRAY<CHAR(1)>, registro STRING);
INSERT OVERWRITE TABLE dataT
SELECT
    c2,
    clave
FROM
    t0
LATERAL VIEW
    explode(c3) t0 AS clave,valor;
    
    
DROP TABLE IF EXISTS dataTable; 
CREATE TABLE dataTable (letra STRING, registro STRING);
INSERT OVERWRITE TABLE dataTable
SELECT
    letra,
    registro
FROM
    dataT
LATERAL VIEW
    explode(c2) dataT AS letra
ORDER BY
    letra,
    registro;
    
DROP TABLE IF EXISTS word_counts;
CREATE TABLE word_counts
AS
    SELECT word2, word1, count(1) AS count
    FROM
        (SELECT letra AS word1, registro AS word2 FROM dataTable) w
GROUP BY
    word1, word2
ORDER BY
    word1;
    
INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

SELECT word1, word2, count FROM word_counts ORDER BY word1, word2;
