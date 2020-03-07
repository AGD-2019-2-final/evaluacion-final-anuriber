
-- carga de datos
lines = LOAD 'data.tsv' AS (clave:CHARARRAY, fecha:CHARARRAY, valor:INT);

-- filtrar y ordenar
y = FOREACH lines GENERATE valor;
x = ORDER y BY $0;
z = LIMIT x 5;

-- escribe el archivo de salida
STORE z INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get output/ .
