import os, arcpy
from arcpy import env
from arcpy.sa import *

# Set up folders where to access data and where to save it
folderSpace = r"e:\DEM\Res 250 meters\quesneldem"
folderSave = "E:\\DEM\\Res 250 meters\\quesneldem\\TIF\\"
shapefile = "D:\\Shapefiles\\quesnel_tsa_bdy.shp" # Change based on boundary shapefile location
env.workspace = folderSpace

myrasters = arcpy.ListRasters("*")
arcpy.CheckOutExtension("Spatial")

rast = []
for x in myrasters:
    gcm = x[0:-6]
    if x[-6:-4] == '01':
        rast.append(x)
        for item in myrasters:
            if item[0:-6] == gcm and item[-6:-4] in ['02','12']:
                rast.append(item)
            if len(rast) == 3:
                print('Calculating Winter Data for ' + gcm)
                outCellStats = CellStatistics(rast,'MEAN','DATA')
                arcpy.Clip_management(outCellStats,"#",folderSave + 'WINTER' + gcm + ".tif", shapefile, '#','ClippingGeometry','MAINTAIN_EXTENT') 
                rast = []
    if x[-6:-4] == '03':
        rast.append(x)
        for item in myrasters:
            if item[0:-6] == gcm and item[-6:-4] in ['04','05']:
                rast.append(item)
            if len(rast) == 3:
                print('Calculating Spring Data for ' + gcm)
                outCellStats = CellStatistics(rast,'MEAN','DATA')
                arcpy.Clip_management(outCellStats,"#",folderSave + 'SPRING' + gcm + ".tif", shapefile, '#','ClippingGeometry','MAINTAIN_EXTENT') 
                rast = []
    if x[-6:-4] == '06':
        rast.append(x)
        for item in myrasters:
            if item[0:-6] == gcm and item[-6:-4] in ['07','08']:
                rast.append(item)
            if len(rast) == 3:
                print('Calculating Summer Data for ' + gcm)
                outCellStats = CellStatistics(rast,'MEAN','DATA')
                arcpy.Clip_management(outCellStats,"#",folderSave + 'SUMMER' + gcm + ".tif", shapefile, '#','ClippingGeometry','MAINTAIN_EXTENT') 
                rast = []
    if x[-6:-4] == '09':
        rast.append(x)
        for item in myrasters:
            if item[0:-6] == gcm and item[-6:-4] in ['10','11']:
                rast.append(item)
            if len(rast) == 3:
                print('Calculating Autumn Data for ' + gcm)
                outCellStats = CellStatistics(rast,'MEAN','DATA')
                arcpy.Clip_management(outCellStats,"#",folderSave + 'AUTUMN' + gcm + ".tif", shapefile, '#','ClippingGeometry','MAINTAIN_EXTENT') 
                rast = []


