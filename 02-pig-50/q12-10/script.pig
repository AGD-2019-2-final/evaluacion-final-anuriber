
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
    
x = FOREACH dataTable GENERATE apellido, num;

y1 = FILTER x BY (apellido matches '.*D.*');
y2 = FILTER x BY (apellido matches '.*E.*');
y3 = FILTER x BY (apellido matches '.*F.*');
y4 = FILTER x BY (apellido matches '.*G.*');
y5 = FILTER x BY (apellido matches '.*H.*');
y6 = FILTER x BY (apellido matches '.*I.*');
y7 = FILTER x BY (apellido matches '.*J.*');
y8 = FILTER x BY (apellido matches '.*K.*');
s = UNION y1, y2, y3, y4, y5, y6, y7, y8;

y = ORDER s BY $1;
z = FOREACH y GENERATE $0;

-- escribe el archivo de salida
STORE z INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
