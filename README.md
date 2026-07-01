**NCHRP Project 17-102 Safety Performance for Active Transportation Modes Using Exposure Models**

**Summary**

This documentation presents the datasets and source code developed as part of the NCHRP Project 17-102 (Safety Performance for Active Transportation Modes Using Exposure Models). The objectives of this research were twofold: (1) Advance the predictive safety performance methodologies for pedestrians, bicyclists, and those using mobility-assistive devices (such as motorized scooters and bikes) using exposure estimates and prediction models. Develop models and predictive methods for use by state and local DOTs of all sizes to determine potential exposure to help evaluate the likely safety performance at a given location. (2) Develop guidance and resources to support the implementation of the developed methodologies that can be used to inform multimodal decision-making in different design and land use contexts and also for different modal priorities. Pedestrian and bicycle exposure and crash prediction models developed as part of this research were combined with models, calculations, and procedures developed in previous research to enable transportation agencies and practitioners to fully assess the multimodal safety performance of sites, taking into consideration estimates for motor-vehicle crash frequencies (excluding pedestrian and bicycle collisions), pedestrian collisions, and bicycle collisions, consistent with the methodological framework and models planned for the forthcoming Second Edition of the Highway Safety Manual (HSM2). The datasets and source code presented here were used to develop the pedestrian and bicycle exposure and crash prediction models developed as part of this research. For more details about the datasets, refer to the final research report for NCHRP Project 17-102.

**Structure of this Repository**

This repository contains source scripts and data for developing the models.

- **scripts**: Contains the analysis scripts for modeling.
- **data**: Contains the datasets. Raw_Data_and_Dictionary includes raw data along with data dictionary; Modeling_Data includes data used by the modeling scripts.

**Usage**

```sh
# Exposure Models

# Pedestrian
sas ./scripts/Exposure_Models/exposure_pedestrian.sas

# Bicycle
# Note: The bicycle exposure model requires R-Studio, it cannot be executed directly in terminal.
# Rscript ./scripts/Exposure_Models/exposure_bicycle.R

# Crash Prediction Models

# Segments
# Pedestrian Segment 3T 5T and 7T
sas ./scripts/Crash_Prediction_Models/crash_pedestrian_segment_3T_5T_7T.sas
# Pedestrian Segment 6U 6D and 8D
sas ./scripts/Crash_Prediction_Models/crash_pedestrian_segment_6U_6D_8D.sas
# Bicycle Segment
Rscript ./scripts/Crash_Prediction_Models/crash_bicycle_segment.R

# Intersections
# Pedestrian Intersection
Rscript ./scripts/Crash_Prediction_Models/crash_pedestrian_intersection.R
# Bicycle Intersection
Rscript ./scripts/Crash_Prediction_Models/crash_bicycle_intersection.R

```

**Liability**

These datasets and source codes are offered as is, without warranty or promise of support of any kind either expressed or implied. Under no circumstance will the National Academy of Sciences or the Transportation Research Board (collectively “TRB”) be liable for any loss or damage caused by the installation or operation of this product. TRB makes no representation or warranty of any kind, expressed or implied, in fact or in law, including without limitation, the warranty of merchantability or the warranty of fitness for a particular purpose, and shall not in any case be liable for any consequential or special damages.
