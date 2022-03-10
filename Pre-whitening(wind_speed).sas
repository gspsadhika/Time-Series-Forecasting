ods noproctitle;
ods graphics / imagemap=on;

proc sort data=STSM.CLIMATE_AVG out=Work.preProcessedData;
	by date;
run;

proc arima data=Work.preProcessedData plots
     (only)=(series(acf corr crosscorr) residual(corr normal) 
		forecast(forecast forecastonly) );
	identify var=wind_speed(1);
	estimate p=(3) q=(1) method=ML;
	identify var=meantemp crosscorr=(wind_speed(1));
	estimate input=( wind_speed(1)) method=ML;
	forecast lead=12 back=0 alpha=0.05 id=date interval=week;
	outlier;
	run;
quit;

proc delete data=Work.preProcessedData;
run;