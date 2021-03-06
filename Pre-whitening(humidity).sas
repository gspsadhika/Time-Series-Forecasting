/*
 *
 * Task code generated by SAS Studio 3.8 
 *
 * Generated on '2/20/22, 4:34 PM' 
 * Generated by 'Bansal' 
 * Generated on server 'DESKTOP-BQNJOTM' 
 * Generated on SAS platform 'X64_10HOME WIN' 
 * Generated on SAS version '9.04.01M6P11152018' 
 * Generated on browser 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36' 
 * Generated on web client 'http://localhost:60420/main?locale=en_US&zone=GMT-05%253A00&sutoken=%257BC7B5ED6F-E823-4011-B77E-062F92790172%257D' 
 *
 */

ods noproctitle;
ods graphics / imagemap=on;

proc sort data=STSM.CLIMATE_AVG out=Work.preProcessedData;
	by date;
run;

proc arima data=Work.preProcessedData plots
     (only)=(series(acf corr crosscorr) residual(corr normal) 
		forecast(forecast) );
	identify var=humidity;
	estimate p=(1) q=(1) method=ML;
	identify var=meantemp crosscorr=(humidity);
	estimate input=(humidity) method=ML;
	forecast lead=12 back=0 alpha=0.05 id=date interval=week;
	outlier;
	run;
quit;

proc delete data=Work.preProcessedData;
run;