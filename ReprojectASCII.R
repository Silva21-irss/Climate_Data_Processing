#Reprojection script for raster files 
library(terra) # should only need this package. It is an updated and faster version of the raster package 

directory <- 'E:/DEM/Res 250 meters/quesneldem' # Change name to directory
setwd(directory) 
filenames <- list.files(path=getwd())
files <- filenames # Adjust if there are only a few files to process
r <- as.data.frame(NA)

for(x in files){
  #set file paths 
  dirin <- directory
  dirin <- paste(dirin,'/',x,sep="")
  #create list of file locations 
  list.dir <- list.files(dirin, pattern = ".*asc", full.names = TRUE)
  
  #loop through list of files 
  for(i in 1:length(list.dir)){

    name <- tools::file_path_sans_ext(basename(list.dir[i])) #this gets the filename (useful for naming outputs)

    raster <- rast(list.dir[i]) #load your .asc raster

    #crs(r) <- "EPSG:3005" Set the original crs if needed

    raster_reprojected <- terra::project(raster,"EPSG:4326") #this takes the raster i from the list and reporjects it to what ever EPSG code you need

    raster_reprojected[is.na(raster_reprojected)] <- -9999 # if needed this sets NA values to -9999 that are then returned into NA values by the NAflaG argument
    # ^ you may not need to do this. My ascii files needed to be reminded what represnets an NA value.
    
    r[i] <- as.data.frame(raster)

    writeRaster(raster_reprojected, paste0(dirin, name, ".asc"), overwrite=TRUE, NAflag = -9999) #<- remove NAflag if not needed

  }
  #write.csv(r,file = paste0(dirin,".csv"), row.names = TRUE)
}
