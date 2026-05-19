library(MASS)
library(ggplot2)
library(cureplots)
library(readr)
library(tidyverse)

# load intersection data file
df <- read_csv('data/Modeling_Data/crash_intersection_data.csv')

# define new variables
df <- df %>% 
  mutate(    
    log_avg_aadt_mean = log1p(avg_aadt_mean), #log(x+1)
    log_avg_aadp_mean = log1p(avg_aadp_mean),
    log_avg_aadb_mean = log1p(avg_aadb_mean),
    
    log_popden = log1p(avg_popden_mean),
    log_empden = log1p(avg_empden_mean),
    log_transit = log1p(transit_daily_trips_0_5mi_sum),
    
    ind_ca_count = case_when(ind_ca_count > 0 ~ 1,TRUE ~ 0), 
    ind_mn_count = case_when(ind_mn_count > 0 ~ 1,TRUE ~ 0), 
    ind_tx_count = case_when(ind_tx_count > 0 ~ 1,TRUE ~ 0),
    ind_pa_count = case_when(state == "PA" ~ 1,TRUE ~ 0),
    ind_wa_count = case_when(state == "WA" ~ 1,TRUE ~ 0),
    ind_ca_tx_count = case_when((ind_ca_count > 0 | ind_tx_count > 0) ~ 1, TRUE ~ 0),
    ind_liquor = case_when(liquor_stores_0_1mi_sum > 0 ~ 1,TRUE ~ 0), 
    ind_30_plus = case_when(numpsl_max >= 30 ~ 1,TRUE ~ 0), 
    ind_35_plus = case_when(numpsl_max >= 35 ~ 1,TRUE ~ 0), 
    ind_40_plus = case_when(numpsl_max >= 40 ~ 1,TRUE ~ 0),
    psl_max_rev = case_when(numpsl_max == 25 ~ "25", 
                            numpsl_max == 30 ~ "30",
                            numpsl_max >= 35 ~ "35+"),
    state = factor(state),
    state = relevel(state, ref = "CA"), 
    school_distance_has_300ft = school_distance_min <= 300,
    school_distance_has_1000ft = school_distance_min <= 1000,
    ind_4sig = case_when(int_type == "4SG 1x2" ~ 1,
                         TRUE ~ 0),
    ind_4stop = case_when(int_type == "4ST 2x2" ~ 1,
                          TRUE ~ 0)
  )

# define subsets of the data
# ```{r}
dat_sig_notx <- df %>%
  filter((int_type == "3SG 2x2" | int_type == "4SG 1x2"),
         (state != "TX"))
dat_stop_notx <- df %>%
  filter((int_type == "3ST 2x2" | int_type == "4ST 2x2"),
         (state != "TX"))

# Ped Intersection Model: Signalized intersections
summary(PedCrashSig <- glm.nb(sum_pedcrash ~ log_avg_aadt_mean + avg_aadp_mean + 
                             ind_mn_count + ind_wa_count + ind_pa_count + 
                             ind_4sig + school_distance_has_500ft + 
                             park_distance_max + avg_popden_mean + 
                             offset(log(duration_yrs)), data = dat_sig_notx))

# Ped Intersection Model: Stop-controlled intersections
summary(PedCrashStop <- glm.nb(sum_pedcrash ~ log_avg_aadp_mean + avg_aadt_mean + 
                              ind_4stop + ind_mn_count + ind_wa_count + ind_pa_count + 
                              as.factor(psl_max_rev) + school_distance_max + 
                              offset(log(duration_yrs)), data = dat_stop_notx))
