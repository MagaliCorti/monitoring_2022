# this is my first code in GitHub




# 15/10/2021

# here are the input data
# costanza's data on stream
water <- c(100, 200, 300, 400, 500)
water

# marta's data on fishes genomes
fishes <- c(10, 50, 60, 100, 200)
fishes

# plot the diversity of fishes (y) vs the amount of water (x)
plot(water, fishes)




# 18/10/2021

# data.frame fonction to make a table with the data. 
data.frame(water, fishes)

# to give a name to the table: <-
streams <- data.frame(water, fishes)

# View function to visualize the table
View(streams)




# 22/10/2021

# from now on we're going to inporting and exporting data
# setting the working directory in which we're going to store all the data
# working directory: folder to store all the data; setting it: telling R what folder it should use
# using quotes ["] to safely exit R

# setwd("/iCloud_Drive/Scrivania/lab/") non funziona non guardare "situato in"
setwd("/Users/magalicorti/Desktop/lab/")

# the data we develop can be stored in a table
# function(argument, argument, ...)
streams <- data.frame(water, fishes)

# write.table	export table
# read.table	import table

# let's export our table!
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/write.table
write.table(streams, file="my_first_table.txt")

# some collegues did send us a file let's see how can we inport the data set in R
read.table("my_first_table.txt")
# let's assign it to an object inside R
magalitable <- read.table("my_first_table.txt")

# this is the first statistics for lazy peaople
# https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/summary
summary(magalitable)

# students' age
mean(c(22, 23, 24, 25, 26, 27))
median(c(22, 23, 24, 25, 26, 27))

# marta only interested in fishes
# $ to link table to a variable
summary(magalitable$fishes)

# histograme to visualize the number of data for each range of values
hist(magalitable$fishes)
hist(magalitable$water)




# 25/10/2021

# R code for ecosystem monitoring by remote sensing
# first we need to download an additional R package
# https://www.rdocumentation.org/packages/utils/versions/3.6.2/topics/install.packages
# https://cran.r-project.org/web/packages/raster/index.html

install.packages("raster")
library(raster)



