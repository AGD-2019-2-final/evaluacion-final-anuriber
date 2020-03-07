
-- carga de datos
lines = LOAD 'data.tsv' AS (clave:CHARARRAY, reg1:BAG{t:(p:CHARARRAY)}, reg2:MAP[]);

-- Los campos del archivo puden ser indicados por nombre
-- o por posición iniciando en 0
--
x = FOREACH lines GENERATE clave, SIZE(reg1), SIZE(reg2);
y = ORDER x BY $0, $1, $2;

-- escribe el archivo de salida
STORE y INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
