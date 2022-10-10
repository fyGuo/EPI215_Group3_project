library(MASS)
library(tidyverse)
dta <- read_csv("MI_clean_data1.csv")
mod_org <- glm(DIFFHEAR ~1, 
               family = "binomial",
               data = dta_n)
mod_final <- glm(DIFFHEAR ~., 
                 family = "binomial",
                 data = dta_n)
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
  select(-id) 
x <-dta_n %>% select(-DIFFHEAR, -DIVINYR , -WIDINYR) %>% as.matrix()

y <- dta_n$DIFFHEAR %>% as.matrix()

cv_model <- cv.glmnet(x, 
                      y, 
                      family = "binomial",
                      alpha = 1)
cv_model
plot(cv_model)
glmnet(x,y,
       family = "binomial",
       alpha = 1,
       lambda = 0.012295) %>% coef()
