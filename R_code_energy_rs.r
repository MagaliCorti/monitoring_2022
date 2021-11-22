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
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") 
# since we put NIR band in red band, vegetetion result red
# water would be black, it's not (it's light blue) probably due to sediments present in river (no pure water)
# defor1_.1 = NIR 
# defor1_.2 = red
# defor1_.3 = green
plotRGB(l1992, r=2, g=1, b=3, stretch="Lin")
plotRGB(l1992, r=3, g=2, b=1, stretch="Lin") # we don't see a lot of bare soil (would appear yellow)




# 19/11/2021

library(raster)
library(rgdal)
setwd("/Users/magalicorti/Desktop/lab/")
# importing data - image from satellite landsat 1992
l1992 <- brick("defor1_.jpg")
l1992
plot(l1992)
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin") 
# defor1_.1 = NIR 
# defor1_.2 = red
# defor1_.3 = green
# importing image of forest in 2006
l2006 <- brick("defor2_.jpg")
l2006
plot(l2006)
# plotting RGB image
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
# today rio pexodo nearly destroyed area, but in 2006 smaller amount of sediments in water, we see color darker blue
# water absorb a lot NIR -> clear water = black, polluted sediment water -> white

# use par function to plot more than one image together in 2 rows and 1 column (see difference bw 2 years)
par(mfrow=c(2,1))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
# to be sure the image is of same spot seek for similar structural pattern in the shape
# NB. don't trust river, they have all similar shapes due to water energy movement
# nature is fractal, vs human environment born by geometrical shapes

# calculate energy in 1992
# use DVI index 
# difference vegetation intex -> leaf absorbing a lot in red, reflecting a lot in NIR thanks to palisade tissue
# DVI = lambdaNIR - lambdaR --> if high value healthy and abundant vegetation (0-100)
# for every pixel of the image we make a operation (difference) bw NIR and R
dev.off()
dvi1992 <- l1992$defor1_.1 - l1992$defor1_.2
plot(dvi1992)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1992, col=cl)

# calculate energy in 2006
dvi2006 <- l2006$defor2_.1 - l2006$defor2_.2
plot(dvi2006)
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi2006, col=cl)
# all yellow part = energy lost
# we're also removing structures
# use of color in science comunication -> yellow catches our eyes more than others, using yellow we enhance a certain aspect
# do not use from blue to red legenda bc no friendly for color blind people
# priority list of thing we can do with remote sensing: species distribution, mesuring 3D dimention, functional composition, land cover, productivuty
# cannot map: genetic diversity

par(mfrow=c(2,1))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)

# difference in dvi 1992vs2006 (diff energy in diff times)
dvidif <- dvi1992 - dvi2006
# use new colorRampPalette
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(dvidif, col=cld)
# every thing red -> very high diff (lots of energy lost)

# final plot: original images, dvis, final dvidiff
# 5 graph -> 3 rows and 2 col
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)

# save all plots in pdf
pdf("energy.pdf")
par(mfrow=c(3,2))
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
plotRGB(l2006, r=1, g=2, b=3, stretch="Lin")
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()
# dev.off() needed to tell R we're done with our pdf
# to have a better layout play with pdf function (height, lenght...)

# 3 dvi images one near the other
pdf("dvi.pdf")
par(mfrow=c(1,3))
plot(dvi1992, col=cl)
plot(dvi2006, col=cl)
plot(dvidif, col=cld)
dev.off()






