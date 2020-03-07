
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
    
x = FOREACH u GENERATE firstname, color;
y = FILTER x BY color MATCHES 'blue';
z = FILTER y BY firstname MATCHES 'Z.*';

-- escribe el archivo de salida
STORE z INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
