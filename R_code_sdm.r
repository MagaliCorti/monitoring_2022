# 22/12/2021

# see how abundances related to each other -> multivariate analysis
install.packages("sdm")
library(sdm)
library(raster) # used for the predictors
library(rgdal) # used for species

# sdm - species distribution modelling

# no need to set wd bc data already inside package

file <- system.file("external/species.shp", package="sdm")
# shp extention - shape file, points related to the species
# file is contained in the sdm package

# to see path to find data
file

# read or write shape file (similar to raster function for raster files)
species <- shapefile(file)
plot(species, pch=17, col="blue")





