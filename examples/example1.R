# example workflow of demonstrating each function.

library(tidyverse)
library(survextrap)
library(flexsurv)

rm(list=ls())

source("functions/specify_dgm.R")
source("functions/simulate_dgm.R")
source("functions/fit_model.R")
source("functions/estimands.R")
source("functions/visualise.R")

# import trial data from cetux control arm

control <- cetux[cetux$treat=="Control",]

# end of trial follow-up time for rmst computation

maxT_control <- max(control$years)

# fit FPM to control data, which will be "true" survival model

true_mod <- dgm(data = control, k_true = 3, k_true_cens = 4, maxT = maxT_control)

# simulate trial data from "true" model, with 1000 persons.

sim_data <- simulate_dgm(true_mod = true_mod, N = 1000, seed = 161)

# fit survextrap model to new simulated trial data, specifiying survextrap parameters

fit_mod <- fit_model(sim_data = sim_data,
                     prior_hscale = p_normal(0, 20),
                     prior_hsd = p_gamma(2,1),
                     mspline_fit = list(degree = 3,
                                        bsmooth = TRUE,
                                        df = 10),
                     maxT = maxT_control)

# compute estimands (area between hazard curves, rmst)

est_mod <- estimands(true_mod = true_mod, 
                     fit_mod = fit_mod, 
                     maxT = maxT_control)

# visualise true and fitted hazard curves

vis_mod(true_mod = true_mod, fit_mod = fit_mod, maxT = maxT_control )
