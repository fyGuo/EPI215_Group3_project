## ------------------------------------------------------------------------------------------------
#Load libraries and data
library(MASS)
library(tidyverse)
library(glmnet)
library(fastDummies)
library(gamlr)
library(pROC)

# write a function to do stepwise model
fun_sub <- function(data_name){
  dta <- read_csv(data_name)
  mod <- lm(DIFFHEAR ~ AGE + I(SEX == "male") + FAMSIZE + MARST + RACE + 
              HISPAN + EDUC + HCOVANY + CLASSWKR + WORK_STATUS + 
              WORKEDYR + UHRSWORK + VETSTAT, 
            data = dta) 
  return(mod)
}

library(furrr)
plan("multicore")
step <- furrr::future_map(paste("MI_clean_data", 1:10, ".csv", sep = ""),
                          fun_sub)

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
saveRDS(beta, "pooled_sub.rds")

