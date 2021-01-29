# install.packages("pacman")

library(pacman)
pacman::p_load(ntbox, rgl, marmap, oce, raster, stringr, oceanmap, tmap, lubridate, dplyr, plyr, gplots,
               tmaptools, fields, maptools, binovisualfields, rgdal, maps, rworldmap, mapplots, geoR, sf, 
               ncdf4, prettymapr, SDMTools, RColorBrewer, Metrics, ROCR, mapdata, pgirmess, ggplot2, gapminder, forcats)
source("code/auxiliar_functions.R")


# Binary map --------------------------------------------------------------
fileSuitability           <- "Final_Models/M_0.5_F_lq_Set1_EC/Octopus_maya_median.asc"
filePresence              <- "dataset/csv_files/Oct_may_train.csv"

bin <- binary_map(fileSuitability = fileSuitability, 
                  filePresence = filePresence, 
                  prop = 5/100)

writeRaster(x = bin$model, filename ="Final_Models/Octopus_maya_median_bin.asc")



# -------------------------------------------------------------------------
# -------------------------------------------------------------------------

# Binarize scenarios: Extrapolation with Clamping (EC) --------------------

# List files pattern
list_files      <- list.files(path ='Final_Models/M_0.5_F_lq_Set1_EC/', full.names = TRUE)
pattern_RCP     <- str_detect(list_files, "0_median")
files_RCP       <- list_files[pattern_RCP] #filter

#Covert to stack the .asc files
stack_files_RCP <- stack(files_RCP)

# binarize each scenario
bin_scenarios(binmodel = bin, stack_files_RCP = stack_files_RCP, folder_name = "M_0.5_F_lq_Set1_EC_bin")



# Binarize scenarios: Extrapolation (E) -----------------------------------
setwd("./../..") #back to the directory
# List files pattern
list_files      <- list.files(path ='Final_Models/M_0.5_F_lq_Set1_E/', full.names = TRUE)
pattern_RCP     <- str_detect(list_files, "0_median")
files_RCP       <- list_files[pattern_RCP] #filter

#Covert to stack the .asc files
stack_files_RCP <- stack(files_RCP)

# binarize each scenario
bin_scenarios(binmodel = bin, stack_files_RCP = stack_files_RCP, folder_name = "M_0.5_F_lq_Set1_E_bin")



# Binarize scenarios: No Extrapolation (NE) -------------------------------
setwd("./../..") #back to the directory
# List files pattern
list_files      <- list.files(path ='Final_Models/M_0.5_F_lq_Set1_NE/', full.names = TRUE)
pattern_RCP     <- str_detect(list_files, "0_median")
files_RCP       <- list_files[pattern_RCP] #filter

#Covert to stack the .asc files
stack_files_RCP <- stack(files_RCP)

# binarize each scenario
bin_scenarios(binmodel = bin, stack_files_RCP = stack_files_RCP, folder_name = "M_0.5_F_lq_Set1_NE_bin")

