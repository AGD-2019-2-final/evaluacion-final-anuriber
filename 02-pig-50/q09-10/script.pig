
-- Carga el archivo desde el disco duro
--
dataTable = LOAD 'data.csv' USING PigStorage(',')
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
