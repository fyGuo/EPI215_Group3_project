*//////////////1st MI DATASET////////////*;

FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data1.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT3;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT3; RUN;

data MI_1;
	set work.import;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_1 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;

*//////////////2nd MI DATASET////////////*;


FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data2.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT6;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT6; RUN;


data MI_2;
	set work.import6;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_2 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;

*//////////////3rd MI DATASET////////////*;



FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data3.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT7;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT7; RUN;

data MI_3;
	set work.import7;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_3 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;


*//////////////4th MI DATASET////////////*; 

FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data4.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT8;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT8; RUN;


data MI_4;
	set work.import8;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_4 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;


*//////////////5th MI DATASET////////////*; 

FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data5.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT9;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT9; RUN;


data MI_5;
	set work.import9;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_5 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;


*//////////////6th MI DATASET////////////*; 


FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data6.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT10;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT10; RUN;


data MI_6;
	set work.import10;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_6 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;


*//////////////7th MI DATASET////////////*; 


FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data7.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT11;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT11; RUN;

data MI_7;
	set work.import11;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_7 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;

*//////////////8th MI DATASET////////////*; 

FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data8.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT12;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT12; RUN;

data MI_8;
	set work.import12;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_8 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;

*//////////////9th MI DATASET////////////*; 

FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data9.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT13;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT13; RUN;

data MI_9;
	set work.import13;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_9 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;



*//////////////10th MI DATASET////////////*; 



FILENAME REFFILE '/home/u60808548/FINAL215/MI_clean_data10.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT14;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT14; RUN;
data MI_10;
	set work.import14;
	drop arrives;
	drop departs;
run; 


*subject matter knowledge model*; 
proc LOGISTIC data=MI_10 descending;
class sex marst race hispan educ hcovany classwkr work_Status workedyr vetstat;
model diffhear = sex age famsize marst race hispan educ hcovany classwkr work_Status workedyr uhrswork vetstat; 
title "fit a simple prediction model for diffhear";
run;

