## ------------------------------------------------------------------------------------------------
#Load libraries and data
library(MASS)
library(tidyverse)
library(glmnet)
library(fastDummies)
library(gamlr)
library(pROC)

# write a function to do stepwise model
fun_step <- function(data_name){
  dta <- read_csv(data_name)
  dta <- dta %>% dplyr::select(-DEPARTS, -ARRIVES, -DIVINYR , -WIDINYR)
  mod_org <- glm(DIFFHEAR ~1, 
                 family = "binomial",
                 data = dta)
  mod_final <- glm(DIFFHEAR ~., 
                   family = "binomial",
                   data = dta)
  
  mod_step <- stepAIC(mod_org, scope=formula(mod_final), direction = "forward")
}

library(furrr)
plan("multicore")
step <- furrr::future_map(paste("MI_clean_data", 1:10, ".csv", sep = ""),
                           fun_step)

mat <- cbind(coef(step[[1]]),
      coef(step[[2]]),
      coef(step[[3]]),
      coef(step[[4]]),
      coef(step[[5]]),
      coef(step[[6]]), 
      coef(step[[7]]),
      coef(step[[8]]),
      coef(step[[9]]),
      coef(step[[10]]))
beta <- mat %>% rowMeans()
names(beta) <- rownames(mat)
saveRDS(beta, "pooled_stepwise.rds")

