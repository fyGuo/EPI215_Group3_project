library(MASS)
library(tidyverse)
dta<- read_csv("MI_clean_data1.csv")
mod_org <- glm(DIFFHEAR ~1, 
               family = "binomial",
               data = dta)
mod_final <- glm(DIFFHEAR ~., 
                 family = "binomial",
                 data = dta)
mod_step <- stepAIC(mod_org, mod_final)

library(glmnet)
library(fastDummies)
dta_n <- dummy_cols(dta)

class <- sapply(dta_n, function(x){
  class(x)
})

dta_n <- dta_n[,class != "character"]
class <- sapply(dta_n, function(x){
  class(x)
})
class
dta_n <- dta_n %>%
  dplyr::select(-id) 
x <-dta_n %>% dplyr::select(-DIFFHEAR, -DIVINYR , -WIDINYR) %>% as.matrix()

y <- dta_n$DIFFHEAR %>% as.matrix()

cv_model <- cv.glmnet(x, 
                      y, 
                      family = "binomial",
                      alpha = 1)
# I set the lambda to be the lambda within 1 se from the lowest AIC
lambda <- cv_model$lambda.1se
cv_model
plot(cv_model)
glmnet(x,y,
       family = "binomial",
       alpha = 1,
       lambda = lambda) %>% coef()

