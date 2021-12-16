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






