# 19/11/2021

library(raster)
setwd("/Users/magalicorti/Desktop/lab/")

# need to install new package to see images .jpg
install.packages("rgdal")
library(rgdal)
# importing data - image from satellite landsat 1992
l1992 <- brick("defor1_.jpg")
l1992
# only 3 bands named defor1_.1, defor1_.2, defor1_.3 
plot(l1992)
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") # water would be black, it's not (it's light blue) probably due to sediments present in river (no pure water)
# defor1_.1 = NIR 
# defor1_.2 = red
# defor1_.3 = green
plotRGB(l1992, r=2, g=1, b=3, stretch="Lin")
plotRGB(l1992, r=3, g=2, b=1, stretch="Lin") # we don't see a lot of bare soil (would appear yellow)




