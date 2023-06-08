# example workflow.

library(tidyverse)
library(survextrap)
library(flexsurv)

rm(list=ls())


source("R/specify_dgm.R")
source("R/simulate_dgm.R")
source("R/fit_model.R")
source("R/estimands.R")
source("R/visualise.R")
source("R/sim_all.R")

control <- cetux[cetux$treat=="Control",]


# sim_all computes bias in rmst

res <- sim_all(data = control,
    k_true = 3,
    k_true_cens = 4,
    N = 500,
    p_normal_sd = 20,
    p_gamma_shape = 2,
    p_gamma_rate = 1,
    mspline_degree = 3,
    mspline_bsmooth = TRUE,
    mspline_df = 8,
    maxT = 5.5,
    seed = 161)

print(res)
