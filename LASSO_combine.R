## -------------------------------------------------------------
#Load libraries and data
library(MASS)
library(tidyverse)
library(glmnet)
library(fastDummies)

# write a function to read in data and do lasso


fun_lasso <- function(data_name){
  dta <- read_csv(data_name)
  dta <- dta %>% dplyr::select(-DEPARTS, -ARRIVES)
  dta_n <- dummy_cols(dta)
  class <- sapply(dta_n, function(x){
    class(x)
  })
  
  dta_n <- dta_n[,class != "character"]
  class <- sapply(dta1_n, function(x){
    class(x)
  })
  #class
  dta_n <- dta_n %>%
    dplyr::select(-id) 
  x <-dta_n %>% dplyr::select(-DIFFHEAR, -DIVINYR , -WIDINYR, -YRMARR) %>% as.matrix()
  
  y <- dta_n$DIFFHEAR %>% as.matrix()
  
  cv_model <- cv.glmnet(x, 
                        y, 
                        family = "binomial",
                        alpha = 1)
  # I set the lambda to be the lambda within 1 se from the lowest AIC
  lambda <- cv_model$lambda.1se
  glmnet(x,y,family = "binomial",
                     alpha = 1,
                     lambda = lambda) %>%
    return()
  
}

library(furrr)
plan("multicore")
lasso <- furrr::future_map(paste("MI_clean_data", 1:10, ".csv", sep = ""),
                  fun_lasso)

mat <- matrix(nrow = 37, ncol = 10)

for (i in 1:10){
  mat[,i] <- coef(lasso[[i]]) %>% as.matrix()

}

beta <- rowMeans(mat)
names(beta) <- coef(lasso[[1]]) %>% rownames()
beta <- beta[beta!=0]



saveRDS(beta, "pooled_beta.rds")
