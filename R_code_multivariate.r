# 22/12/2021

install.packages("vegan")
library(vegan)

# setting wd
setwd("/Users/magalicorti/Desktop/lab/")

# loading data
load("biomes_multivar.RData")

# ls function (list all files) to see what's inside the R data -> temporary data stored in computer
ls()

biomes # species for each plot
biomes_types

multivar <- decorana(biomes)
multivar
# decorana function with biome data
# rescaling of the system in 4 dimentions
# DCA1 axis explain 51% vartibility
# DCA2 axis explain 30% vartibility
# with 2 axis we can compact the system to 2 differant axis explaining 81% of variability
 
# plotting all the data of 20 potential axis in 2 axis (the ones expalining more variability)
# see how species will scatter in this new space
# species near, related to a specific biome
plot(multivar)

# attach function to attach objects instead of using $

# see if species grouped in the same biome
attach(biomes_types)
ordiellipse(multivar, type, col=c("black","red","green","blue"), kind="ehull", lwd=3)

# put label on ellipse, use spider configuration
ordispider(multivar, type, col=c("black","red","green","blue"), label=T)
# we can see that species linked together and appartaining to same biome
# in some cases interceptions of plots -> spp living in ≠ biomes





