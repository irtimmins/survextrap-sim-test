# Fit survextrap model
#'
#' @param dgm, true model, returned from dgm function
#' @param fit_mod fitted model, returned from fit_model function
#' @param maxT, maximum time for rmst and area calculations


estimands <- function(true_mod, fit_mod, maxT){
 
  ###############################
  # rmst estimands
  ###############################
  
  true_rmst <- standsurv(true_mod$true_mod, t=maxT, type="rmst")[[2]]
  fit_rmst <- rmst(fit_mod$fit_mod, t=maxT)[[3]]
 
  ###############################
  # area betweem hazard curves
  ###############################
  
  # increments for numerical integration
  # needs to be >= 10^4 for accuracy but slow.
  t.N <- 10^3
  t.vec <- seq(from = 0, to = maxT, length.out = t.N)

  haz_df <- tibble("true" =  standsurv(true_mod$true_mod, t=t.vec,type="hazard")[[2]],
                   "fit" = hazard(fit_mod$fit_mod, t=t.vec)[[2]])

  area_diff <- sum(abs(haz_df$true-haz_df$fit))/(t.N/(maxT-0))
  
  ###############################
  
  return(list(true_rmst=true_rmst, fit_rmst=fit_rmst, area_diff=area_diff))
  
}

