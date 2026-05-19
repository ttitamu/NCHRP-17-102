library(dplyr)
library(tidyr)
require(pscl)
require(MASS)
require(boot)


# Read segment file --------------------

df <- read.csv("data/Modeling_Data/crash_segment_data.csv", header = T)
# Define or relevel new variables

df$lanew <- ((df$lane_width_nw + df$lane_width_se) / 2) - 12
df$numericalPSL_1 <- df$numericalPSL - 25
df$bike_facility <- relevel(factor(df$BL_type), "no facility")
df$parking1 <- relevel(factor(df$parking_1), "Not permitted")
df$speed_limit1 <- relevel(factor(df$speed_limit), "25 mph")
df$state1 <- relevel(factor(df$state), "WA")

# Bike Model: TWLTL Segment ------------

df_sub <- df[df$roadway_type %in% c("3T", "5T", "7T"), ]

summary(BikeCrash <- glm.nb(
  Sum_BikeCrash ~ log(Avg_AADT) + log(Avg_AADB) +
    roadway_type + state1 + PSL +
    bike_facility +
    transit_daily_trips_0_5mi +
    offset(log(Duration)) + offset(log(length_mi)),
  data = df_sub
))


# Bike Model: 6U+ Segments ------------

df_sub <- df[df$roadway_type %in% c("6D", "6U", "8D"), ]

summary(BikeCrash <- glm.nb(
  Sum_BikeCrash ~ log(Avg_AADT) + log(Avg_AADB) +
    roadway_type +
    state +
    bike_facility +
    parking1 +
    liquor_stores_0_1mi +
    offset(log(Duration)) + offset(log(length_mi)),
  data = df_sub
))
