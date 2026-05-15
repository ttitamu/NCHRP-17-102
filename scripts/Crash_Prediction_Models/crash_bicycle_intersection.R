
library("MASS")
library("ggplot2")
library("foreign")
library("modEvA")
library("rcompanion")
library("ggpubr")
library("lme4")
library("glmmTMB")
# library("merlin")
library("ROCR")
library("pROC")
library('boot')
library(DescTools)
library(partykit)
library(DescTools)
library(MLmetrics)
library(modeest)
library(gamlss)
library(gamlss.dist)
library(gamlss.cens)
library(survival)
library(dplyr)

### Data Import --------------
# setwd(dirname(rstudioapi::getActiveDocumentContext()$path))ß
rm(list=ls())
gc()
data<-read.csv("data/Modeling_Data/intersection_processed.csv", header=TRUE, stringsAsFactors=FALSE)
summary(data)
names(data) = tolower(names(data))


ThreeSG22 = subset(data, int_type == "3SG 2x2")
ThreeST22 = subset(data, int_type == "3ST 2x2")
FourSG12 = subset(data, int_type == "4SG 1x2")
FourST22 = subset(data, int_type == "4ST 2x2")

SG = rbind(ThreeSG22, FourSG12)
ST = rbind(ThreeST22, FourST22)

#SG = subset(SG, state != "TX")

model_bike_total_SG = glm.nb(sum_bikecrash ~ 1 
                                + offset(log(duration_yrs))
                                + log(avg_aadt_mean)
                                + log(avg_aadb_mean)
                                + as.factor(int_type)
                                + as.factor(exclusive_ltl_count>0)
                                #+ as.factor(ind_30or35_count>0 | ind_40__count>0)
                                #+ as.factor(ind_sharrow_count>0)
                                #+ as.factor(num_lanes_max>2)
                                + as.factor(numpsl_max>25)
                                 + as.factor(state == "PA")
                                 + as.factor(state == "MN")
                                 + as.factor(state == "WA")
                             
                                
                                
                                , data = SG)
summary(model_bike_total_SG)



model_bike_total_ST = glm.nb(sum_bikecrash ~ 1 
                             + offset(log(duration_yrs))
                             + log(avg_aadt_mean)
                             + log(avg_aadb_mean)
                             + as.factor(int_type)
                             #+ as.factor(num_lanes_max>2)
                             #+ as.factor(exclusive_ltl_count>0)
                             #+ as.factor(ind_30or35_count>0 | ind_40__count>0)
                             #+ as.factor(ind_bikelane_count>0)
                             #+ as.factor(num_lanes_max>2)
                             #+ as.factor(numpsl_max>25)
                             #+ as.factor(lighting_count>3)
                             + as.factor(state == "PA")
                             + as.factor(state == "MN")
                             + as.factor(state == "WA")
                             
                             
                             , data = ST)
summary(model_bike_total_ST)



set.seed(789)
SG$rand = runif(nrow(SG))
train = subset(SG, rand <0.7)
test = subset(SG, rand >= 0.7)


model_bike_total_SG = glm.nb(sum_bikecrash ~ 1 
                             + offset(log(duration_yrs))
                             + log(avg_aadt_mean)
                             + log(avg_aadb_mean)
                             + as.factor(int_type)
                             + as.factor(exclusive_ltl_count>0)
                             #+ as.factor(ind_30or35_count>0 | ind_40__count>0)
                             #+ as.factor(ind_sharrow_count>0)
                             #+ as.factor(num_lanes_max>2)
                             + as.factor(numpsl_max>25)
                             + as.factor(state == "TX" | state == "CA")
                             + as.factor(state == "MN")
                             + as.factor(state == "WA")
                             
                             
                             
                             , data = train)
summary(model_bike_total_SG)




#set.seed(2)
ST$rand = runif(nrow(ST))
train = subset(ST, rand <0.7)
test = subset(ST, rand >= 0.7)






model_bike_total_ST = glm.nb(sum_bikecrash ~ 1 
                             + offset(log(duration_yrs))
                             + log(avg_aadt_mean)
                             + log(avg_aadb_mean)
                             + as.factor(int_type)
                             #+ as.factor(num_lanes_max>2)
                             #+ as.factor(exclusive_ltl_count>0)
                             #+ as.factor(ind_30or35_count>0 | ind_40__count>0)
                             #+ as.factor(ind_bikelane_count>0)
                             #+ as.factor(num_lanes_max>2)
                             #+ as.factor(numpsl_max>25)
                             #+ as.factor(lighting_count>3)
                             + as.factor(state == "TX" | state == "CA")
                             + as.factor(state == "MN")
                             + as.factor(state == "WA")
                             
                             
                             , data = train)
summary(model_bike_total_ST)








model_bike_total_3SG22 = glm.nb(sum_bikecrash ~ 1 
                                + offset(log(duration_yrs))
                                + log(avg_aadt_mean)
                                + log(avg_aadb_mean)
                                
                                
                                , data = ThreeSG22)
summary(model_bike_total_3SG22)





model_bike_total_3ST22 = glm.nb(sum_bikecrash ~ 1 
                                + offset(log(duration_yrs))
                                + log(avg_aadt_mean)
                                + log(avg_aadb_mean)
                                
                                
                                , data = ThreeST22)
summary(model_bike_total_3ST22)



model_bike_total_4ST22 = glm.nb(sum_bikecrash ~ 1 
                                + offset(log(duration_yrs))
                                + log(avg_aadt_mean)
                                + log(avg_aadb_mean)
                                
                                
                                , data = FourST22)
summary(model_bike_total_4ST22)


 
model_bike_total_4SG12 = glm.nb(sum_bikecrash ~ 1 
                                + offset(log(duration_yrs))
                                + log(avg_aadt_mean)
                                + log(avg_aadb_mean)
                                + as.factor(ind_sharrow_count!=0)
                                
                                , data = FourSG12)
summary(model_bike_total_4SG12)

