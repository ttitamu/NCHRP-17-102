
PROC IMPORT OUT=WORK.all
     DATAFILE="data\Modleing_Data\exposure_model_data.xlsx"
	          DBMS=EXCEL2010 REPLACE;
			  SHEET='PED_ONLY_TRIM';
			  RANGE="A1:ES1709";
RUN;

DATA ped; SET all;
if ped NE ".";
IF roadway_type IN ("1O","2O","3O","4O","5O") THEN I_ow=1; ELSE I_ow=0;
IF roadway_type IN ("2U","3U") THEN I_2u=1; ELSE I_2u=0;
IF roadway_type IN ("4U","5U","6U") THEN I_mu=1; ELSE I_mu=0;
IF roadway_type IN ("2D","3D","4D","5D","6D","7D","8D") THEN I_div=1; ELSE I_div=0;
IF roadway_type IN ("3T","4T","5T","7T") THEN I_tl=1; ELSE I_tl=0;
IF city IN ("Los Angeles, CA") THEN I_ca=1; ELSE I_ca=0;
IF city IN ("Minneapolis, MN") THEN I_mn=1; ELSE I_mn=0;
IF city IN ("Philadelphia, PA") THEN I_pa=1; ELSE I_pa=0;
IF city IN ("Austin, TX","Dallas, TX","Houston, TX") THEN I_tx=1; ELSE I_tx=0;

IF year IN (2020,2021) THEN I_covid=1; ELSE I_covid=0;
IF year >2021  THEN I_postcovid=1; ELSE I_postcovid=0;
IF Ave_Daily_Transit_Trips_0_5_="." THEN Ave_Daily_Transit_Trips_0_5_=0;
IF Posted_Speed_Limit IN (30,35) THEN I_3035=1; ELSE I_3035=0;
IF Posted_Speed_Limit >=40 THEN I_40=1; ELSE I_40=0;
RUN;

TITLE 'MODEL';

DATA ped_1; SET ped;
IF (uniqueID IN ("PHL71582") AND year=2021) OR (uniqueID IN ("PHL130850") AND year=2016 ) OR (uniqueID IN ("PHL71624") AND year=2020 ) OR (uniqueID IN ("PHL160188") AND year=2021 )THEN DELETE; *outlier;
RUN;
PROC NLMIXED  DATA=ped_1  MAXIT=400  ;*CORR;
  PARMS  
 	     b0=0 
		 b_tx=0 b_ca=0 b_mn=0 
           b_tl=0 b_ow=0 b_2u=0 b_div=0 
		b_pop=0 b_emp=0 b_tran=0 b_alc=0 b_park=0 b_sch=0 b_3035=0 b_40=0
		 	b_covid=0 b_postcovid=0 
		 	 k_1=1  ;

    BASE=EXP(b0)*EXP(b_tx*I_tx+b_ca*I_ca+b_mn*I_mn) ;
    k=1/k_1;  
AF_pop=EXP(b_pop*LOG(__5mi_Population_density));
AF_emp=EXP(b_emp*__5mile_Employment_Density/1000);
AF_tran=EXP(b_tran*LOG(Ave_Daily_Transit_Trips_0_5_+0.01));
AF_alc=EXp(b_alc*__1mi_Liquor_Selling_Businesses);
AF_park=EXP(b_park*DistancetoPark/1000);
AF_sch=EXP(b_sch*DistancetoSchool/1000);
AF_spd3035=EXp(b_3035*I_3035);
AF_spd40=EXp(b_40*I_40);
AF_covid= EXP(b_covid*I_covid);
AF_postcovid= EXP(b_postcovid*I_postcovid);

  _mu_= BASE* EXP(b_ow*I_ow) *EXP(b_2u*I_2u)*EXP(b_div*I_div)*EXP(b_tl*I_tl) *AF_pop *AF_emp *AF_alc* AF_park *AF_sch * AF_tran *AF_spd3035 *AF_spd40*AF_covid*AF_postcovid;

  VAR_NB = _mu_+_mu_*_mu_/k;

  _Y_ = ped;

  ll = LGAMMA(_Y_ + k) - LGAMMA(_Y_ + 1) - LGAMMA(k) + _Y_*LOG(_mu_/k) - (_Y_ + k) * LOG(1+ _mu_/k);
  MODEL  _Y_ ~ GENERAL(ll);

  ID k  VAR_NB AF_pop AF_emp AF_alc AF_park AF_sch  AF_tran AF_spd3035 AF_spd40 AF_covid AF_postcovid; 

  PREDICT _mu_  OUT=RES (rename=(pred=YHAT));
RUN;
