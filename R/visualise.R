# Compare fitted model with true model graphically
#'
#' @param true_mod true model and censoring distribution, returned from dgm
#' @param fit_mod fitted model, returned from fit_model function



vis_mod <- function(true_mod, fit_mod, maxT){
  
  # create data frame with hazard at each time point, for each model.
  
  plot_data <- bind_rows(
                  tibble("time" = true_mod$true_haz$time[-1],
                         "hazard" = true_mod$true_haz$at1[-1],
                          "method" = "true_model"),
                  tibble("time" = fit_mod$fit_haz$t[-1],
                         "hazard" = fit_mod$fit_haz$median[-1],
                         "method" = "fit_model"))
              
  ggplot(
    data = plot_data, aes(x = time, y = hazard)) +
    theme_classic()+
    geom_vline(xintercept = c(0, fit_mod$fit_mod$mspline$knots),
               color = "grey")+
    geom_line(aes(color = method))+
    scale_color_manual(name = NULL, 
                       values = c("black", "#1f78b4" ))



  }


