# 15/12/2021

setwd("/Users/magalicorti/Desktop/lab/copernicus/")
library(raster)
library(ggplot2) 
library(gridExtra) 
library (RStoolbox)
library(ncdf4)

# importing copernicus data
snow20211214 <- raster("c_gls_SCE_202112140000_NHEMI_VIIRS_V1.0.1.nc")
snow20211214 # see characteristics
# 212400000 pixels -> real resolution
plot(snow20211214)








