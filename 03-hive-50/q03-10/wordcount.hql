
DROP TABLE IF EXISTS docs;
DROP TABLE IF EXISTS dataTable;
DROP TABLE IF EXISTS testTable; 

CREATE TABLE docs (line STRING);
LOAD DATA INPATH "/tmp/wordcount/*" OVERWRITE INTO TABLE docs;

CREATE TABLE dataTable (letra STRING, fecha STRING, valor STRING);

INSERT OVERWRITE TABLE dataTable 
SELECT 
    regexp_extract(line, '^(?:([^\t]*)\t?){1}', 1) AS letra, 
    regexp_extract(line, '^(?:([^\t]*)\t?){2}', 1) AS fecha, 
    regexp_extract(line, '^(?:([^\t]*)\t?){3}', 1) AS valor
FROM
    docs;
    


CREATE TABLE testTable (numero INT);

INSERT OVERWRITE TABLE testTable 
SELECT 
    CAST(valor AS INT) AS numero
FROM
    dataTable;

INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

SELECT numero FROM testTable GROUP BY numero ORDER BY numero LIMIT 5;
