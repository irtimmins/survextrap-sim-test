# Specify a "true" survival function based on real survival data
#'
#' @param true_mod true model and censoring distribution, returned from dgm
#' @param N Number of patients in trial
#' @param seed Random number seed

simulate_dgm <- function(true_mod, N, seed){
  
  # Create a new simulated baseline characteristics dataset of size N
  # This will be the same base dataset used in all simulated datasets.
  #
  # Another option would be to simulate a different censoring distribution for each simulated dataset
  x <- data.frame(id=1:N)
  
  # Censoring times (if no events)
  x$censtime = simulate(true_mod$true_cens, nsim=1, newdata= x, tidy=T)$time
  
  # Simulate events
  sim_data <- simulate(true_mod$true_mod, nsim=1, newdata= x,
                       tidy=T, censtime = x$censtime)
  
  return(sim_data=sim_data)
  
  
  
}
