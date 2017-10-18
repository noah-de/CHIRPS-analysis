# load the raster, sp, and rgdal packages
library(sp)
library(raster)
library(rgdal)

# Gather all the data files into a list
rasterlist1 <-  list.files('TIF', full.names=TRUE)

# create a sigle raster from the list
mRaster <-stack(rasterlist1)

# Set the min and Max values
mRaster <- setMinMax(mRaster)

# create histograms
# hist(mRaster, main="Distribution Rainfall values",  col= "brown", maxpixels=22000000)
# col <- terrain.colors(5)
# image(mRaster[1], zlim=c(250,375), main="Image", col=col)



plot(mRaster)
