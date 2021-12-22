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



