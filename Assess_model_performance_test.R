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
                        "", "", "", "",""))
  
  imp_df <- complete(mi, action = "long")
  
  # convert the CLASSWKR back to a factor
  imp_df$CLASSWKR <- if_else(imp_df$CLASSWKR==0, "Self-employed", "Works for wages")
  
  
  if (method == "lasso") {
    logit <-  1.363527e+01 + 5.332333e-02*imp_df$AGE  -9.844508e-03*imp_df$BIRTHYR  +
      -2.885644e-01*(imp_df$SEX=="female") +
      1.700971e-05*(imp_df$SEX =="male") + 6.480554e-02* (imp_df$RACE == "Otherse") + 
      7.366961e-03*(imp_df$EDUC == "Less than high school")+
      2.106638e-03*(imp_df$WORKEDYR == "No") + 
      -2.180949e-018*(imp_df$VETSTAT == "Not a veteran") + 7.611356e-05*(imp_df$VETSTAT == "Veteran")+
      -2.785161e-02 *(imp_df$WORK_STATUS == "Employed")
  } else if (method == "step") {
    logit <- -8.91351115 + 7.337873e-02 *imp_df$AGE + 
      7.178938e-01 *(imp_df$SEX =="male")  -1.060457e-01 *(imp_df$RACE == "Black") + 
      9.501539e-01* (imp_df$RACE == "Otherse") +2.668397e-01*(imp_df$RACE == "white")+
      4.606095e-01 *(imp_df$WORK_STATUS == "Not in labor force ")+ 1.008491e+00 *(imp_df$WORK_STATUS == "Unmployed")+
      3.716458e-01*(imp_df$VETSTAT == "Veteran")+
    1.421283e-01*(imp_df$EDUC == "High school") + 3.921671e-01*(imp_df$EDUC == "Less than high school") +
      1.367107e-01*(imp_df$MARST == "Married") + 1.367107e-01*(imp_df$MARST == "Never married")+
      2.126605e-01 *(imp_df$MARST == "Widowed")-1.314068e-06 *imp_df$INCTOT +
      -6.861845e+00 *(imp_df$CLASSWKR == "Works for wages")  
  } else if (method == "subject") {
    logit <-   -0.6574628380  + 0.0098779153 *imp_df$AGE  +
      0.0748649237 *(imp_df$SEX =="male")  -0.0023908350*imp_df$FAMSIZE  
    -0.0059210114 *(imp_df$MARST == "Married") +0.0112374997*(imp_df$MARST == "Never married")+
      0.0206947650*(imp_df$MARST == "Widowed")
    -0.0169537823*(imp_df$RACE == "Black") + 0.1164300154 * (imp_df$RACE == "Otherse") + 
      0.0212319529*(imp_df$RACE == "white")-0.0036402812*imp_df$HISPAN+
      0.0158122397*(imp_df$EDUC == "High school") +0.0572512745 *(imp_df$EDUC == "Less than high school") 
      -0.0290864272*imp_df$HCOVANY  
      -0.0027835971  *(imp_df$CLASSWKR == "Works for wages") +
      0.0360499579   *(imp_df$WORK_STATUS == "Not in labor force ")+   0.1112976046  *(imp_df$WORK_STATUS == "Unmployed")
      0.0157405111  *(imp_df$WORKEDYR == "No, but worked 1-5 yrs age") + 0.0160801326 * (imp_df$WORKEDYR == "Yes")
      -0.0005833883 *imp_df$UHRSWORK +
        0.0603925692  *(imp_df$VETSTAT == "Veteran")
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
step <- furrr::future_map_dfc(rep("step", 100),
                               fun_pred,
                               .progress = TRUE,
                               .options = furrr::future_options(seed = 123))
toc()
step_p <- rowMeans(step, na.rm = T)
mean((step_p - dta$DIFFHEAR)^2, na.rm = T)


# thrid test subject
tic()
# impute the testing dataset 1000 times to evaluate the performance of model 
# more precisely.
subject <- furrr::future_map_dfc(rep("subject", 100),
                              fun_pred,
                              .progress = TRUE,
                              .options = furrr::future_options(seed = 123))
toc()
subject_p <- rowMeans(subject, na.rm = T)
mean((subject_p - dta$DIFFHEAR)^2, na.rm = T)


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

pROC_sub <- roc(dta$DIFFHEAR,
                 subject_p,
                 smoothed = TRUE,
                 # arguments for ci
                 ci=TRUE, ci.alpha=0.9, stratified=FALSE,
                 # arguments for plot
                 plot=TRUE, auc.polygon=TRUE, max.auc.polygon=TRUE, grid=TRUE,
                 print.auc=TRUE, show.thres=TRUE)

pROC_lasso
pROC_step
pROC_sub

#######################
# make a large data.frame

df <- data.frame(sep = c(pROC_lasso$specificities, pROC_step$specificities,pROC_sub$specificities),
       sens = c(pROC_lasso$sensitivities, pROC_step$sensitivities,pROC_sub$sensitivities),
       mod = c(rep("LASSO, AUC = 0.699", length(pROC_lasso$specificities)),
               rep("StepwiseAIC, AUC = 0.688", length(pROC_step$specificities)),
               rep("Subject knowledge, AUC = 0.711", length(pROC_sub$specificities))))

ggplot(df) + 
  geom_line(aes(x = 1-sep, y = sens, color = as.factor(mod))) + 
  theme_bw() + 
  theme(legend.title =  element_blank(),
        legend.position = "bottom")+
  labs(x = "1-Specificity",
       y = "Sensitivity")
ggsave("ROC.png",
       dpi = 300,
       width = 20,
       height = 20,
       units = "cm")


df_new <- data.frame(probability = c(lasso_p, step_p, subject_p),
                 mod = c(rep("LASSO, AUC = 0.704", length(lasso_p)),
                         rep("StepwiseAIC, AUC = 0.505", length(step_p)),
                         rep("Subject knowledge, AUC = 0.707", length(subject_p))))

ggplot(df_new) + 
  geom_density(aes(x = probability,  fill = as.factor(mod))) + 
  facet_grid(mod~.)+
  geom_vline(aes(xintercept = mean(dta$DIFFHEAR) ), color = "red", linetype = "dotted")+
  theme_bw() + 
  theme(legend.title =  element_blank(),
        legend.position = "bottom")+
  labs(x = "Predicted probability")
ggsave("histogram.png",
       dpi = 300,
       width = 20,
       height = 20,
       units = "cm")

