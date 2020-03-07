
-- carga de datos
dataTable = LOAD 'truck_event_text_partition.csv' USING PigStorage(',')
    AS (driverId:INT,
        truckId:INT,
        eventTime:CHARARRAY,
        eventType:CHARARRAY,
        longitude:DOUBLE,
        latitude:DOUBLE,
        eventKey:CHARARRAY,
        correlationId:CHARARRAY,
        driverName:CHARARRAY,
        routeId:FLOAT,
        routeName:CHARARRAY,
        eventDate:CHARARRAY);
    
-- filtrar y ordenar
x = FOREACH dataTable GENERATE driverId,truckId,eventTime;
y = LIMIT x 10;
z = ORDER y BY $0, $1, $2;

-- escribe el archivo de salida
STORE z INTO 'output' USING PigStorage(',');

-- copia los archivos del HDFS al sistema local
fs -get output/ .
