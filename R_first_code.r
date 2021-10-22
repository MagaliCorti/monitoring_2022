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


# 22/10/2021

# from now on we're going to inporting and exporting data
# setting the working directory in which we're going to store all the data

# setwd("/iCloud_Drive/Scrivania/lab/") non funziona non guardare "situato in"
setwd("/Users/magalicorti/Desktop/lab/")

# the data we develop can be stored in a table
streams <- data.frame(water, fishes)

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
summary(magalitable$fishes)

# histograme to visualize the number of data for each range of values
hist(magalitable$fishes)
hist(magalitable$water)


