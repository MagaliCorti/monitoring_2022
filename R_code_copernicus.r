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

# changing color range 
cl <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(snow20211214, col=cl)

# impo not using blue-green-red -> people color blind cannot see it vs viridis and cvids packages ok
# viridis, magma, turbo -> colorRampPalette already existing and available for direct use
install.packages("viridis")
library(viridis)

# using ggplot function (using several function one after the other)
ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill = Snow.Cover.Extent)) 
# fill = layer we'll use, find name in "names", by running snow20211214

# to see how many layers are inside copernicus data
brick(snow20211214)

# using ggplot function with viridis (changing colorRampPalette)
ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill = Snow.Cover.Extent)) +
scale_fill_viridis()  # viridis = default

# using ggplot function with cividis (changing colorRampPalette)
ggplot() +
geom_raster(snow20211214, mapping = aes(x=x, y=y, fill = Snow.Cover.Extent)) +
scale_fill_viridis(option = "cividis") +
ggtitle("cividis palette") # add title




# 15/12/2021

# setting wd & recalling the packages
setwd("/Users/magalicorti/Desktop/lab/copernicus/")
library(raster)
library(ggplot2) 
library(gridExtra) 
library (RStoolbox)
library(ncdf4)
library(viridis)

# importing data with lapply function
# list of 2 images with 3 layers each
rlist <- list.files(pattern = "SCE")
rlist
list_rast <- lapply(rlist, brick)   # otherwise use raster function -> name of layers are ≠
list_rast

# we've imported 2 images but they are separate -> to put them together use stack function
# (useful when you have ≠ layers of a same image)
snowstack <- stack(list_rast)
snowstack

# to unstack images
ssummer <- snowstack$X2021.08.29
ssummer
swinter <- snowstack$X2021.12.14
swinter

# using ggplot function to plot summer snow cover
p1 <- ggplot() +
geom_raster(ssummer, mapping = aes(x=x, y=y, fill = X2021.08.29)) +
scale_fill_viridis(option="plasma") +
ggtitle("snow cover in august 2021")

# using ggplot function to plot winter snow cover
p2 <- ggplot() +
geom_raster(swinter, mapping = aes(x=x, y=y, fill = X2021.12.14)) +
scale_fill_viridis(option="plasma") +
ggtitle("snow cover in december 2021")

# plot the two ggplots together -> patchwork
library(patchwork)
p1/p2

# zooming on specific area -> using coordinates
# longitude from x1 to x2
# latitute from y1 to y2
# crop function
ext <- c(-10, 15, 35, 60)
ssummer_cropped <- crop(ssummer, ext)
swinter_cropped <- crop(swinter, ext)
# stack_cropped <- crop(snowstack, ext)

p3 <- ggplot() +
geom_raster(ssummer_cropped, mapping = aes(x=x, y=y, fill = X2021.08.29)) +
scale_fill_viridis(option="plasma") +
ggtitle("snow cover in august 2021 in France")

p4 <- ggplot() +
geom_raster(swinter_cropped, mapping = aes(x=x, y=y, fill = X2021.12.14)) +
scale_fill_viridis(option="plasma") +
ggtitle("snow cover in december 2021 in France")

p3/p4








