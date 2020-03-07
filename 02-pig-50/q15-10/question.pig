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
--        color
--    FROM 
--        u 
--    WHERE color = 'blue' AND firstname LIKE 'Z%';
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- fs -put data.csv data.csv
--
-- carga de datos
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

x = FOREACH u GENERATE firstname, color;
y = FILTER x BY color MATCHES 'blue';
z = FILTER y BY firstname MATCHES 'Z.*';

-- escribe el archivo de salida
STORE z INTO 'output' USING PigStorage(' ');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
