# Load required packages
required_packages <- c(
  "tidyverse",
  "dplyr",
  "purrr",
  "tidyr",
  "readxl",
  "stringr",
  "glmmTMB",
  "TMB",
  "MASS",
  "rstudioapi"
)

installed_packages <- rownames(installed.packages())
to_install <- setdiff(required_packages, installed_packages)

if (length(to_install) > 0) {
  install.packages(to_install)
}

invisible(lapply(required_packages, library, character.only = TRUE))


library(gamlss)


rm(list = ls())

# set working directory
if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
  current_path <- dirname(rstudioapi::getActiveDocumentContext()$path)
  setwd(current_path)
  message("Working directory set to: ", current_path)
} else {
  warning("rstudioapi is not available — working directory was not changed.")
}

# Elasticity Function with Type Column
elasticity_combined <- function(model, data) {
  # Remove intercept
  coefs <- coef(model)
  coefs <- coefs[!names(coefs) %in% "(Intercept)"]

  elasticity_list <- lapply(names(coefs), function(var_name) {
    coef_value <- coefs[var_name]

    raw_var <- gsub("log\\(|\\)", "", var_name)

    if (raw_var %in% names(data)) {
      var_data <- data[[raw_var]]
    } else if (var_name %in% names(data)) {
      var_data <- data[[var_name]]
    } else {
      var_data <- NA
    }

    # Default values
    elasticity <- NA
    median_value <- NA
    var_type <- NA

    if (grepl("log\\(", var_name)) {
      elasticity <- coef_value
      var_type <- "Log"
    } else if (all(na.omit(var_data) %in% c(0, 1))) {
      elasticity <- exp(coef_value) - 1
      var_type <- "I"
    } else if (is.numeric(var_data)) {
      median_value <- round(median(var_data, na.rm = TRUE), 4)
      elasticity <- coef_value * median_value
      var_type <- "C"
    }

    data.frame(
      Variable = var_name,
      Type = var_type,
      Elasticity = round(elasticity, 4),
      Median = ifelse(is.numeric(median_value), median_value, NA),
      stringsAsFactors = FALSE
    )
  })

  elasticity_df <- do.call(rbind, elasticity_list)
  return(elasticity_df)
}


# import file
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
file_path <- "../../data/Modeling_Data/TTI_All_Cities_WithinStudyTimePeriod_Updated_XG_07282025.xlsx"

# read bike sheet
Bike <- read_xlsx(file_path, sheet = "CYC_ONLY", col_types = "text")
names(Bike) <- tolower(names(Bike))
# character to numeric for all
Bike <- Bike %>%
  mutate(across(everything(), ~ {
    numeric_col <- suppressWarnings(as.numeric(.x))
    if (sum(is.na(.x)) == sum(is.na(numeric_col))) numeric_col else .x
  }))
str(Bike)


# 0.5 miles

data <- Bike

# new variables
data <- data %>%
  mutate(
    half_mi_female_percent = `0.5mi_total_female` / `0.5mi_total_population`,
    half_mi_age65_percent = (`0.5mi_femaleage>65` + `0.5mi_maleage>65`) / `0.5mi_total_population`,
    half_mi_white_percent = `0.5mi_whitealone` / `0.5mi_total_population`,
    half_mi_bikecommute_percent = `0.5mi_meansoftransportationtowork (bicycle)` / `0.5mi_employedpop`,
    tavg = as.numeric(tavg)
  )


# state dummy
data <- data %>%
  mutate(
    state = str_extract(city, ",\\s*\\w+$") %>% str_remove(",\\s*"),
    dummy = 1
  ) %>%
  pivot_wider(names_from = state, values_from = dummy, values_fill = 0)

data$roadway_code <- str_sub(data$`roadway type`, -1)

data$num_lanes <- as.numeric(substr(data$`roadway type`, 1, 1))


# remove NAs as necessary
data <- subset(data, !is.na(aadt))
data <- subset(data, !is.na(data$`functional class`))
data <- subset(data, !is.na(data$`roadway type`))
data <- subset(data, !is.na(data$`type of bicycle facility`))
data <- subset(data, !is.na(data$`0.5mi_population_density`))
data <- subset(data, !is.na(data$half_mi_female_percent)) # 1 NA = total records: 2133
data <- subset(data, !is.na(data$half_mi_age65_percent))
data <- subset(data, !is.na(data$half_mi_white_percent))
data <- subset(data, !is.na(data$`0.5mi_number of households`))
data <- subset(data, !is.na(data$`0.5mi_householdincome (median)`))
data <- subset(data, !is.na(data$`0.5mi_householdincome (median)`))
data <- subset(data, !is.na(data$half_mi_bikecommute_percent))
data <- subset(data, !is.na(data$residential_per)) # 169 NAs - total records: 1964
data <- subset(data, !is.na(data$commercial_per))
data <- subset(data, !is.na(data$distancetopark))
data <- subset(data, !is.na(data$no.of_stops_in_0.5_mile)) # 196 NAs - total records: 1768
data <- subset(data, !is.na(data$governmentaream2_per))
data <- subset(data, !is.na(data$argicultureaream2_per))
data <- subset(data, !is.na(data$awnd)) # 352 NAs - total records: 1416

data$bikelane <- data$`type of bicycle facility` == "Bike Lane" | data$`type of bicycle facility` == "Buffered Bike Lane" | data$`type of bicycle facility` == "Protected Bike Lane"
data$no.of_stops_in_0.1_mile[is.na(data$no.of_stops_in_0.1_mile)] <- 0
data$no.of_stops_in_0.25_mile[is.na(data$no.of_stops_in_0.25_mile)] <- 0
data$bike <- round(data$bike)
# data$lumix = -1/log(6)*(data$commercial_aream2 * log(data$commercial_aream2) + data$government_aream2 * log(data$government_aream2) + data$others_aream2 * log(data$others_aream2) + data$argiculture_aream2 * log(data$argiculture_aream2) + data$residential_aream2 * log(data$residential_aream2) + data$vacant_aream2 * log(data$vacant_aream2) )

data$lumix <- 6 / 5 * ((data$commercialaream2_per - 1 / 6)^2 + (data$governmentaream2_per - 1 / 6)^2 + (data$othersaream2_per - 1 / 6)^2 + (data$argicultureaream2_per - 1 / 6)^2 + (data$residentialaream2_per - 1 / 6)^2 + (data$vacantaream2_per - 1 / 6)^2)

data$bikefraction <- data$`0.5mi_meansoftransportationtowork (bicycle)` / (data$`0.5mi_meansoftransportationtowork (bicycle)` + data$`0.5mi_meansoftransportationtowork (cartruckorvan)` + data$`0.5mi_meansoftransportationtowork (drovealone)` + data$`0.5mi_meansoftransportationtowork (walk)`)

data$walkfraction <- data$`0.5mi_meansoftransportationtowork (walk)` / (data$`0.5mi_meansoftransportationtowork (bicycle)` + data$`0.5mi_meansoftransportationtowork (cartruckorvan)` + data$`0.5mi_meansoftransportationtowork (drovealone)` + data$`0.5mi_meansoftransportationtowork (walk)`)

data$bus_tripstops <- data$no.of_stops_in_0.5_mile * data$`ave_daily_transit_trips(0.5)`
data$dallas <- data$city == "Dallas, TX" | data$city == "Fort Worth, TX" | data$city == "Richardson, TX"

data$lanes[!is.na(data$ca_number_lanes)] <- data$ca_number_lanes[!is.na(data$ca_number_lanes)]
data$lanes[!is.na(data$mn_num_thrulanes)] <- data$mn_num_thrulanes[!is.na(data$mn_num_thrulanes)]
data$lanes[!is.na(data$tx_num_thrulanes)] <- data$tx_num_thrulanes[!is.na(data$tx_num_thrulanes)]
data$lanes[!is.na(data$pa_num_thrulanes)] <- data$pa_num_thrulanes[!is.na(data$pa_num_thrulanes)]

data <- subset(data, bikefraction < 0.13)
data$covid <- data$year == 2020 | data$year == 2021
data$postcovid <- data$year > 2021


bike_exposure <- glm.nb(
  bike ~ log(aadt) # aadt
    + as.factor(bikelane)
    + as.factor(`type of bicycle facility` == "Sharrow") * log(aadt)
    #+ as.factor(bikelane==TRUE)*log(aadt)
    + as.factor(`type of bicycle facility` == "Sidepath")
    #+ as.factor(`functional class` == "Arterial")
    + as.factor(roadway_code == "T")
    + as.factor(roadway_code == "O")
    + as.factor(`roadway type` == "2U")
    + as.factor(roadway_code == "D")
    #+ as.factor(num_lanes=<2)
    #+ log(`0.25mi_total_population`+1)
    #+
    # + `0.25mi_population_density`
    + `0.5mile_employment density`
    #+ log(`0.5mi_employedpop`)
    #+ `0.5mi_householdincome (median)`
    #+ `0.5mi_number of households`
    #+ log(`ave_daily_transit_trips(0.5)`)
    + log(`0.1mi_liquor_selling_businesses` + 1)
    #+ no.of_stops_in_0.5_mile
    + bikefraction
    + walkfraction
    #+ lumix
    + distancetopark
    #+ tmax
    #+ prcp
    #+ as.factor(awnd>9)
    #+ tmin
    #+ commercial_per
    + awnd
    + as.factor(`posted speed limit` == 30 | `posted speed limit` == 35)

    + as.factor(`posted speed limit` >= 40)
    + TX # STATE
    # #           + as.factor(city == "Austin, TX")
    # #           +  dallas
    # #           + as.factor(city == "Houston, TX")
    + CA
    + MN
    + covid + postcovid
  #+ PA

  ,
  data = data
)
summary(bike_exposure)

data$pred_bike <- exp(predict(bike_exposure, data))

write.csv(data, "../../data/Modeling_Data/bike_modeling_data.csv", row.names = FALSE)


data_withhold <- subset(data, PA == 1)
data_model <- subset(data, PA == 0)

bike_exposure <- glm.nb(
  bike ~ log(aadt) # aadt
    + as.factor(bikelane)
    + as.factor(`type of bicycle facility` == "Sharrow") * log(aadt)
    + as.factor(`type of bicycle facility` == "Sidepath")
    + as.factor(`functional class` == "Arterial")
    # + as.factor(roadway_code=="T")
    # + as.factor(roadway_code=="O")
    # + as.factor(`roadway type`=="2U")
    + as.factor(roadway_code == "D")
    #+ as.factor(num_lanes>=5)
    #+ log(`0.25mi_total_population`+1)
    #+
    # + `0.25mi_population_density`
    + `0.5mile_employment density`
    #+ log(`0.5mi_employedpop`)
    #+ `0.5mi_householdincome (median)`
    #+ `0.5mi_number of households`
    + log(`ave_daily_transit_trips(0.5)`)
    #+ no.of_stops_in_0.5_mile
    + bikefraction
    + walkfraction
    #+ lumix
    + distancetopark
    #+ tmax
    #+ prcp
    #+ as.factor(awnd>9)
    #+ tmin
    #+ commercial_per
    + awnd
    + TX # STATE
    # #           + as.factor(city == "Austin, TX")
    # #           +  dallas
    # #           + as.factor(city == "Houston, TX")
    + CA
    + MN
    + covid + postcovid
  #+ PA

  ,
  data = data_model
)
summary(bike_exposure)

## End