-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Obtenga los apellidos que empiecen por las letras entre la 'd' y la 'k'. La 
-- salida esperada es la siguiente:
-- 
--   (Hamilton)
--   (Holcomb)
--   (Garrett)
--   (Fry)
--   (Kinney)
--   (Klein)
--   (Diaz)
--   (Guy)
--   (Estes)
--   (Jarvis)
--   (Knight)
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
x = FOREACH u GENERATE surname, id;

y1 = FILTER x BY (surname matches '.*D.*');
y2 = FILTER x BY (surname matches '.*E.*');
y3 = FILTER x BY (surname matches '.*F.*');
y4 = FILTER x BY (surname matches '.*G.*');
y5 = FILTER x BY (surname matches '.*H.*');
y6 = FILTER x BY (surname matches '.*I.*');
y7 = FILTER x BY (surname matches '.*J.*');
y8 = FILTER x BY (surname matches '.*K.*');
s = UNION y1, y2, y3, y4, y5, y6, y7, y8;

y = ORDER s BY $1;
z = FOREACH y GENERATE $0;

-- escribe el archivo de salida
STORE z INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .