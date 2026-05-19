
PROC IMPORT OUT=WORK.seg_1
     DATAFILE="Data\Modeling_Data\crash_segment_data.csv";
RUN;

DATA seg_2; SET seg_1;

IF state IN ("CA") THEN I_ca=1; ELSE I_ca=0;
IF state IN ("MN") THEN I_mn=1; ELSE I_mn=0;
IF state IN ("PA") THEN I_pa=1; ELSE I_pa=0;
IF state IN ("TX") THEN I_tx=1; ELSE I_tx=0;
IF state In ("WA") THEN I_wa=1; ELSE I_wa=0;

lw=MEAN(lane_width_nw,lane_width_se);
IF sch_zone ="Not applicable (no school zone at this location)" THEN I_sch=0; ELSE I_sch=1;
IF lighting="Present" THEN I_lgt=1; ELSE I_lgt=0;
IF midblock_crossing="Present" THEN I_midX=1; ELSE I_midX=0;
IF TWLTL="Not applicable" THEN I_full_twltl=-1; ELSE IF TWLTL="Partial length of segment" THEN I_full_twltl=0; ELSE I_full_twltl=1;
IF parking="Not permitted" THEn I_park=0; ELSE IF parking="One side" THEn I_park=1; ELSE I_park=2;

IF sidewalk_nw IN ("None (i.e., no sidewalk or paved shoulder)","Paved shoulder present with width < 3 ft","Paved shoulder present with width = 3 ft and < 7.9 ft","Paved shoulder present with width = 7.9 ft") OR 
    sidewalk_se IN ("None (i.e., no sidewalk or paved shoulder)","Paved shoulder present with width < 3 ft","Paved shoulder present with width = 3 ft and < 7.9 ft","Paved shoulder present with width = 7.9 ft")
	THEN I_swalk=0; 
ELSE IF sidewalk_nw IN ("Sidewalk adjacent to traveled way (within 3 ft)") AND sidewalk_se IN ("Sidewalk adjacent to traveled way (within 3 ft)") THEN I_swalk=1; 
ELSE IF sidewalk_nw NOT IN ("Sidewalk adjacent to traveled way (within 3 ft)") AND sidewalk_se NOT IN ("Sidewalk adjacent to traveled way (within 3 ft)") THEN I_swalk=3; ELSE I_swalk=2;

IF int_start_nw ="Signal" AND int_start_se ="Signal" THEN I_sig2=1; ELSE I_sig2=0;
IF (int_start_nw ="Signal" AND int_start_se ="Stop") OR (int_start_nw ="Stop" AND int_start_se ="Signal") THEN I_sig_stop=1; ELSE I_sig_stop=0;
IF int_start_nw ="Stop" AND int_start_se ="Stop" THEN I_stop2=1; ELSE I_stop2=0;

IF numericalPSL IN (30,35) THEN I_3035=1; ELSE I_3035=0;
IF numericalPSL >=40 THEN I_40=1; ELSE I_40=0;
RUN;


TITLE '3T+5T+7T';
DATA t; SET seg_2;
IF roadway_type IN ("3T","5T","7T");
IF I_full_twltl=-1 THEN DELETE; RUN;

*****ped total;
DATA t_1; SET t;
IF uniqueID IN ("LA_138","4467") THEN DELETE; *outliers;
IF I_park IN (0,1) THEN I_park2=0; ELSE I_park2=1;
RUN;

PROC NLMIXED  DATA=t_1  MAXIT=600  ;*CORR;
  PARMS  
 	     b0=-5  b_5t=0 b_7t=0
 		 b_pa=0 b_tx b_wa=0/*no Mn*/
		b_adt=0.5 b_ped=0 
		  b_sig2=0 b_sig_stop=0 b_3035=0 b_40=0 b_swalk=0 
		 k_0=1  ;
  Wl_base = 12;
 
f_state=exp(b_tx*I_tx +b_pa*I_pa +b_wa*I_wa);
AF_sig2=EXP(b_sig2*I_sig2+b_sig_stop*I_sig_stop);
AF_spd3035=EXP(b_3035*I_3035);
AF_spd40=EXP(b_40*I_40);
AF_swalk= EXP(b_swalk*I_swalk);

IF roadway_type IN ("3T") THEN DO;
p= b0 + b_adt*LOG(Avg_AADT) + b_ped*LOG(Avg_AADP) ;
    BASE=length_mi*duration*f_state *EXP(p);
    k=1/k_0;  END;

IF roadway_type IN ("5T") THEN DO;
p= b0 + b_5t+ b_adt*LOG(Avg_AADT) + b_ped*LOG(Avg_AADP) ;
    BASE=length_mi*duration*f_state *EXP(p);
    k=1/k_0;  END;

IF roadway_type IN ("7T") THEN DO;
p= b0 + b_7t+ b_adt*LOG(Avg_AADT) + b_ped*LOG(Avg_AADP) ;
    BASE=length_mi*duration*f_state *EXP(p);
    k=1/k_0;  END;

  _mu_= BASE*AF_sig2*AF_spd3035*AF_spd40*AF_swalk;

  VAR_NB = _mu_+_mu_*_mu_/k;

  _Y_ = Sum_PedCrash;

  ll = LGAMMA(_Y_ + k) - LGAMMA(_Y_ + 1) - LGAMMA(k) + _Y_*LOG(_mu_/k) - (_Y_ + k) * LOG(1+ _mu_/k);
  MODEL  _Y_ ~ GENERAL(ll);

  w_EB=1/(1+_mu_/k);

  EB_cr=(_mu_*w_EB) + ((1-w_EB)*_Y_);

  ID k  VAR_NB AF_lw AF_alc AF_sch AF_spd3035 AF_spd40 _Y_; 

  PREDICT _mu_  OUT=RES (rename=(pred=YHAT));
RUN;
