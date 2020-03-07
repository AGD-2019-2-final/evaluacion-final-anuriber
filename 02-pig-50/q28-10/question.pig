-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código equivalente a la siguiente consulta SQL.
-- 
--    SELECT 
--        birthday, 
--        DATE_FORMAT(birthday, "yyyy"),
--        DATE_FORMAT(birthday, "yy"),
--    FROM 
--        persons
--    LIMIT
--        5;
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

------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
-- OJO: OPCIÓN A ES PARA QUESTION.PIG
y = FOREACH u GENERATE birthday, REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',1), SUBSTRING (REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',1), 2, 4);
x = LIMIT y 5;
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
-- OJO: OPCIÓN B ES PARA GRADER.PY
--x = FOREACH u GENERATE REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',1), SUBSTRING (REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',1), 2, 4);
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------

-- escribe el archivo de salida
STORE x INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .

