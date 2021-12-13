# 03/12/2021

# forests grow up till a certain equilibrium, but man cut it down first

setwd("/Users/magalicorti/Desktop/lab/")
library(raster)
library(ggplot2) 
library(gridExtra) 
library (RStoolbox) # tools for remote sensing data analysis -> to make the classification

# brick to import every layer of every image (brick import all layer of an image together)
# to import a lot of images -> lapply function

# 1. list the files available
rlist <- list.files(pattern = "defor") # images with 3 layers: NIR, red, green
rlist

# 2. apply a function to a list
list_rast <- lapply(rlist, brick)
list_rast

# plotting a single image with all 3 different layers (first one)
plot(list_rast[[1]])

# plotting in RGB space with NIR=1, red=2, green=3
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch = "Lin")
# easier to read with short and meaningful name
l1992 <- list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3, stretch = "Lin")
# plotting second image
l2006 <- list_rast[[2]]
plotRGB(l2006, r=1, g=2, b=3, stretch = "Lin")

# estimate amount of forest destroied
# unsupervied classification, we tell to the softeare the numeber of classes we want in the end
# take the pixels and look if there are meaningful groups
l1992c <- unsuperClass(l1992, nClasses=2)
l1992c # only 2 values -> one forest and one agricultural land
# plotting the map
# agricuktural land + water = value 2
# forest = value 1
# continuous legend but valus bw 1 and 2 not expressed
plot(l1992c$map)

# persentage of forest/agricultural area (number of pixels)
# frequences of our map (values with small differences bc iterative process)
freq(l1992c$map)
# agricuktural land + water = 36313 (class 2)
# forest = 304979 (class 1)
total <- 341292 # tot amount of pixels -> run l1992c -> look at tird value of dimension (ncell)
# compute percentage of different land uses
propagri <- 36313/total
propforest <- 304979/total
propagri    # 0.1063986 -> 11%
propforest  # 0.8936014 -> 89%

# building a dataframe with type of cover and proportion of pixels
cover <- c("Forest", "Agriculture")
prop1992 <- c(0.8936014, 0.1063986)
proportion1992 <- data.frame(cover, prop1992) # proportion of pixels in 1992
proportion1992 # quantitative data

# plotting data with ggplot2
# ggplot function -> first argument = dataset, other arguments = aesthetic, color stored in cover
# geom_bar function explainig type of graph
# stat - statistics used, identity bc we're using data as they are (no median or mean)
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")




# 06/12/2021

setwd("/Users/magalicorti/Desktop/lab/")
library(raster)
library(ggplot2)    # to use ggplot function
library(gridExtra)  # to put several ggplot in a multiframe
library (RStoolbox) # to make classification

# creating a list with all images and importing them applying funct brick over the list (import images with all layers)
rlist <- list.files(pattern = "defor")
rlist
list_rast <- lapply(rlist, brick)
list_rast

# plotting single image with 3 diff layers
plot(list_rast[[1]])
plot(list_rast[[2]])

# plotting first image in RGB space with NIR=1, red=2, green=3
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch = "Lin")
l1992 <- list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3, stretch = "Lin")
# plotting second image
l2006 <- list_rast[[2]]
plotRGB(l2006, r=1, g=2, b=3, stretch = "Lin")

# estimate amount of forest destroied
# unsupervied classification -> take the pixels and look if there are meaningful groups
# unsuperClass function (x, nClasses)
l1992c <- unsuperClass(l1992, nClasses=2)
l1992c # only 2 values -> one forest and one agricultural land
# passed from a raster brick (multilayer) to a raster layer -> all layer together in a single raster layer
# passeing from situa where 3 layers each with values 0-255 -> one layer with 2 values (1 & 2)
freq(l1992c$map)
# agricuktural land + water = 36313 (class 2)
# forest = 304979 (class 1)
total <- 341292 # tot amount of pixels -> run l1992c -> look at tird value of dimension (ncell)
# compute percentage of different land uses
propagri <- 36313/total
propforest <- 304979/total
propagri    # 0.1063986 -> 11%
propforest  # 0.8936014 -> 89%
# building a dataframe with type of cover and proportion of pixels
cover <- c("Forest", "Agriculture")
prop1992 <- c(0.8936014, 0.1063986)
proportion1992 <- data.frame(cover, prop1992) # proportion of pixels in 1992
proportion1992 # quantitative data
# plotting data with ggplot2
# ggplot function -> first argument = dataset, other arguments = aesthetic, color stored in cover
# geom_bar function explainig type of graph
p1 <- ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
# to change limit from 0 to 1 -> add to ggplot "+ ylim(0,1)"

# second image
l2006c <- unsuperClass(l2006, nClasses=2)
l2006c
plot(l2006c$map)
freq(l2006c$map) # frequences of our map
# class 1 (white) -> forest -> 163566
# class 2 (green) -> agrucultural and water -> 179160
tot06 <- 342726

propagri06 <- 179160/tot06
propforest06 <- 163566/tot06
propagri06    # 0.52275 -> 52%
propforest06  # 0.47725 -> 48%

# building a dataframe with type of cover and proportion of pixels
cover <- c("Forest", "Agriculture")
prop2006 <- c(propforest06, propagri06)
proportion2006 <- data.frame(cover, prop2006) # proportion of pixels in 1992
proportion2006 # quantitative data

# plotting data with ggplot2
# ggplot function -> first argument = dataset, other arguments = aesthetic, color stored in cover
# geom_bar function explainig type of graph
# stat - statistics used, identity bc we're using data as they are (no median or mean)
p2 <- ggplot(proportion2006, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white")+ ylim(0,1)

proportion <- data.frame(cover, prop1992, prop2006)
proportion

# plotting the 2 graph together
grid.arrange(p1, p2, nrow=1)

# plotting with patchwork package
library(patchwork)
p1 + p2  # plottin graphs in 1 row
p1 / p2  # plottin graphs in 1 column

# patchwork works with raster data but they should be plotted with ggplot



# 13/12/2021

setwd("/Users/magalicorti/Desktop/lab/")
library(raster)
library(ggplot2) 
library(gridExtra) 
library (RStoolbox)
library(patchwork)

# using ggRGB instead of plotRGB
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")
ggRGB(l1992, r=1, g=2, b=3)
# playing with stretch function
ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
ggRGB(l1992, r=1, g=2, b=3, stretch="hist")  # see things not visible at human eyes -> not a photo but a scan by satellite
ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")  # compacting the data -> to remove extreme data use square root or persantage
ggRGB(l1992, r=1, g=2, b=3, stretch="log")   # compacting the data

# square root or persantage not use if you want to stress gravity of events
log(100) # in R log not in base 10 but base 2

# patchwork
gp1 <- ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
gp2 <-ggRGB(l1992, r=1, g=2, b=3, stretch="hist") 
gp3 <- ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")  
gp4 <- ggRGB(l1992, r=1, g=2, b=3, stretch="log")

gp1 + gp2 + gp3 + gp4

# multitemporal patchwork -> plotting together data about 1992 & 2006
l2006 <- list_rast[[2]]
gp1 <- ggRGB(l1992, r=1, g=2, b=3)
gp5 <- ggRGB(l2006, r=1, g=2, b=3) 
gp1 + gp5
gp1 / gp5









