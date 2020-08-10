# Linear regression between every 5×5 pixels group of cells of two rasters

library(raster)
library(gstat)
library(sp)
library(orcutt)
library(lmtest)
library(zoo)

# Set working directory
setwd("/Users/bennyistanto/R/FocalRegression/Input/")

# Raster import and stacking
fs <- list.files(path="/Users/bennyistanto/R/FocalRegression/Input", pattern = ".tif$", full.names = TRUE)
r <- raster::stack(fs)

# Focal linear regression
w <- c(5,5) # 5x5 neighbour/group of cells

lapse_1 <- r[[1]]
lapse_1[] <- NA
lapse_2 <- r[[1]]
lapse_2[] <- NA
lapse_3 <- r[[1]]
lapse_3[] <- NA
lapse_4 <- r[[1]]
lapse_4[] <- NA

for( rl in 1:nrow(r) ) { 
  
  v <- getValuesFocal(r[[1:2]], row=rl, nrows=1, ngb = w, array = FALSE)
  
  slopereg <- rep(NA,nrow(v[[1]])) # Slope
  intreg <- rep(NA,nrow(v[[1]])) # Intercept
  pvalslope <- rep(NA,nrow(v[[1]])) # P-value for Slope
  pvalint <- rep(NA,nrow(v[[1]])) # P-value for Intercept
  
  for(i in 1:nrow(v[[1]]) ) {
    xy <- na.omit( data.frame(x=v[[1]][i,],y=v[[2]][i,]) )    
    
    if( nrow(xy) > 0 ) {
      
      linmod <- coeftest(lm(as.numeric(xy$y) ~ as.numeric(xy$x)))
      
      slopereg[i] <- linmod[2]
      intreg[i] <- linmod[1]
      pvalslope[i] <- linmod[8]
      pvalint[i] <- linmod[7]
      
      if(is.null(slopereg)) slopereg = 1
      if(is.null(intreg)) intreg = 1
      if(is.null(pvalslope)) pvalslope = 1
      if(is.null(pvalint)) pvalint = 1
      
    } else {
      
      slopereg[i] <- NA 
      intreg[i] <- NA
      pvalslope[i] <- NA 
      pvalint[i] <- NA
      
    }
  }
  lapse_1[rl,] <- slopereg
  lapse_2[rl,] <- intreg
  lapse_3[rl,] <- pvalslope
  lapse_4[rl,] <- pvalint
}

lapse_1
lapse_2
lapse_3
lapse_4

# Plot the result
plot(lapse_1)
plot(lapse_2)
plot(lapse_3)
plot(lapse_4)

# Saving output into geotiff
writeRaster(lapse_1, filename=file.path("/Users/bennyistanto/R/FocalRegression/Output/idn_cli_day1_03_mar_slope.tif"), format="GTiff", overwrite=TRUE)
writeRaster(lapse_2, filename=file.path("/Users/bennyistanto/R/FocalRegression/Output/idn_cli_day1_03_mar_intercept.tif"), format="GTiff", overwrite=TRUE)
writeRaster(lapse_3, filename=file.path("/Users/bennyistanto/R/FocalRegression/Output/idn_cli_day1_03_mar_pvalue_slope.tif"), format="GTiff", overwrite=TRUE)
writeRaster(lapse_4, filename=file.path("/Users/bennyistanto/R/FocalRegression/Output/idn_cli_day1_03_mar_pvalue_intercept.tif"), format="GTiff", overwrite=TRUE)

# End of script