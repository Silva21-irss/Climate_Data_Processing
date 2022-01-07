## Access ClimateNA data through R

setwd("E:/ClimateNA");getwd() # Set up location for the application
exe <- "ClimateNA_v7.20.exe"


## Access Historical data
inputFile = '/E:\\DEM\\Res 250 meters\\Acadiadem.csv' # Input locations
outputFile = '/E:\\DEM\\Res 250 meters\\Acadiadem\\Acadia_normal.csv' # Output location
yearPeriod = '/Normal_1981_2010.nrm' # Historical data
system2(exe,args= c('/M', yearPeriod, inputFile, outputFile)) # Use '/M' for monthly data


## To access 20 Year Futures, you first have to copy and paste the files from \GCMdat\20YearPeriod into \GCMdat
yearPeriod = '/13GCMs_ensemble_ssp126_2001-2020.gcm' # Futures data
outputFile = '/E:\\DEM\\Res 250 meters\\Test\\Acadia_13GCMsEnsemble_ssp126_2001-2020.csv' # Output location

system2(exe,args= c('/M', yearPeriod, inputFile, outputFile)) # Use '/M' for monthly data

dat <- read.csv('E:/DEM/Res 250 meters/Test/Acadia_normal.csv'); head(dat) # Access output

## Access multiple futures
GCMs20 <- list.files(path='E:/ClimateNA/GCMdat/20YearPeriod')
for(i in 1:280){GCMs20[i] <- paste0('/',GCMs20[i])} # Get the names of all 280 gcm files
for(i in GCMs20){ # Produce all future climate projections
  outputFile = paste0('/E:\\DEM\\Res 250 meters\\Acadiadem\\',substr(i,2,nchar(i)-4),'.csv') # Output location
  system2(exe,args= c('/M', i, inputFile, outputFile)) # Use '/M' for monthly data
}
dat <- data.frame() # Create blank data frame
files.gcm <- list.files(path='E:/DEM/Res 250 meters/Acadiadem') # List all outputs
for(i in files.gcm){ # Loop through all the files to stack them into one data frame
  gcm_output <- read.csv(paste0('E:/DEM/Res 250 meters/Acadiadem/',i))
  gcm_output[1] <- substr(i,1,nchar(i)-4)
  dat <- rbind(dat,gcm_output)
}
colnames(dat)[1] <- 'GCM' # Rename first column 
write.csv(dat,'E:/DEM/Res 250 meters/Acadia_Future280GCMs.csv') # Write CSV file
