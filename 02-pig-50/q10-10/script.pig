
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
    
x = FOREACH dataTable GENERATE apellido, SIZE(apellido);
y = ORDER x BY $1 DESC, $0 ASC;
s = LIMIT y 5;

-- escribe el archivo de salida
STORE s INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
