
--
-- Carga el archivo desde el disco duro
--
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
    
x = FOREACH u GENERATE birthday, REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',1), SUBSTRING (REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',1), 2, 4);

-- escribe el archivo de salida
STORE x INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
