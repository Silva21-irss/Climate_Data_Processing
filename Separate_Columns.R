## Separate the name of each class of climate component based on the model, ssp, and time frame

# Access Data [INSERT FILE FROM YOUR DIRECTORY]
data <- read.csv('E:/DEM/Res 250 meters/Estrie_DEM_280 GCMsMP.csv')

u <- as.data.frame(unique(data$Year))
names(u) <- 'Year'

u$Time_Frame <- substr(u$Year,nchar(u$Year)-12,nchar(u$Year)-4)
u$SSP <- substr(u$Year,nchar(u$Year)-19,nchar(u$Year)-14)
u$Climate_Model <- substr(u$Year,1,nchar(u$Year)-21)
