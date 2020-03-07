-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.csv` escriba una consulta en Pig que genere la 
-- siguiente salida:
-- 
--   Vivian@Hamilton
--   Karen@Holcomb
--   Cody@Garrett
--   Roth@Fry
--   Zoe@Conway
--   Gretchen@Kinney
--   Driscoll@Klein
--   Karyn@Diaz
--   Merritt@Guy
--   Kylan@Sexton
--   Jordan@Estes
--   Hope@Coffey
--   Vivian@Crane
--   Clio@Noel
--   Hope@Silva
--   Ayanna@Jarvis
--   Chanda@Boyer
--   Chadwick@Knight
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--

-- Gestion de archivos del sistema local al HDFS
fs -rm -f -r input
fs -mkdir input
fs -put data.csv input/data.csv

-- Carga el archivo desde el disco duro
--
dataTable = LOAD 'input/data.csv' USING PigStorage(',')
    AS (num:INT,
        nombre:CHARARRAY,
        apellido:CHARARRAY,
        eventType:CHARARRAY,
        fecha:CHARARRAY,
        color:CHARARRAY,
        idnum:INT);
    
x = FOREACH dataTable GENERATE nombre,apellido;

-- escribe el archivo de salida
STORE x INTO 'output' USING PigStorage('@');

-- copia los archivos del HDFS al sistema local
fs -get output/ .