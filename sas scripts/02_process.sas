/*1. Inspect data*/
proc contents data=work.statnett;
run;

proc print data=work.statnett(obs=5);
    var DateTime;
run;


/*2. Column DateTime needs datetime conversion*/

data work.statnett_processed;
    set work.statnett;
	
	/*Convert Excel datetime to SAS datetime*/
    datetime_fixed = round((DateTime - 21916) * 86400, 3600); /*86400 (seconds/day)*/ 
    format datetime_fixed datetime20.;    
    
    Production_num  = input(strip(Production), best32.);
    Consumption_num = input(strip(Consumption), best32.);
run;

/*3. Validate numeric conversion*/
proc means data=work.statnett_processed n nmiss min max;
    var Production_num Consumption_num;
run;

/*4. Drop original columns and rename the numeric columns*/
data work.statnett_processed;
    set work.statnett_processed;

    drop Production Consumption;
    rename Production_num  = Production
           Consumption_num = Consumption;
run;



/*5. Drop DateTime column in statnett_processed*/
data work.statnett_processed;
    set work.statnett_processed;
    drop DateTime;
run;

/*6. Sanity check*/
proc contents data=work.statnett_processed;
run;