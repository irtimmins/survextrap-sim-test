# Fit survextrap model
#'
#' @param sim_data
#' @param prior_hscale 
#' @param prior_hsd 
#' @param mspline_fit 
#' @param maxT maximum time for hazard rate calculation



fit_model <- function(sim_data, prior_hscale, prior_hsd, mspline_fit, maxT , seed){

set.seed(seed)  
  
fit_mod <-  survextrap(Surv(time, event) ~ 1, 
                                   mspline = mspline_fit, 
                                   prior_hscale = prior_hscale,
                                   prior_hsd = prior_hsd,
                                   data=sim_data,
                                   fit_method="opt")

fit_haz <- hazard(fit_mod,
                         t = seq(0, maxT, by=0.01), 
                         niter= 100)


return(list(fit_mod=fit_mod, fit_haz=fit_haz)) 

}

