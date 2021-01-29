library(pacman)
pacman::p_load(ntbox, rgl, marmap, oce, raster, stringr, oceanmap, tmap, lubridate, dplyr, plyr, gplots,
               tmaptools, fields, maptools, binovisualfields, rgdal, maps, rworldmap, mapplots, geoR, sf, 
               ncdf4, prettymapr, SDMTools, RColorBrewer, Metrics, ROCR, mapdata, pgirmess, ggplot2, gapminder, forcats)

setwd("./../..") #back to the directory

# Cut and count -----------------------------------------------------------
list_files  <- list.files(path ='Final_Models/M_0.5_F_lq_Set1_E_bin/', full.names = TRUE)
stack_files <- stack(list_files)

Pixel_area(sta = stack_files, 
           lon = c(-94, -86), 
           lat = c(18,24))

# Continue with the other folder as you wish
# Select the correct folder for the anlysis.
