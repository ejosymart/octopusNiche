library(pacman)
pacman::p_load(oce, mgcv, raster)
source("code/0_auxiliar_functions.R")

# -------------------------------------------------------------------------
# Suitability and binary maps ---------------------------------------------
# -------------------------------------------------------------------------

# Stack of layers for physiological analyses
sta <- list.files(path='dataset/asc_files/Physiological/scenarios/',  full.names= TRUE)
sta <- raster::stack(sta)

# The inputs are minimum pejus, mean preference, maximum pejus,
# a stack with rasters where to project thermal preferences and
# the name of the folder. This folder will be saved in final 
# models

Temp_fit(pejus_min   = 13, 
         optimum_min = 18, 
         mean        = 22, 
         optimum_max = 26, 
         pejus_max   = 30, 
         stack       = sta, 
         folder_name = 'Physiology')