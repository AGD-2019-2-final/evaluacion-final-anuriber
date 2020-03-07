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
    

x = FOREACH u GENERATE id, birthday, REGEX_EXTRACT(birthday, '(.*)-(.*)-(.*)',3) AS dia;
y = FOREACH x GENERATE id, birthday, dia, dia as (numDia:INT), ToString(ToDate(birthday,'yyyy-MM-dd'), 'EEE' ) AS diaSem;


/*
%%writefile diasSemana.txt
Mon	lun	lunes
Tue	mar	martes
Wed	mie	miercoles
Thu	jue	jueves
Fri	vie	viernes
Sat	sab	sabado
Sun	dom	domingo
*/

-- Gestion de archivos del sistema local al HDFS
fs -rm -f -r input
fs -mkdir input
fs -put diasSemana.txt input/diasSemana.txt

m = LOAD 'input/diasSemana.txt' USING PigStorage()
    AS (dsI:CHARARRAY,
        dsE:CHARARRAY,
        dsExt:CHARARRAY);

TempR4 = JOIN y BY diaSem, m BY dsI;
r4 = FOREACH TempR4 GENERATE id, birthday, dia, numDia, dsE, dsExt;

r5 = ORDER r4 BY id;
r6 = FOREACH r5 GENERATE birthday, dia, numDia, dsE, dsExt;


-- escribe el archivo de salida
STORE r6 INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
