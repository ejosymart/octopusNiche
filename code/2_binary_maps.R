# install.packages("pacman")
library(pacman)
pacman::p_load(ntbox, rgl, marmap, oce, raster, stringr, oceanmap, tmap, lubridate, dplyr, plyr, gplots,
               tmaptools, fields, maptools, binovisualfields, rgdal, maps, rworldmap, mapplots, geoR, sf, 
               ncdf4, prettymapr, SDMTools, RColorBrewer, Metrics, ROCR, mapdata, pgirmess, ggplot2, gapminder, forcats)
source("code/0_auxiliar_functions.R")

# -------------------------------------------------------------------------
# Binarize scenarios: Extrapolation (E) -----------------------------------
# -------------------------------------------------------------------------

# Binary map --------------------------------------------------------------
fileSuitability           <- "Final_Models/M_0.5_F_l_Set1_E/Octopus_maya_median.asc"
filePresence              <- "dataset/csv_files/Oct_may_train.csv"

bin <- binary_map(fileSuitability = fileSuitability, 
                  filePresence = filePresence, 
                  prop = 5/100)

# List files pattern
list_files      <- list.files(path ='Final_Models/M_0.5_F_l_Set1_E/', full.names = TRUE)
pattern_RCP     <- str_detect(list_files, "0_median")
files_RCP       <- list_files[pattern_RCP] #filter

#Covert to stack the .asc files
stack_files_RCP <- stack(files_RCP)

# binarize each scenario
bin_scenarios(binmodel = bin, stack_files_RCP = stack_files_RCP, folder_name = "M_0.5_F_l_Set1_E_bin")

# Save binarized current scenario
writeRaster(x = bin$model, filename ="Octopus_maya_median_bin.asc")

setwd("./../..") #back to the directory (mandatory)
