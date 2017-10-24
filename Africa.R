# load the raster, sp, and rgdal packages
library(sp)
library(raster)
library(rgdal)

# Gather all the data files into a list
rasterlist1 <-  list.files('test', full.names=TRUE)

# create a RasterStack from the list
sRaster <-stack(rasterlist1)

# Function to set values below 0 to NA
#NANegValues <- function(x) { x[x<0] <-NA; return(x)}

#rc2 <- calc(sRaster, NANegValues)


# Set the min and Max values
#sRaster <- setMinMax(rc2)

meanRemovesNA <- function(x) {
  mean(x[x>=0],na.rm=T)
}

# calc into a Raster Layer
xbar <- calc(sRaster, meanRemovesNA)

# writeRaster(xbar,'test.tif', options=c('TFW=YES'))
writeRaster(xbar, 'test.tif', options=c('TFW=YES'), format="GTiff", overwrite=TRUE)

# plot the map (SUM of rainfall values from the data files)
plot(xbar, main="Dekadal Rainfall Average 1981-2017 (mm)")