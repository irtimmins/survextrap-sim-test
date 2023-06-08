# example workflow.

library(tidyverse)
library(survextrap)
library(flexsurv)

rm(list=ls())


source("functions/specify_dgm.R")
source("functions/simulate_dgm.R")
source("functions/fit_model.R")
source("functions/estimands.R")
source("functions/visualise.R")

control <- cetux[cetux$treat=="Control",]
maxT_control <- max(control$years)
true_mod <- dgm(data = control, k_true = 3, k_true_cens = 4, maxT = maxT_control)
sim_data <- simulate_dgm(true_mod = true_mod, N = 10000, seed = 161)
fit_mod <- fit_model(sim_data = sim_data,
                     prior_hscale = p_normal(0, 20),
                     prior_hsd = p_gamma(2,1),
                     mspline_fit = list(degree = 3,
                                        bsmooth = TRUE,
                                        df = 10),
                     maxT = maxT_control)
est_mod <- estimands(true_mod = true_mod, 
                     fit_mod = fit_mod, 
                     maxT = maxT_control)

vis_mod(true_mod = true_mod, fit_mod = fit_mod, maxT = maxT_control )


head(est_mod)
head(sim_data)








