# Specify a "true" survival function based on real survival data
#'
#' @param data Real dataset with years/d as time/event columns
#' @param k_true Number of knots used in true FPM model fitted to the data
#' @param k_true_cens Number of knots used in true FPM censoring model fitted to the data
#' @param maxT, maximum time for hazard rate calculation


dgm <- function(data, k_true, k_true_cens, maxT){

  # fit Royston-Parmar model 
  true_mod <- flexsurv::flexsurvspline(Surv(years, d) ~ 1, 
                                       data=data, k=k_true)
  
  # Random-censoring distribution
  true_cens <- flexsurv::flexsurvspline(Surv(years, 1-d) ~ 1, 
                                        data=data, k=k_true_cens)
  
  true_haz <- standsurv(true_mod, t=seq(0, maxT, by=0.01), type="hazard")

  return(list(true_mod=true_mod, true_cens=true_cens, true_haz=true_haz))  
  
}
