# example of using rslurm to parallelise.

library(tidyverse)
library(survextrap)
library(rslurm)

# specify jobname and path where results are to be stored.

jobname <- "sim_test1"
path_to_results <- "test_results"


# import trial data and call scripts to create functions.
 
control <- cetux[cetux$treat=="Control",]

source("functions/sim_all.R")
source("functions/specify_dgm.R")
source("functions/simulate_dgm.R")
source("functions/fit_model.R")
source("functions/estimands.R")
source("functions/visualise.R")

setwd(path_to_results)


# set of parameters for simulation scenarios.

pars <- expand_grid(k_true = 3,
                    k_true_cens = 4,
                    N = c(seq(from = 200, to = 2000, length.out = 20),
                          seq(from = 2000, to = 10000, length.out = 10)), # vary sample size
                    p_normal_sd = 20,
                    p_gamma_shape = 2,
                    p_gamma_rate = 1,
                    mspline_degree = 3,
                    mspline_bsmooth = TRUE,
                    mspline_df = c(5:13), # vary number of knots
                    maxT = 5.5,
                    seed = 1:5 ) # replicate scenario over distinct seeds 

# submit slurm job, specifying nodes, cpus, memory

sjob <- slurm_apply(sim_all, pars, jobname = jobname,
                    nodes = 20, cpus_per_node = 4, submit = TRUE,
                    global_objects = c("control", "dgm", "simulate_dgm", "fit_model", "estimands"),
                    pkgs = c("dplyr", "tidyr", "ggplot2", "readr",
                             "flexsurv", "survextrap"),
                    slurm_options = list(time='23:00:00',
                                         partition='core',
                                         "mem-per-cpu"= '16G'))

# import results from slurm after completion

res <- get_slurm_out(sjob, outtype = 'table', wait = FALSE)
names(res) <- "rmst_diff"
res <- cbind(pars, res)
res <- as_tibble(res)
res <- res %>%  mutate(rmst_diff2 = (rmst_diff)^2)
res$mspline_df <- as.factor(res$mspline_df)

# check results

summary(as.factor(res$seed))
summary(as.factor(res$mspline_df))
summary(as.factor(res$N))

# evaluate mean bias2 of rmst, averaged across replications (seeds)

figure <- res %>%
  group_by(k_true,
           k_true_cens,
           N,
           p_normal_sd,
           p_gamma_shape,
           p_gamma_rate,
           mspline_degree,
           mspline_bsmooth,
           mspline_df, # vary number of knots
           maxT) %>%
  summarise(mean_bias2 = mean(rmst_diff2)) %>%
  ungroup() 


# plot results by df of spline

ggplot(data=figure, aes(x=N, y = mean_bias2, colour = mspline_df))+
  geom_line()+
  theme_classic()+
  xlab("N")+
  ylab("RMST bias2")+
  labs(colour= "M-spline df")
  




