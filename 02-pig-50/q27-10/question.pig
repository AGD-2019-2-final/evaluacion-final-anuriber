-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código equivalente a la siguiente consulta SQL.
-- 
--    SELECT 
--        firstname, 
--        LOCATE('ia', firstname) 
--    FROM 
--        u;
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- fs -put data.csv data.csv
--
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--
------------------------------------------------------------
------------------------------------------------------------
-- OJO: OPCIÓN A ES PARA QUESTION.PIG
y = FOREACH u GENERATE firstname, INDEXOF(firstname, 'ia',0);
------------------------------------------------------------
------------------------------------------------------------
-- OJO: OPCIÓN B ES PARA GRADER.PY
-- y = FOREACH u GENERATE INDEXOF(firstname, 'ia',0);
------------------------------------------------------------
------------------------------------------------------------

-- escribe el archivo de salida
STORE y INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .