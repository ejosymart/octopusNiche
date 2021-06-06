# -------------------------------------------------------------------------
# Functions for analyses --------------------------------------------------
# -------------------------------------------------------------------------

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


Temp_fit <- function(pejus_min, optimum_min, mean, optimum_max, pejus_max, stack, folder_name, ...){
  
  options(warn=-1)
  newdir <- paste0('Final_Models/', folder_name)
  dir.create(newdir)
  
  # GAM analysis
  dat <- data.frame(x = c(pejus_min, optimum_min, mean, optimum_max, pejus_max), y=c(0, 0.75, 1 ,0.75, 0))
  plot.new() # Mandatory
  res <- xspline(dat$x, dat$y, -0.5, draw=FALSE)
  tem <- res$x
  fit <- res$y
  phy <- data.frame(cbind(tem, fit))
  gam_fit <- gam(fit ~ s(tem, k = 15),
                 data = phy, method = "REML", family = "gaussian")
 
  # Projection
  for(i in 1:length(names(stack))){
    # Suitability maps
    f   <- paste0(names(stack[[i]]), '.asc')
    ras <- stack[[i]] 
    names(ras)   <- 'tem'
    pre <- predict(ras, gam_fit, family=gaussian, type="response", scale=TRUE)
    pre[pre < 0] <- 0
    pre <- pre/pre@data@max #relativizing values
    writeRaster(pre, filename = paste0(newdir,'/',f), overwrite=TRUE) 
    
    # Binary maps
    pre[pre != 0] <-1
    writeRaster(pre, filename = paste0(newdir,'/','bin_',f), overwrite=TRUE) 
  }
  options(warn=0)
}
