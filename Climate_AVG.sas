PROC SQL;
CREATE TABLE WORK.query AS
SELECT 'date'n , meantemp , humidity , wind_speed , meanpressure FROM STSM.CLIMATE_AVG;
RUN;
QUIT;

PROC DATASETS NOLIST NODETAILS;
CONTENTS DATA=WORK.query OUT=WORK.details;
RUN;

PROC PRINT DATA=WORK.details;
RUN;