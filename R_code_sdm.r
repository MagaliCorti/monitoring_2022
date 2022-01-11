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





# 10/01/2022

# recalling libraries
library(sdm)
library(raster) # plotting predictors of where spp found over space
library(rgdal) # vectors data of spp (spp are array of x,y points)

# species data
# system.file() makes list of all the files inside a folder (e.g. "external" folder)
file <- system.file("external/species.shp", package="sdm")
file # gives you path where to find data

# dbf = table (occurrences)
# prg = info about coord system
# shx linking all points to dbf

species <- shapefile(file) # corresponding funct to raster (raster import raster data)
# species is a data frame with 200 points, they are occurcencer with value 1 or 0 (presence/absence)
species$Occurrence # see all 200 occurences

# how many occurrences are there? 
# subset a dataframe
species[species$Occurrence == 1,] # use ',' to stop the query
# 94 occurences with 1 value = with spp found
# 200 - 94 = 106 occurrences with absence

presences <- species[species$Occurrence == 1,]
absences <- species[species$Occurrence == 0,]

# platting dataset
plot(species, pch=16) # pch = type of point (shape and color)
plot(presences, pch=16, col="blue")
plot(absences, pch=16, col="red")

# plotting together pres and abs with points()
plot(presences, pch=16, col="blue")
points(absences, pch=16, col="red")

# predict presence of spp in a certaint point of the map using predictors eg. T, altitude, water availability

# look at environmental predictors
path <- system.file("external", package="sdm")
path
# ASCII with .asc extention
# look for files with asc ext -> 4 files (elevation, precipitation,temperatutre, vegetation)
lst <- list.files(path, pattern = 'asc', full.names=T) # full name needed bc we're inside the package

# stack files of the list
# (not necessary lapply() with raster bc files are already inside package)
preds <- stack(lst)

# plot preds
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl) 

# plotting only elevation and see presences
plot(preds$elevation, col=cl)
points(presences, pch=19) # spp found at low elevation

plot(preds$temperature, col=cl)
points(presences, pch=19) # quite hight T

plot(preds$vegetation, col=cl)
points(presences, pch=19) # hight vegetation cover

plot(preds$precipitation, col=cl)
points(presences, pch=19) # intermediate precipitation


# 11/01/2022

setwd("/Users/magalicorti/Desktop/lab/")

source("R_code_source_sdm.r")
preds # stack of the predictors

# explaining to the model what are the training and the predictors
datasdm <- sdmData(train = species, predictors = preds )

# making sdm model - lm = linear model
m1 <- sdm(formula = Occurrence ~ temperature + elevation + precipitation + vegetation, data = datasdm, methods = "glm")








