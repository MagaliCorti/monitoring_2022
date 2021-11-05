# 25/10/2021

# R code for ecosystem monitoring by remote sensing
# first we need to download an additional R package
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages
# https://cran.r-project.org/web/packages/raster/index.html

install.packages("raster")
library(raster)




# 29/10/2021

# go to R and setup the raster packege entering " library(raster) "
library(raster)

# download data from virtuale and put it into lab folder

# we are going to use brick function
# raster brick puts the bands all together --> matrix with different pictures 
# (if you do not have the raster package intalled you cannot use this function because it's inside raster)

# firstly we have to set the working directory --> telling where the data are
setwd("/Users/magalicorti/Desktop/lab/")

# grd = grid, file we're going to import, without it the file won't work
# hdr is stating which is the name of file
# we're going to import satellite data
brick("p224r63_2011.grd")

# if we now we're going to use data in the future always better to assign a name
# remeber that objects in R cannot be numbers!
# to correct directly on R press the arrow pointing up (right of keyboard with the 4 arrows)
l2011 <- brick("p224r63_2011.grd")

plot(l2011)

# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band

# we have to put the c because it's an array, and " for colors
cl <- colorRampPalette(c("black", "grey", "light grey"))(100)
plot(l2011, col=cl)

# match the bands with the RGB - RedGreenBlue components of computer
# this is a natural color image -> how human eye perceave it
# strecht to make the image more large and clear
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")




# 05/11/2021

# band 1 of blue -> B1_sre (band one sperctrum reflectance)
# band 2 of green -> B2_sre (band one sperctrum reflectance)
# band 3 of red -> B3_sre
# band 4 of NIR -> B4_sre

# link the green band to l2011 and plot it
plot(l2011$B2_sre)

cl <- colorRampPalette(c("black", "grey", "light grey"))(100) # 100 number of color from black to light grey
plot(l2011$B2_sre, col=cl)

clg <- colorRampPalette(c("dark green", "green", "light green"))(100)
plot(l2011$B2_sre, col=clg)
# max absorb dark green (min reflectance) vs max reflectance light green

clb <- colorRampPalette(c("dark blue", "blue", "light blue"))(100)
plot(l2011$B1_sre, col=clb)

clr <- colorRampPalette(c("dark red", "red", "pink"))(100)
plot(l2011$B3_sre, col=clr)

# to plot two or more images in just one multiframe graph
# plot graph with 1 row and 3 column
par(mfrow=c(1,3)) 
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
plot(l2011$B3_sre, col=clr)
# plot graph with 3 row and 1 column
par(mfrow=c(3,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)
plot(l2011$B3_sre, col=clr)


