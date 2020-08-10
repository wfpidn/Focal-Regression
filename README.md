# Focal (linear) regression between every 5x5 pixels group of cells of two rasters

As part of Extreme Rainfall model development activities (When the rainfall trigger a flood?), and based on two rasters with same resolution and dimension, we would like to create a new raster of SLOPE (a) and INTERCEPT (b) by performing linear regression between every 5×5 pixels of the two rasters, such that each pixel of the SLOPE and INTERCEPT will hold the regression slope and intercept value obtained from linear regression of the corresponding 5×5 pixels that surround that pixel.

## Application
The result will be use as input to generate flood probability when the daily rainfall forecast is available. 

## Data
Indonesia data are provided for example analysis, both data came from below.
- Daily rainfall estimate.
39 years (1981-2019) daily rainfall data used in the analysis are downloaded from Climate Hazards Center - UC Santa Barbara (https://chc.ucsb.edu/data-sets/chirps), and 
- Monthly Water History. 
This Monthly History collection holds the entire history of water detection on a month-by-month basis. The collection contains 430 images, one for each month between March 1984 and December 2019. Each pixel was individually classified into water / non-water using an expert system and the results were collated into a monthly history for the entire time period and two epochs (1984-1999, 2000-2019) for change detection. Downloaded from Google Earth Engine: https://developers.google.com/earth-engine/datasets/catalog/JRC_GSW1_2_MonthlyHistory


## Contents
- Example of raster file (GeoTIFF).
  - input
  - output
- R script for the focal-regression.
- Map output in PNG format
  - img


## Example output
- Slope map.
![Slope](/img/Rplot_slope.png)
- Intercept map.
![Intercept](/img/Rplot_intercept.png)
- Pvalue for slope.
![PvalueSlope](/img/Rplot_pvalue_slope.png)
- Pvalue for intercept.
![PvalueIntercept](/img/Rplot_pvalue_intercept.png)


## References
- https://gis.stackexchange.com/questions/278979/linear-regression-between-every-3×3-pixels-between-two-rasters-using-r/278985#278985 


## Contact
Using above reference, the code re-write by Anggita Annisa - former VAM intern. If you have any question related to this tool and application, contact [Benny Istanto](https://github.com/bennyistanto)
