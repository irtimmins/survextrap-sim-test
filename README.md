# survextrap-sim-test
Test simulation study for survextrap
***********************************
Overview of functions
***********************************
``` specify_dgm ``` specifies a "true" survival function based on real survival data.
True model is of class '"flexsurvreg"'.

``` simulate_dgm ``` simulates from the "true" survival model

``` fit_model ``` fits survextrap model to simulated dataset

``` estimands ``` computes estimands such as rmst from fitted model

``` vis_mod ``` visually compare hazard of fitted model with true model using ggplot2

``` sim_all ``` wraps all functions together


***********************************
Description of examples
***********************************
``` example1.R ``` demonstrates use of each function

``` example2.R ``` demonstrates use of ``` sim_all ``` for a specified scenario

``` slurm_example1.R ``` demonstrates use of slurm_apply to parallelise across multiple scenarios with cluster

***********************************
Results folder
***********************************
``` rmst_bias.pdf ``` ggplot2 displaying results from slurm_example1
