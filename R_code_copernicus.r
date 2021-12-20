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




# 20/12/2021

setwd("/Users/magalicorti/Desktop/lab/greenland_data/")
library(raster)
library(ggplot2) 
library(gridExtra) 
library (RStoolbox) # to put raster objects in ggplot
library(ncdf4)
library(patchwork)
library(viridis)

# importing all files separately
rlist <- list.files(pattern = "lst")
rlist
import <- lapply(rlist, raster)
import

# creating a stack with all images
tgr <- stack(import)
tgr

# setting colours and plotting stack
cl <- colorRampPalette(c("blue","light blue","pink","yellow"))(100)
plot(tgr, col=cl)

# ggplot of first image of 2000 
p1 <- ggplot() +
geom_raster(tgr$lst_2000, mapping = aes(x=x, y=y, fill = lst_2000)) +
scale_fill_viridis(option = "magma") +
ggtitle("Land Surface Temperature in 2000")     

# ggplot of last image of 2015
p2 <- ggplot() +
geom_raster(tgr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("Land Surface Temperature in 2015")

# plotting 2 ggplot together with patchwork package
p1+p2

# distribution with 2 peaks is quite odd in a population

# plotting frequency distribution -> plot all histograms together
par(mfrow=c(2,2))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)
# 2015 situation has 2 much more evident peaks -> not normal situation

# plotting values of 2010 and 2015
# comparing data one in function of the other
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000)) # making line  passing trough 0
abline(0, 1, col="red") # plotting line 
plot(tgr$lst_2005, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000)) 
abline(0, 1, col="red")  
plot(tgr$lst_2000, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000)) 
abline(0, 1, col="red")  

# plotting all histogrammes and plots together
par(mfrow=c(4,4))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000)) 
plot(tgr$lst_2005, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000)) 
plot(tgr$lst_2000, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000)) 
plot(tgr$lst_2000, tgr$lst_2005, xlim=c(12500,15000), ylim=c(12500,15000)) 
plot(tgr$lst_2000, tgr$lst_2010, xlim=c(12500,15000), ylim=c(12500,15000)) 
plot(tgr$lst_2005, tgr$lst_2010, xlim=c(12500,15000), ylim=c(12500,15000)) 
# too long!!!

# plot everything together automatically, make scatterplots
pairs(tgr)

# we see that in 2015 the lower temperature are higher



