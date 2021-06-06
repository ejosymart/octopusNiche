# To install kuenm following the next steps
# install_packages("devtools")
# library(devtools)
# devtools::install_github("marlonecobos/kuenm")

library(kuenm)

# -------------------------------------------------------------------------
# Model calibration -------------------------------------------------------
# -------------------------------------------------------------------------

# Input files
occ_joint   <- "dataset/csv_files/Oct_may_joint.csv"
occ_tra     <- "dataset/csv_files/Oct_may_train.csv"
M_var_dir   <- "M_variables"      #follow the structure file (environmental variables)
batch_cal   <- "Candidate_models"
out_dir     <- "Candidate_Models"
reg_mult    <- c(seq(0.5, 4, 0.5)) # regularization multiplier
f_clas      <- c("l","lq","lqp")   # features (linear, quadratic, product)
maxent_path <- "maxent"
wait        <- FALSE
run         <- TRUE

kuenm_cal(occ.joint   = occ_joint, 
          occ.tra     = occ_tra, 
          M.var.dir   = M_var_dir, 
          batch       = batch_cal,
          out.dir     = out_dir, 
          reg.mult    = reg_mult, 
          f.clas      = f_clas, 
          maxent.path = maxent_path, 
          wait        = wait, run = run)
# After run the code above, select and open the file Candidate_models.bat in order to generate all the models that
# will be saved in the Candidate_Models folder.



# -------------------------------------------------------------------------
# Model selection ---------------------------------------------------------
# -------------------------------------------------------------------------
occ_test     <- "dataset/csv_files/Oct_may_test.csv"
out_eval     <- "Calibration_results"
threshold    <- 5         # omission rate
rand_percent <- 50        # related to partial ROC
iterations   <- 100  
kept         <- FALSE     # to keep (TRUE) or delete (FALSE) the candidate models 
selection    <- "OR_AICc"      # Omission rate
paral_proc   <- FALSE # make this true to perform pROC calculations in parallel, recommended
                     # only if a powerful computer is used (see function's help)
# Note, some of the variables used here as arguments were already created for previous function

cal_eval <- kuenm_ceval(path          = out_dir, 
                        occ.joint     = occ_joint, 
                        occ.tra       = occ_tra, 
                        occ.test      = occ_test, 
                        batch         = batch_cal,
                        out.eval      = out_eval, 
                        threshold     = threshold, 
                        rand.percent  = rand_percent, 
                        iterations    = iterations,
                        kept          = FALSE, 
                        selection     = selection, 
                        parallel.proc = paral_proc)

### To replicate the results select only the model of the first row of the
### best_candidate_models_OR_AICc.csv (delete the second row)



# -------------------------------------------------------------------------
# Model Projections -------------------------------------------------------
# -------------------------------------------------------------------------
batch_fin   <- "Final_models"
mod_dir     <- "Final_Models"
rep_n       <-  10            #change the number of runs if you wish
rep_type    <- "Bootstrap"
jackknife   <- TRUE
out_format  <- "logistic"
project     <- TRUE
G_var_dir   <- "G_variables"   #here is the RCP scenarios (.asc)
ext_type    <- "ext"
write_mess  <- FALSE
write_clamp <- TRUE
wait1       <- FALSE
run1        <- TRUE
args        <- NULL 


kuenm_mod(occ.joint   = occ_joint, 
          M.var.dir   = M_var_dir, 
          out.eval    = out_eval, 
          batch       = batch_fin, 
          rep.n       = rep_n,
          rep.type    = rep_type, 
          jackknife   = jackknife, 
          out.dir     = mod_dir, 
          out.format  = out_format, 
          project     = project,
          G.var.dir   = G_var_dir,
          ext.type    = ext_type,
          write.mess  = write_mess,
          write.clamp = write_clamp,
          maxent.path = maxent_path,
          args        = args, 
          wait        = wait1, 
          run         = run1)

# After run the code above, select and open the file Final_models.bat in order to generate all the models that
# will be saved in the Final_Models folder. When the projections are done the cmd.exe will close automatically.



# -------------------------------------------------------------------------
# Non analogous conditions analysis ---------------------------------------
# -------------------------------------------------------------------------
sets_var <- "Set1" # here a vector of various sets can be used
out_mop  <- "MOP_results"
percent  <- 5
paral    <- FALSE # make this true to perform MOP calculations in parallel, recommended
               # only if a powerfull computer is used (see function's help)
# Two of the variables used here as arguments were already created for previous functions


kuenm_mmop(G.var.dir = G_var_dir, 
           M.var.dir = M_var_dir, 
           is.swd    = FALSE,  
           sets.var  = sets_var, 
           out.mop   = out_mop,
           percent   = percent, 
           parallel  = paral, 
           comp.each = 100)