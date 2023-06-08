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
source("functions/sim_all.R")




res <- sim_all(data = control,
    k_true = 3,
    k_true_cens = 4,
    N = 10000,
    p_normal_sd = 20,
    p_gamma_shape = 2,
    p_gamma_rate = 1,
    mspline_degree = 3,
    mspline_bsmooth = TRUE,
    mspline_df = 8,
    maxT = 5.5,
    seed = 161)

#vis_mod(true_mod = res$true_mod, fit_mod = res$fit_mod)

#res$est_mod