# this R script it to help generate a table 1
library(tableone)
library(tidyverse)
dta <- read_rds("clean_data_whole.rds")

dta$train <- if_else(dta$dataset == "train", 1,0)
# one means the training dataset
# 0 means the test dataset
vars <- colnames(dta %>% dplyr::select( -dataset))

factorVars <- c("SEX", "MARST", "RACE", "EDUC", "WORKEDYR", "WORK_STATUS", "CLASSWKR")
table1 <- CreateTableOne(
  vars = vars,
  factorVars = factorVars,
  strata = c("train"),
  data = dta)
table1

