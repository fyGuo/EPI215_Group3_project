library(tidyverse)
library(mice)
dta <- read_rds("clean_data_train.rds")
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
set.seed(123)
mi <- mice(df, 
           m= 10,
           method = c("", "", "", "", "", "", "", "", "", "",
                      "rf",  "", "", "", "", "", "", "", "",
                      "", "", "", "","", ""))

imp_df <- complete(mi, action = "long")

# convert the CLASSWKR back to a factor
 imp_df$CLASSWKR <- if_else(imp_df$CLASSWKR==0, "Self-employed", "Works for wages")

# merge DIVINYR and WIDINYR back 
imp_df <- merge(imp_df, dta[,c("id", "DIVINYR", "WIDINYR")])

# cut the ten imputations into 10 csv files
for (i in 1:10) {
  
  tmp <- imp_df %>% filter(`.imp`==i)
  tmp %>% dplyr::select(-".imp", -".id") %>%
    write_csv(file = paste("MI_clean_data", i,".csv", sep = ""))
  
}

