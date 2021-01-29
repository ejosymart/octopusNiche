library(pacman)
pacman::p_load(ntbox, rgl, marmap, oce, raster, stringr, oceanmap, tmap, lubridate, dplyr, plyr, gplots,
               tmaptools, fields, maptools, binovisualfields, rgdal, maps, rworldmap, mapplots, geoR, sf, 
               ncdf4, prettymapr, SDMTools, RColorBrewer, Metrics, ROCR, mapdata, pgirmess, ggplot2, gapminder, forcats)

setwd("./../..") #back to the directory


list_files  <- list.files(path ='dataset/asc_files/Physiology_presence/Benthic_max_min_temperature/', full.names = TRUE)
stack_files <- stack(list_files)


# Identifier  to generate figures in the correct order
# notice that for each scenario the id is repeated two times
num <- (rep(1:9, each=2))

#Scenario names. 
#First name of optimum scenario then pejus scenarios
Scenarios <- c('optimum_Present', 'pejus_Present',
               'optimum_RCP2_2050', 'pejus_RCP2_2050',
               'optimum_RCP2_2100', 'pejus_RCP2_2100',
               'optimum_RCP4_2050', 'pejus_RCP4_2050',
               'optimum_RCP4_2100', 'pejus_RCP4_2100',
               'optimum_RCP6_2050', 'pejus_RCP6_2050',
               'optimum_RCP6_2100', 'pejus_RCP6_2100',
               'optimum_RCP8.5_2050', 'pejus_RCP8.5_2050',
               'optimum_RCP8.5_2100', 'pejus_RCP8.5_2100')


# Presence/absence according to physiologycal tolerance -------------------
Thermal_maps(Sta     = stack_files, 
             opt_min = 20, 
             opt_max = 25.7, 
             pej_min = 17, 
             pej_max = 33, 
             species = 'Oct_may', 
             folder_name = "Physiologyc_benthic")
