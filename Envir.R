require.i <- function(pkg, parallel = T){
  # Install missing packages
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if(length(new.pkg)) install.packages(new.pkg, dependencies = TRUE)
  
  # Move tidyverse and dplyr to the back to avoid select being masked
  pos <- which(pkg %in% c("tidyverse", "dplyr"))
  if(length(pos) > 0) pkg <- c(pkg[-pos], pkg[pos]) 
  
  # Move rstan to the back to avoid extract being masked
  pos <- which(pkg %in% "rstan")
  if(length(pos) > 0) pkg <- c(pkg[-pos], pkg[pos]) 
  
  print(pkg)
  
  # Require packages
  sapply(pkg, require, character.only = TRUE)
  
  # Set options for Rstan
  if("rstan" %in% pkg){
    if(parallel) options(mc.cores = parallel::detectCores())
    rstan_options(auto_write = TRUE)
  }
}

expit <- function(x) exp(x)/(1+exp(x))
logit <- function(x) log(x/(1-x))