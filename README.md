Silva21 Climate_Data_Processing

Ensure to export the hub site DEM as a lat/long projected ASCII file. After running it through the ClimateNA software, project every dataset using the ReprojectASCII.R script. After its completion, in python IDLE, run the data through the ProcessMonthlyDataIntoSeasonalMeans.py script to acquire seasonal mean TIF data.

If working with CSV files, use the Separate_Columns.R script to separate the model's name into three columns representative of the Model, SSP, and Time Frame. 

To access ClimateNA data through R, you may adapt the ClimateNA Data Acquisition.R script with your CSV file location
