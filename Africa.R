# load the raster, sp, and rgdal packages
library(sp)
library(raster)
library(rgdal)

# Gather all the data files into a list
rasterlist1 <-  list.files('test', full.names = TRUE)

# make as list of all but the most recent data file
rasterlist <- head(rasterlist1, n = length(rasterlist1) - 1)

# create a RasterStack from the list
sRaster <- stack(rasterlist)

# Calculate the mean of positive real numbers, removing NA values
meanRemovesNA <- function(x) {
  mean(x[x >= 0], na.rm = T)
}

# calc into a Raster Layer
xbar <- calc(sRaster, meanRemovesNA)


# Save the Raster to a file
writeRaster(
  xbar,
  'test.tif',
  options = c('TFW=YES'),
  format = "GTiff",
  overwrite = TRUE
)

# plot the map (SUM of rainfall values from the data files)
#plot(xbar, main = "Dekadal Rainfall Climatology 1981-2017 (mm)")

# grab the last file from the original file list
recent <- tail(rasterlist1, n = 1)

# dumb way to make a stack and remove the NAs
latest <- calc(stack(recent, recent), meanRemovesNA)

# hist(latest - xbar)

# Calculate the anomaly
plot(latest -  xbar, col=rev(topo.colors(250)), main = "2017 Dekadal Rainfall Anomoly 1981-2016 (mm)")
