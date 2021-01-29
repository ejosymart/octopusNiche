binary_map <- function(fileSuitability, filePresence, prop, ...){
  
  model       <- raster::raster(fileSuitability)
  presence    <- read.csv(filePresence)
  presence    <- presence[, c(2,3)]
  suits       <- sort(stats::na.omit(raster::extract(x = model, y = presence)))
  npoints     <- length(suits)
  nsuits      <- npoints * prop 
  int_npoints <- round(nsuits)
  
  if(int_npoints < npoints && npoints > 10){
    thpos <- ceiling(nsuits)
  }else{
    thpos <- int_npoints
  }
  thr <- suits[thpos]
  
  model[model < thr] <- 0
  model[model != 0] <- 1 
  
  return(list(model = model, threshold = thr))
}


bin_scenarios <- function(binmodel, stack_files_RCP, folder_name){
  
  #Define threshold
  threshold <- binmodel$threshold
  
  #Create new folder
  dir.create(paste0("Final_Models/", folder_name))
  setwd(paste0("Final_Models/", folder_name))
  
  #Bin according threshold
  for(i in 1:dim(stack_files_RCP)[3]){
    stack_files_RCP[[i]][stack_files_RCP[[i]] < threshold] <- 0
    stack_files_RCP[[i]][stack_files_RCP[[i]] != 0] <- 1 
    writeRaster(x = stack_files_RCP[[i]], filename = paste0(names(stack_files_RCP)[[i]], "_bin.asc"))
  }
  
}


Thermal_maps <- function(Sta, opt_min, opt_max, pej_min, pej_max, species, folder_name){
  
  Sta_opt <- raster::reclassify(Sta, c(opt_min, opt_max, 1))
  Sta_opt[Sta_opt!= 1] <- 0
  
  Sta_pej <- raster::reclassify(Sta, c(pej_min, pej_max, 1))
  Sta_pej[Sta_pej!= 1] <- 0
  
  #Create new folder
  dir.create(paste0("Final_Models/", folder_name))
  setwd(paste0("Final_Models/", folder_name))
  
  for(i in seq(1, dim(Sta)[3], 2)){
    
    #Optimum
    Sum_opt <- Sta_opt[[i]] + Sta_opt[[i+1]]
    Sum_opt[Sum_opt != 2] <- 0
    Sum_opt[Sum_opt == 2] <- 1
    
    f1 <- paste0(num[i],"_", species,"_","_", Scenarios[i], '.tif')
    
    #Saving raster file for optimum temperature
    writeRaster(Sum_opt, filename = f1 , overwrite = TRUE)
    
    #Pejus
    Sum_pej <- Sta_pej[[i]] + Sta_pej[[i+1]]
    Sum_pej[Sum_pej != 2] <- 0
    Sum_pej[Sum_pej == 2] <- 1
    
    #Calculating pejus from optimum overlap
    Sum_pej <- Sum_opt + Sum_pej
    Sum_pej[Sum_pej==2] <- 0
    f2 <- paste0(num[i],"_", species,"_","_", Scenarios[i+1], '.tif')
    
    
    #Saving raster file for pejus temperature
    writeRaster(Sum_pej, filename = f2, overwrite = TRUE)
    
  }
}


Pixel_area <- function(sta, lon, lat) {
  
  ext           <- extent(lon[1], lon[2], lat[1], lat[2])
  sta           <- crop(sta, ext)
  sta[sta == 0] <- NA
  crs(sta)      <- CRS("+proj=longlat +datum=WGS84")
  
  for(i in seq_along(1:length(names(sta)))){
    asc <- sta[[i]]
    f <- paste0(names(asc))
    area <- sum(values(area(asc))[!is.na(values(asc))])
    cat("The area of", f, "is", area, "km2", fill=TRUE)
  }
}

