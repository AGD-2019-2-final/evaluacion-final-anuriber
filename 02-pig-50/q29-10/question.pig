-- 
-- Pregunta
-- ===========================================================================
-- 
-- Para responder la pregunta use el archivo `data.csv`.
-- 
-- Escriba el código en Pig para manipulación de fechas que genere la siguiente 
-- salida.
-- 
--    1971-07-08,jul,07,7
--    1974-05-23,may,05,5
--    1973-04-22,abr,04,4
--    1975-01-29,ene,01,1
--    1974-07-03,jul,07,7
--    1974-10-18,oct,10,10
--    1970-10-05,oct,10,10
--    1969-02-24,feb,02,2
--    1974-10-17,oct,10,10
--    1975-02-28,feb,02,2
--    1969-12-07,dic,12,12
--    1973-12-24,dic,12,12
--    1970-08-27,ago,08,8
--    1972-12-12,dic,12,12
--    1970-07-01,jul,07,7
--    1974-02-11,feb,02,2
--    1973-04-01,abr,04,4
--    1973-04-29,abr,04,4
-- 
-- Escriba el resultado a la carpeta `output` del directorio actual.
-- 

fs -rm -f -r output;
--
-- fs -put data.csv data.csv
--
u = LOAD 'data.csv' USING PigStorage(',') 
    AS (id:int, 
        firstname:CHARARRAY, 
        surname:CHARARRAY, 
        birthday:CHARARRAY, 
        color:CHARARRAY, 
        quantity:INT);
--
-- >>> Escriba su respuesta a partir de este punto <<<
--

/*
Se escribe un archivo con el contenido de los meses
%%writefile meses.txt
1	ene
2	feb
3	mar
4	abr
5	may
6	jun
7	jul
8	ago
9	sep
10	oct
11	nov
12	dic
*/

-- Gestion de archivos del sistema local al HDFS
fs -rm -f -r input
fs -mkdir input
fs -put meses.txt input/meses.txt

m = LOAD 'input/meses.txt' USING PigStorage()
    AS (num_f:INT,
        mes_f:CHARARRAY);
        
x = FOREACH u GENERATE id, birthday, REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',2) AS mes;
y = FOREACH x GENERATE id, birthday, mes, mes as (numMes:INT);

TempR4 = JOIN y BY numMes, m BY num_f;
r4 = FOREACH TempR4 GENERATE id, birthday, mes_f, mes, mes as (numMes2:INT);
r5 = ORDER r4 BY id;
r6 = FOREACH r5 GENERATE birthday, mes_f, mes, numMes2;

-- escribe el archivo de salida
STORE r6 INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .