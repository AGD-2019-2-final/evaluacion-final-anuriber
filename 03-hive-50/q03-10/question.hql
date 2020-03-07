-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Escriba una consulta que devuelva los cinco valores diferentes más pequeños 
-- de la tercera columna.
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
DROP TABLE IF EXISTS docs;
DROP TABLE IF EXISTS dataTable;
DROP TABLE IF EXISTS testTable; 

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
    


CREATE TABLE testTable (numero INT);

INSERT OVERWRITE TABLE testTable 
SELECT 
    CAST(valor AS INT) AS numero
FROM
    dataTable;

INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

SELECT numero FROM testTable GROUP BY numero ORDER BY numero LIMIT 5;

!hadoop fs -copyToLocal /tmp/output output