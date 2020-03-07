-- Pregunta
-- ===========================================================================
-- 
-- Obtenga los cinco (5) valores más pequeños de la 3ra columna.
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
lines = LOAD 'input/data.tsv' AS (clave:CHARARRAY, fecha:CHARARRAY, valor:INT);

-- filtrar y ordenar
y = FOREACH lines GENERATE valor;
x = ORDER y BY $0;
z = LIMIT x 5;

-- escribe el archivo de salida
STORE z INTO 'output';

-- copia los archivos del HDFS al sistema local
fs -get output/ .