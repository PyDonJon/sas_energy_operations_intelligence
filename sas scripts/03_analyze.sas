
						/*1. Data preparation*/

data work.energy;
    set work.statnett_processed;

    /* Fix floating-point noise */
    datetime_fixed = round(datetime_fixed, 3600);
    format datetime_fixed datetime20.;

    /* Time decomposition */
    date = datepart(datetime_fixed);
    format date date9.;

    hour     = hour(datetime_fixed);
    weekday  = weekday(date);
    month    = month(date);

    /* Business metrics */
    net_balance = Production - Consumption;
    utilization = Consumption / Production;
    deficit_flag = (net_balance < 0);
run;


						/*2. Sanity checks*/

/*2.1 check numbers*/
proc contents data=work.energy;
run;


/*2.2 Check basic statistics*/
proc means data=work.energy n mean median min max std;
    var Production Consumption net_balance utilization;
run;



			/*3. Time series visualization 2012-2025*/

/*3.1 Production vs Consumption over time*/
proc sgplot data=work.energy;
    series x=date y=Production / lineattrs=(color=green);
    series x=date y=Consumption / lineattrs=(color=red);
    xaxis label="Time";
    yaxis label="Energy";
    title "Production vs Consumption Over Time";
run;


/*3.2 Net balance over time*/
proc sgplot data=work.energy;
    series x=date y=net_balance;
    refline 0 / axis=y lineattrs=(pattern=shortdash);
    title "Net Energy Balance Over Time";
run;



					/*4. Seasonality analysis*/

/*4.1 Hour-of-day patterns*/
proc means data=work.energy noprint;
    class hour;
    var Production Consumption net_balance;
    output out=hourly_avg mean=;
run;

proc sgplot data=hourly_avg;
    series x=hour y=Production;
    series x=hour y=Consumption;
    title "Average Production and Consumption by Hour";
run;



/*4.2 Day-Of-Week Analysis*/
proc means data=work.energy noprint;
    class weekday;
    var Production Consumption net_balance;
    output out=weekday_avg mean=;
run;

proc sgplot data=weekday_avg;
    vbar weekday / response=net_balance stat=mean;
    title "Average Net Balance by Day of Week";
run;


				/*5. Distribution & risk analysis*/

/*5.1 Histogram, heavy left tail implies frequent deficits*/

proc sgplot data=work.energy;
    histogram net_balance;
    density net_balance;
    title "Distribution of Net Energy Balance";
run;

/*5.2 Boxplot, outliers*/

proc sgplot data=work.energy;
    vbox net_balance;
    title "Net Balance Variability";
run;


					/*6. Deficit-focused EDA*/

/*6.1 % of time in deficit = where money is lost*/

proc means data=work.energy mean;
    var deficit_flag;
run;

/*6.2 Top 10 worst deficit events*/

proc sort data=work.energy out=worst;
    by net_balance;
run;

proc print data=worst(obs=10);
    var date net_balance Production Consumption;
    title "Top 10 Worst Deficit Periods";
run;


				/*7. Efficiency & correlation analysis*/

/*7.1 Production vs Consumption scatter, 
Points above the 45° line = deficit periods.*/

proc sgplot data=work.energy;
    scatter x=Production y=Consumption;
    lineparm x=0 y=0 slope=1;
    title "Production vs Consumption";
run;

/*7.2 Correlation matrix, Does more production actually reduce deficits?*/

proc corr data=work.energy;
    var Production Consumption net_balance utilization;
run;


					/*8. KPI Table*/
					
					
proc means data=work.energy n mean min max std p5 p95;
    var Production Consumption net_balance;
run;


			/*9. Cumulative net balance (cash-flow view)*/
			
			
proc sort data=work.energy out=energy_sorted;
    by date;
run;

data energy_cum;
    set energy_sorted;
    cum_balance + net_balance;
run;

proc sgplot data=energy_cum;
    series x=date y=cum_balance;
    refline 0 / axis=y;
    title "Cumulative Net Energy Balance";
run;

