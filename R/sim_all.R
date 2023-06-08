# sim_all wrap all functions into pipeline
# 
# bias in rmst is single output
# 
# could be generalised to provide output on other
# performance measures and estimands,
# such as area between hazard or survival curves.
#
# could also add further parameters to specify
# M-spline model, such as the location of final knot(s)
# 
#
#'
#' @param data Dataset to use for simulation, with years/d as time/event columns
#' @param k_true Number of knots used in true FPM model fitted to the data
#' @param k_true_cens Number of knots used in true FPM censoring model fitted to the data
#' @param maxT maximum time for rmst and area calculations
#' @param N Number of patients in trial
#' @param p_normal_sd specify sd for prior_hscale for eta
#' @param p_gamma_shape specify shape of gamma prior_hsd for smoothing parameter sigma
#' @param p_gamma_rate specify rate of gamma prior_hsd for smoothing parameter sigma
#' @param mspline_degree  degree of spline
#' @param mspline_bsmooth smoothing constraints on boundary knot
#' @param mspline_df degrees of freedom of M-splines
#' @param maxT, maximum time for rmst and area calculations
#' @param seed Random number seed

sim_all <- function(data=control,
                k_true,
                k_true_cens,
                N,
                p_normal_sd,
                p_gamma_shape,
                p_gamma_rate,
                mspline_degree,
                mspline_bsmooth,
                mspline_df,
                maxT,
                seed){
  
 
  true_mod <- dgm(data = control, k_true = k_true, k_true_cens = k_true_cens,maxT = maxT)

  sim_data <- simulate_dgm(true_mod = true_mod, N = N, seed = seed)
  
  fit_mod <- fit_model(sim_data = sim_data,
                       prior_hscale = p_normal(0, p_normal_sd),
                       prior_hsd = p_gamma(p_gamma_shape, p_gamma_rate),
                       mspline_fit = list(degree = mspline_degree,
                                          bsmooth = mspline_bsmooth,
                                          df = mspline_df),
                       maxT = maxT,
                       seed = seed)
  
  est_mod <- estimands(true_mod = true_mod, 
                       fit_mod = fit_mod, 
                       maxT = maxT)
  
  return(rmst_diff = est_mod$true_rmst - est_mod$fit_rmst) 
  
}

