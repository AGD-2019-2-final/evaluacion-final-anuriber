
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
    
x = FOREACH u GENERATE birthday;
y = FOREACH x GENERATE REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',2);

-- escribe el archivo de salida
STORE y INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
