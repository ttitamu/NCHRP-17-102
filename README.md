**NCHRP 17-102 New Exposure and Crash Prediction Models for Pedestrian and Bicyclist Safety**

**Authors:** Dr. Darren Torbic, Dr. Srinivas Geedipally, Dr. Bahar Dadashova, Dr. Okan Gurbuz, Dr. Lingtao Wu, Mr. Mike Pratt, Ms. Emma Turner, Dr. Vikash Gayah, Dr. Ilgin Guler, Dr. Rebecca Sanders, Dr. Jessica Schoner, and Mr. Brian Almdale

**Summary**

Effectively planning for safe, convenient, and comfortable walking and bicycling depends on understanding pedestrian and bicyclist activity (exposure) and incorporating those data into safety models that can more accurately describe and predict pedestrian and bicycle crash frequency and severity. Throughout the U.S., a lack of systematic investment in high-quality, consistent non-motorized count data has thwarted practitioners' ability to use exposure data to plan for activity or contextualize safety trends. The National Cooperative Highway Research Program (NCHRP) is working to address these gaps through projects aiming to build exposure and crash prediction models that can are widely accessible and usable throughout the country. This article describes the methodology and key outcomes from NCHRP Project 17-102 _Safety Performance for Active Transportation Modes Using Exposure Models_, which built on NCHRP Project 17-84 _Pedestrian and Bicycle Safety Performance Functions for the Highway Safety Manual_ by expanding the facilities modeled. NCHRP 17-102 provides practical guidance and tools for practitioners to better account for pedestrian and bicyclist activity and thereby better understand their safety outcomes and supplements previous pedestrian and bicycle research completed for the _Highway Safety Manual_.

**Introduction and Background**

The ability to safely and conveniently walk, bicycle, and roll is critical to expanding access to transportation in communities across the United States, with corollary safety, health, economic, environmental, and social benefits for all roadway users that ripple throughout the community. Yet pedestrians and bicyclists continue to be disproportionately injured and killed on U.S. roadways: despite a recent decrease in pedestrian and bicyclist fatalities from a forty-year high in 2022, fatalities are still significantly higher than they were just one decade ago (GHSA, 2026). To counter these trends and achieve the United States Department of Transportation's (USDOT's) goal of creating livable communities that provide safe, comfortable, and convenient infrastructure for walking and bicycling, practitioners need reliable, data-driven tools, methods, and models to help them understand and predict pedestrian and bicyclist activity (exposure) and safety.

A key challenge for practitioners is that few agencies have comprehensive non-motorized count data or sufficient staff time and resources to develop location-specific pedestrian or bicycle exposure models. Crash data are more readily available, but are known to be subject to underreporting, and face the same challenges as exposure data with regard to staff time, expertise, and resources to develop sophisticated models. To address this gap for practitioners, NCHRP Project 17-102 _Safety Performance for Active Transportation Modes Using Exposure Models_ aimed to contribute broadly applicable pedestrian and bicycle exposure and crash prediction models, guidance, and tools so that practitioners have the information and capability to predict and plan for these modes. The research was conducted such that the results would be consistent with the pedestrian and bicycle models planned for incorporation in the forthcoming second edition of the _Highway Safety Manual_ (i.e., HSM2) and, as much as possible, supplement the models developed under previous work for HSM2 (i.e., NCHRP Project 17-84).

**Summary of Methodology**

To develop nationally applicable exposure and crash prediction models for pedestrians and bicycles, the project team first conducted a broad literature review to understand the latest modeling trends in the subject area. Following the review, the team spent several months collecting and assembling relevant data across five states (Minnesota, Pennsylvania, Texas, California, and Washington), including pedestrian and bicycle counts, roadway characteristics, Census demographic and population data, land use data, and weather data for modeling purposes. While the team relied on publicly available data to the extent possible, some original data collection was conducted through online mapping software to gather the presence of specific roadway features.

The project team examined the data through univariate and bivariate analyses before moving to multivariate modeling, eventually estimating the models using negative binomial regression due to systematic overdispersion of the data (a common occurrence in exposure and safety modeling). Models were evaluated for fit using a series of goodness of fit statistics, CURE (cumulative residual) plots, and dividing the dataset into testing and training portions. For both exposure and crash prediction, separate segment and intersection models were developed for each by mode (i.e., pedestrian and bicycle). The exposure models can be applied to each intersection approach leg and then aggregated to estimate pedestrian and bicycle volumes for the intersection as a whole, whereas the crash prediction models apply to the intersection as a whole, based on how exposure and crash data are typically gathered and assigned. Because count data are generally unavailable for rural areas, the models are intended for analysis of urban and suburban roadways.

**Key Findings and Contributions to Practice**

Exposure Models

Based on the available data, pedestrian and bicycle exposure models are available for estimating pedestrian and bicycle volumes along following roadway types:

<div class="joplin-table-wrapper"><table><tbody><tr><th><p><strong>Roadway Types:</strong></p></th><th></th></tr><tr><td><ul><li>(2U) Two-lane undivided roads</li></ul></td><td><ul><li>(1O) One-lane one-way roads</li></ul></td></tr><tr><td><ul><li>(2D) Two-lane divided roads</li></ul></td><td><ul><li>(2O) Two-lane one-way roads</li></ul></td></tr><tr><td><ul><li>(3D) Three-lane divided roads</li></ul></td><td><ul><li>(3O) Three-lane one-way roads</li></ul></td></tr><tr><td><ul><li>(3T) Three-lane roads including a center TWLTL</li></ul></td><td><ul><li>(4O) Four-lane one-way roads</li></ul></td></tr><tr><td><ul><li>(4U) Four-lane undivided roads</li></ul></td><td><ul><li>(5O) Five-lane one-way roads</li></ul></td></tr><tr><td><ul><li>(4D) Four-lane divided roads</li></ul></td><td><ul><li>(6O) Six-lane one-way roads</li></ul></td></tr><tr><td><ul><li>(5U) Five-lane undivided roads</li></ul></td><td></td></tr><tr><td><ul><li>(5D) Five-lane divided roads</li></ul></td><td></td></tr><tr><td><ul><li>(5T) Five-lane roads including a center TWLTL</li></ul></td><td></td></tr><tr><td><ul><li>(6U) Six-lane undivided roads</li></ul></td><td></td></tr><tr><td><ul><li>(6D) Six-lane divided roads</li></ul></td><td></td></tr><tr><td><ul><li>(7D) Seven-lane divided roads</li></ul></td><td></td></tr><tr><td><ul><li>(7T) Seven-lane roads including a center TWLTL</li></ul></td><td></td></tr><tr><td><ul><li>(8U) Eight-lane undivided roads</li></ul></td><td></td></tr><tr><td><ul><li>(8D) Eight-lane divided roads</li></ul></td><td></td></tr></tbody></table></div>

For intersections along these roadway types, the exposure models can be applied to each intersection approach leg to estimate pedestrian and bicycle volumes for the intersections.

Key findings from the pedestrian exposure model include the following:

- Compared to multi-lane undivided highways, pedestrian volumes are generally lower on roadways with two-way left-turn lanes, one-way streets, two-lane undivided highways, and divided highways.
- Higher pedestrian volumes are associated with higher population and employment densities within a 0.5-mi radius of a count site, fitting with prior research findings.
- Pedestrian volumes also tended to rise with an increase in transit trips within a 0.5-mi radius of a count site.
- Longer distances to parks and schools were correlated with lower pedestrian volumes.
- The model also found that pedestrian volumes were higher during pre-COVID years compared to the COVID and post-COVID periods.

Key findings from the bicycle exposure model include the following:

- Bicycle volumes are generally higher on roads with higher motor-vehicle traffic volumes (AADT), segments with the presence of a bicycle lane (buffered, protected, or conventional), shared lane, or sidepath, and on divided roadway segments.
- Bicycle volumes also increase with employment density within 0.5 mi of the count site, a higher number of alcohol sales establishments within 0.1 mi of the count site, and a higher fraction of commuters that either bike or walk.
- Bicycle volumes are lower on roadway segments that are one-way roads (compared to two-way roads) or two-lane undivided roadways (compared to other types of roadways), that have a two-way left turn lane (TWLTL), or that have a higher posted speed limit.
- Bicycle volumes tend to decrease with greater distance to the nearest park and average wind speed.
- Lastly, bicycle volumes were lower in 2020 and 2021, but higher post Covid.

The models produce estimates that can be input directly into the crash prediction models that the project produced, described briefly below.

Crash Prediction Models

To supplement pedestrian and bicycle crash prediction models developed under NCHRP Project 17-84, priority was given to developing pedestrian and bicycle crash prediction models for the following types of roadway segments and intersections:

<div class="joplin-table-wrapper"><table><tbody><tr><th><p>Roadway Segments:</p></th><th><p>Intersections:</p></th></tr><tr><td><ul><li>(3T) Three-lane roads including a center TWLTL</li></ul></td><td><ul><li>Three-leg stop control (3ST 2×2)</li></ul></td></tr><tr><td><ul><li>(5T) Five-lane roads including a center TWLTL</li></ul></td><td><ul><li>Three-leg signal control (3SG 2×2)</li></ul></td></tr><tr><td><ul><li>(7T) Seven-lane roads including a center TWLTL</li></ul></td><td><ul><li>Four-leg stop control (4ST 2×2)</li></ul></td></tr><tr><td><ul><li>(6U) Six-lane undivided roads</li></ul></td><td><ul><li>Four-leg signal control (4SG 1×2)</li></ul></td></tr><tr><td><ul><li>(6D) Six-lane divided roads</li></ul></td><td></td></tr><tr><td><ul><li>(8U) Eight-lane undivided roads</li></ul></td><td></td></tr><tr><td><ul><li>(8D) Eight-lane divided roads</li></ul></td><td></td></tr></tbody></table></div>

The research team endeavored to provide multiple models for pedestrian and bicycle crash prediction, but were hampered to a degree by available data. At a minimum, segment and intersection crash models were developed that reflected total pedestrian or bicycle crashes (all severity levels combined). Where the data allowed, the project team also created models that reflect just fatal and suspected serious (KA) pedestrian and bicycle crashes and nighttime crashes.

Key findings from the pedestrian crash prediction modeling fit with prior research and theory, and include the following:

_Segments_

- Higher numbers of lanes were consistently associated with increased pedestrian crashes.
- Higher average volumes for both motorists (average annual daily traffic, or AADT) and pedestrians (average daily pedestrians, or ADP) are associated with higher pedestrian crash numbers.
- For roadways with two-way left-turn lanes (TWLTLs), having a signalized intersection at one or both ends is associated with higher pedestrian crashes. For divided roadways, having a signalized intersection at both ends is associated with higher pedestrian crashes.
- Specifically on roadways with TWLTLs:
  - Higher posted speed limits are associated with increased pedestrian crashes.
  - The presence of a sidewalk, particularly on both sides and with a buffer, is associated with lower pedestrian crash frequency.
- Specifically on divided roadways with six or more lanes:
  - Narrower lane width and the presence of lighting are negatively associated with pedestrian crashes.
  - Alcohol sales establishments and the presence of parking are positively associated with pedestrian crashes.

The pedestrian segment database had sufficient data to develop a model for pedestrian KA crashes and, separately, nighttime crashes, with the following findings:

- The pedestrian segment KA model again found a significant, positive correlation with both motorist and pedestrian volumes and with the presence of a signalized intersection on both ends of the segment. Sidewalks were similarly negatively associated with pedestrian KA crashes, underscoring their value as a key countermeasure.
- The pedestrian nighttime segment model found a significant and positive association with higher numbers of lanes (compared to three lanes) and with higher motorist and pedestrian volumes (AADT and ADP), respectively.

_Intersections_

- For signalized intersections (looking only at four-leg intersections of a two-way street and a one-way street (4SG 1x2) and three-leg intersections of two two-way streets (3SG 2x2)):
  - Higher average motorist volumes are associated with higher pedestrian crash numbers.
  - Pedestrian crashes are higher at 4SG 1x2 intersections than at 3SG 2x2 intersections.
  - Compared to locations with no schools within 500 ft of the intersection, the presence of a school within 500 ft of the intersection midpoint is associated with a higher number of pedestrian crashes.
  - A longer distance to a park is associated with fewer pedestrian intersection crashes.
  - Higher population density per square mile is associated with higher pedestrian intersection crashes.
- For stop-controlled intersections (looking only at three-leg and four-leg intersections of two two-way streets (3ST 2x2 and 4ST 2x2, respectively):
  - Higher average pedestrian volumes are associated with higher pedestrian crash numbers.
  - Compared to a maximum posted speed limit of 25 mph across approaches, a maximum posted speed of 35 mph or higher is associated with higher pedestrian crashes.
  - A longer distance to a school is associated with fewer pedestrian intersection crashes.

Key findings from the bicycle safety modeling include the following:

_Segments_

- Higher numbers of lanes were consistently associated with increased bicycle crashes.
- For roadways with TWLTLs, having a signalized intersection at one or both ends is associated with higher bicycle crashes. For divided roadways, having a signalized intersection at both ends is associated with higher bicycle crashes.
- Specifically on roadways with TWLTLs:
  - Higher posted speed limits are associated with increased bicycle crashes.
  - The presence of a bikeway, shared lane, or sidepath on one or both sides is associated with lower bicycle crash frequency. The sidepath has a greater protective effect than on street facilities or a shared lane.
  - A higher number of daily transit trips within 0.5 miles was associated with higher bicycle crash frequency.
  - Higher average volumes for both motorists (average annual daily traffic, or AADT) and bicyclists (average daily bicyclists, or ADB) are associated with increased bicycle crashes.
- Specifically on divided roadways with six or more lanes:
  - Lower average volumes for motorists (AADT) but higher average bicyclist volumes (ADB) are associated with increased bicycle crashes.
  - The presence of a bikeway on one or both sides is negatively associated with bicycle crashes. In contrast, having a shared lane on one or both sides is positively associated with bicycle crash frequency.
  - Alcohol sales establishments and the presence of parking on one or both sides of the street are positively associated with bicycle crashes.

_Intersections_

- For signalized intersections (looking only at four-leg intersections of a two-way street and a one-way street (4SG 1x2) and three-leg intersections of two two-way streets (3SG 2x2)):
  - Higher average bicycle volumes are associated with higher bicycle crash numbers.
  - Bicycle crashes are higher at 4SG 1x2 intersections than at 3SG 2x2 intersections.
  - The presence of at least one left-turn lane is positively associated with bicycle crashes.
  - A maximum posted speed limit greater than 25 mph across approaches is associated with higher bicycle crashes.
- For stop-controlled intersections (looking only at three-leg and four-leg intersections of two two-way streets (3ST 2x2 and 4ST 2x2, respectively):
  - Higher average bicycle volumes are associated with higher bicycle crash numbers.

**Conclusions**

This research project provided important guidance and tools to help transportation agencies and practitioners apply advanced predictive models to inform multimodal decision-making. The pedestrian and bicycle exposure models developed for this research enable transportation agencies that lack comprehensive pedestrian and bicycle count programs to estimate pedestrian and bicycle volumes along urban and suburban roadways and intersections. These exposure estimates can then be used as inputs to the pedestrian and bicycle crash prediction models planned for the urban and suburban arterial chapter of HSM2 to allow for informed, data-driven decisions of design alternatives. The pedestrian and bicycle volume estimates can also be used with other pedestrian and bicycle crash prediction models, such as those presented in the guidebook or developed for a particular city or state, within the similar HSM predictive methodology.

**Citations**

Torbic. D., S. Geedipally, B. Dadashova, O. Gurbuz, L. Wu, M. Pratt, E. Turner, V. Gayah, I. Guler, R. Sanders, B. Almdale, and J. Schoner. (2026). _Safety Performance for Active Transportation Modes Using Exposure Models._ Final Report for NCHRP Project 17-102. Transportation Research Board

Torbic. D., S. Geedipally, B. Dadashova, O. Gurbuz, L. Wu, M. Pratt, E. Turner, V. Gayah, I. Guler, R. Sanders, B. Almdale, and J. Schoner. (2026). _Safety Performance for Active Transportation Modes Using Exposure Models: Guide_. National Cooperative Highway Research Program.

**Structure of this Repository**

This repository contains source scripts and data for developing the models.

- **scripts/**: Contains the analysis scripts for modeling.
- **data/**: Contains the datasets. Raw_Data_and_Dictionary inlucdes raw data along with data dictionary; Modeling_Data includes data used by the modeling scripts.

**Usage**

```sh
# Exposure Models
# Pedestrian
sas ./scripts/Exposure_Models/exposure_pedestrian.sas
# Bicycle  Note: The bicycle exposure model requires R-Studio, it cannot be executed directly in terminal.
./scripts/Exposure_Models/exposure_bicycle.R

# Crash Prediction Models
# Bicycle Intersection
Rscript ./scripts/Crash_Prediction_Models/crash_bicycle_intersection.R
# Bicycle Segment
Rscript ./scripts/Crash_Prediction_Models/crash_bicycle_segment.R
#
# Pedestrian Intersection
Rscript ./scripts/Crash_Prediction_Models/crash_pedestrian_intersection.R
# Pedestrian Segment 3T 5T and 7T
sas ./scripts/Crash_Prediction_Models/crash_pedestrian_segment_3T_5T_7T.sas
# Pedestrian Segment 6U 6D and 8D
sas ./scripts/Crash_Prediction_Models/crash_pedestrian_segment_6U_6D_8D.sas
```
