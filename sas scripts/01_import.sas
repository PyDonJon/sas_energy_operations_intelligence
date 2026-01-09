FILENAME reffile '/home/u63863270/Statnett Raw Data/output.xlsx';

proc import datafile=reffile
	dbms=xlsx
	out=work.statnett;
	getnames=yes;
run;