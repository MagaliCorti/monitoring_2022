# 26/11/2021

# R code for chemical cycle studies
# time series of NO2 change in Europe during lockdown

setwd("/Users/magalicorti/Desktop/lab/en/")
library(raster)

# raster function importing every single layer one after the other creating a single layer
en01 <- raster("EN_0001.png")
# what is the range of this data? (min and max values) -> 0 - 255
# very common range (also range of smartphone photos) -> 8 bit image
# 01 - 1 bit - 2^1
# 00 01 10 11 - 2 bits - 2^2
# 8 bits - 2^8 = 256 the final one will not bw called 256 but 255 bc the first one was colled 0 (not 1)

cl = colorRampPalette(c("red", "orange", "yellow"))(100)
# https://www.google.com/search?q=R+colours+names&tbm=isch&ved=2ahUKEwiF-77Z1bX0AhULtKQKHQ3WDWYQ2-cCegQIABAA&oq=R+colours+names&gs_lcp=CgNpbWcQAzIECAAQEzoHCCMQ7wMQJzoICAAQCBAeEBNQiQhYnwxgwg1oAHAAeACAAUqIAZYDkgEBNpgBAKABAaoBC2d3cy13aXotaW1nwAEB&sclient=img&ei=vKKgYYWtOovokgWNrLewBg&bih=526&biw=1056#imgrc=OtMzJfyT_OwIiM
plot(en01, col = cl)
# higher amount of human being -> higher pollution

# import March 2021 (last image) and plot it
en13 <- raster("EN_0013.png")
plot(en13, col=cl)

# build a multiframe image withe the two plot jan-march one on top of the other
par(mfrow=c(2,1))
plot(en01, col = cl)
plot(en13, col=cl)
# NO2 remains high in agricultural areas but very reduced in cities

# import all images
en01 <- raster("EN_0001.png")
en02 <- raster("EN_0002.png")
en03 <- raster("EN_0003.png")
en04 <- raster("EN_0004.png")
en05 <- raster("EN_0005.png")
en06 <- raster("EN_0006.png")
en07 <- raster("EN_0007.png")
en08 <- raster("EN_0008.png")
en09 <- raster("EN_0009.png")
en10 <- raster("EN_0010.png")
en11 <- raster("EN_0011.png")
en12 <- raster("EN_0012.png")
en13 <- raster("EN_0013.png")

# plot all data together

# using par -> very repetitive and boring, too much code
par(mfrow=c(4,4))
plot(en01, col = cl)
plot(en02, col = cl)
plot(en03, col = cl)
plot(en04, col = cl)
plot(en05, col = cl)
plot(en06, col = cl)
plot(en07, col = cl)
plot(en08, col = cl)
plot(en09, col = cl)
plot(en10, col = cl)
plot(en11, col = cl)
plot(en12, col = cl)
plot(en13, col = cl)

# using stack -> single layers all together
en <- stack(en01, en02, en03, en04, en05, en06, en07, en08, en09, en10, en11, en12, en13)
plot(en, col=cl)

# plot only firt image of stack
# we should put the name inside the stack -> check the stack name to see data of stack and names
en
plot(en$EN_0001, col=cl)

# plot rgb space with images inside
# we put in r component the first image (Jan), g = intermediate situation, b = last image (final situation)
plotRGB(en, r=1, g=7, b=13, stretch="Lin")
# red parts are the one that were high in NO2 at the beginning and than went down
# blu highest in March (end) but low before
# yellow or white are regions in which NO2 very high all the time (bc of agriculture or industries)




# 29/11/2021

library(raster)
setwd("/Users/magalicorti/Desktop/lab/en/")

# importing data all together with lapply function
# our list -> all the files with "EN" in the name (same pattern)
rlist <- list.files(pattern = "EN")
rlist

# l apply to apply a specific function to a chosen argument -> apply raster function to rlist
# lapply(x, FUN)
list_rast <- lapply(rlist, raster)
list_rast

# stack to put all file imported together
EN_stack <- stack(list_rast)

# we can plot all together the images (with colorRampPalette)
cl = colorRampPalette(c("red", "orange", "yellow"))(100)
plot(EN_stack, col=cl)

# plot only 1st imagage of stack
plot(EN_stack$EN_0001, col=cl)

# difference bw final and first images
ENdif <- (EN_stack$EN_0001 - EN_stack$EN_0013)
# higest variability in red vs lowest in blue
cldif = colorRampPalette(c("blue", "white", "red"))(100)
plot(ENdif, col=cldif)

# automaded processing source function
# to directly open code saved on the computer on whatever text editor file
source("r_code_automatic_scrypt.r")


