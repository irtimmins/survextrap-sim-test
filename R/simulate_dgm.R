## Simulate from the "true" survival model

## TODO
##
##
## Need to generalise to simulate multiple datasets,
## Though how efficient is this, could we ensure this was parallelisable?
## rather than looping?
##
## Could add commands for saving any simulated datasets
## for reproducibility
##
## Can frailty term be added to make more realistic?
##
## Could add treatment and covariate effects,
## under different PH/non-PH/waning assumptions,
## to explore robustness


#'
#' @param true_mod true model and censoring distribution, returned from dgm
#' @param N Number of patients in trial
#' @param seed Random number seed

simulate_dgm <- function(true_mod, N, seed){
  
  # Create a new simulated baseline characteristics dataset of size N

  x <- data.frame(id=1:N)
  
  # Censoring times (if no events)
  x$censtime = simulate(true_mod$true_cens, nsim=1, newdata= x, tidy=T)$time
  
  # Simulate events
  sim_data <- simulate(true_mod$true_mod, nsim=1, newdata= x,
                       tidy=T, censtime = x$censtime)
  
  return(sim_data=sim_data)
  
  
  
}
