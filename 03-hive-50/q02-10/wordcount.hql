
DROP TABLE IF EXISTS docs;
DROP TABLE IF EXISTS dataTable; 

CREATE TABLE docs (line STRING);
LOAD DATA LOCAL INPATH "data.tsv" OVERWRITE INTO TABLE docs;

CREATE TABLE dataTable (letra STRING, fecha STRING, valor STRING);

INSERT OVERWRITE TABLE dataTable 
SELECT 
    regexp_extract(line, '^(?:([^\t]*)\t?){1}', 1) AS letra, 
    regexp_extract(line, '^(?:([^\t]*)\t?){2}', 1) AS fecha, 
    regexp_extract(line, '^(?:([^\t]*)\t?){3}', 1) AS valor
FROM
    docs;

INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT letra,fecha, CAST(valor AS INT)
FROM
    dataTable
ORDER BY
    letra,
    valor;
