-- Pregunta
-- ===========================================================================
-- 
-- Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
-- la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
-- columna 3 separados por coma. La tabla debe estar ordenada por las 
-- columnas 1, 2 y 3.
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 
fs -rm -f -r output;
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

-- Gestion de archivos del sistema local al HDFS
fs -rm -f -r input
fs -mkdir input
fs -put data.tsv input/data.tsv

-- carga de datos
lines = LOAD 'input/data.tsv' AS (clave:CHARARRAY, reg1:BAG{t:(p:CHARARRAY)}, reg2:MAP[]);

-- Los campos del archivo puden ser indicados por nombre
-- o por posición iniciando en 0
--
x = FOREACH lines GENERATE clave, SIZE(reg1), SIZE(reg2);
y = ORDER x BY $0, $1, $2;

-- escribe el archivo de salida
STORE y INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .