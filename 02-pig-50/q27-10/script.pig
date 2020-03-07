
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
    
y = FOREACH u GENERATE firstname, INDEXOF(firstname, 'ia',0);

-- escribe el archivo de salida
STORE y INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
