
-- carga de datos
lines = LOAD 'data.tsv' AS (clave:CHARARRAY, reg1:BAG{t:(p:CHARARRAY)}, reg2:MAP[]);

-- genera una tabla llamada words con una palabra por registro
words = FOREACH lines GENERATE FLATTEN(reg1) AS word;

-- agrupa los registros que tienen la misma palabra
grouped = GROUP words BY word;

-- genera una variable que cuenta las ocurrencias por cada grupo
wordcount = FOREACH grouped GENERATE group, COUNT(words);

-- escribe el archivo de salida
STORE wordcount INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get output/ .
