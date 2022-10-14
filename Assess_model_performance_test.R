library(tidyverse)
library(mice)

dta <- read_rds("clean_data_test.rds")

fun_pred <- function(method){

  dta$id <- 1:dim(dta)[1]
  dta <- dta %>% dplyr::select(-dataset)
  # this R script is to do multiple imputation to impute the missing WRKCLASS
  
  # we first exclude DIVINYR and WIDINYR which are not needed to be imputed.
  df <- dta %>% dplyr::select(-DIVINYR, -WIDINYR)
  sapply(df, function (x){
    is.na(x) %>% sum()
  })
  
  
  # convert CLASSWKR to a conditnuous variable to do imputation
  df$CLASSWKR <- if_else(df$CLASSWKR == "Self-employed", 0, 1)
  
  # I use a random-forest method to do imputations because I don't want to 
  # make any parametric assumptions in the imputation model
  mi <- mice(df, 
             m= 1,
             method = c("", "", "", "", "", "", "", "", "", "",
                        "rf", "", "", "", "", "", "", "", "", "",
                        "", "", "", "", "",""))
  
  imp_df <- complete(mi, action = "long")
  
  # convert the CLASSWKR back to a factor
  imp_df$CLASSWKR <- if_else(imp_df$CLASSWKR==0, "Self-employed", "Works for wages")
  
  
  if (method == "lasso") {
    logit <- 11.33081 + 5.591395e-02 *imp_df$AGE  -9.019127e-03 *imp_df$BIRTHYR + 2.274707e-01 *df$VETDISAB +
      1.700971e-05*(imp_df$SEX =="male") + 4.435602e-02* (imp_df$RACE == "Otherse") + 
      1.541819e-02*(imp_df$EDUC == "Less than high school") -1.965099e-03*(imp_df$WORK_STATUS == "Employed")
  } else if (method == "step") {
    logit <- -8.91351115 + 0.07972189 *imp_df$AGE + 0.33867899 *df$VETDISAB +
       0.68499614*(imp_df$SEX =="male")  -0.18544912*(imp_df$RACE == "Black") + 
      0.90315990* (imp_df$RACE == "Otherse") + 0.24807138*(imp_df$RACE == "white")+
      0.13501277*(imp_df$EDUC == "High school") + 0.41034996*(imp_df$EDUC == "Less than high school") +
      0.37274675*(imp_df$WORK_STATUS == "Not in labor force ")+ 0.88153670*(imp_df$WORK_STATUS == "Unmployed")+
      + 0.88153670*(imp_df$CLASSWKR == "Works for wages")  +
      0.17922818*(imp_df$MARST == "Married") + 0.23159559*(imp_df$MARST == "Never married")+
      0.02369239*(imp_df$MARST == "Widowed") -0.16143992*imp_df$INCTOT -
      7.19494778*(imp_df$VETSTAT == "Veteran")
  }
  
  p <- exp(logit)/(1+exp(logit))
  data.frame(p = p) %>% return()  
  }


# do the parallel

# first test lasso
library(furrr)
plan("multicore")
library(tictoc)
tic()
# actually we don't need to impute lasso because it doesn't include CLASSWRK
# thus use 10 is fine
lasso <- furrr::future_map_dfc(rep("lasso", 10),
                           fun_pred,
                           .progress = TRUE,
                           .options = furrr::future_options(seed = 123))
toc()

lasso_p <- rowMeans(lasso)
mean((lasso_p - dta$DIFFHEAR)^2)


# second test stepwise
tic()
# impute the testing dataset 1000 times to evaluate the performance of model 
# more precisely.
step <- furrr::future_map_dfc(rep("step", 1000),
                               fun_pred,
                               .progress = TRUE,
                               .options = furrr::future_options(seed = 123))
toc()
step_p <- rowMeans(step, na.rm = T)
mean((step_p - dta$DIFFHEAR)^2, na.rm = T)



#######################
# draw ROC curves
library(pROC)


par(mfrow = c(2,1))
pROC_lasso <- roc(dta$DIFFHEAR,
                  lasso_p,
                smoothed = TRUE,
                # arguments for ci
                ci=TRUE, ci.alpha=0.9, stratified=FALSE,
                # arguments for plot
                plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
                print.auc=TRUE, show.thres=TRUE)

pROC_step <- roc(dta$DIFFHEAR,
                  step_p,
                  smoothed = TRUE,
                  # arguments for ci
                  ci=TRUE, ci.alpha=0.9, stratified=FALSE,
                  # arguments for plot
                  plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
                  print.auc=TRUE, show.thres=TRUE)

