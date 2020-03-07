
-- carga de datos
lines = LOAD 'data.tsv' AS (clave:CHARARRAY, fecha:CHARARRAY, valor:INT);

-- ordenar
y = ORDER lines BY $0, $2;

-- escribe el archivo de salida
STORE y INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get output/ .
