library(tidyverse)
library(haven)

#################################
# read in the unformatted data
dta <- read_csv("project_data_noformat.csv")
# determine the number of observations in the training dataset
round(dim(dta)[1]*0.8)
set.seed(123)
train_id<- sample(1:dim(dta)[1], 7038)
dta$dataset <- "test"
dta$dataset[train_id] <- "train"
table(dta$dataset)
#############################
# 1. Family size: continuous variable, we can keep this variable since

dta$FAMSIZE
# 2. ELDCH: age of eldest own child in household, less related to this adult's hearing situation
# thus, less delete this one
dta <- dta %>% dplyr::select(-ELDCH)

# 3.sex_f: sex of the individuals. Keep the original value. Just keep in mind that
# 1= male; 2= female

dta <- dta %>%
  mutate(SEX = if_else(SEX == 1, "male", "female"))

# 4.marst_f: Marital status, just collapse married into one group
dta <- dta %>%
  mutate(MARST = case_when(
    MARST %in% c(1,2,3) ~ "Married",
    MARST == 4 ~ "Divorced",
    MARST == 5 ~ "Widowed",
    MARST == 6 ~ "Never married"
  ))


# 5. marrno_f: time married. This one carries similar information as married.
# I think times married is less related to hearing loss if the marriage status has already been considered.
# just leave out this information
dta <- dta %>% dplyr::select(-MARRNO)

# 6. MARRINYR: married within the last year
# this one is confusing and is less useful than marriage status, so delete it.
dta <- dta %>% dplyr::select(-MARRINYR)

#7. DIVINYR: divored in the last year, change the coding method to make NA exmplicit
# NA: missing, 0: No, 1:Yes
dta$DIVINYR[dta$DIVINYR==0] <- NA
dta$DIVINYR <- dta$DIVINYR -1 

#8. WIDINYR_f: widowed in the last year. Same idea as divorced
dta$WIDINYR[dta$WIDINYR==0] <- NA
dta$WIDINYR <- dta$WIDINYR-1

#9. FERTYR_f: didn't find the definition. 

#10, Race: I would creat white, black, Asian, or others
dta <- dta %>%
  mutate(RACE = case_when(
    RACE == 1 ~ "white",
    RACE == 2 ~ "Black",
    RACE %in% c(4,5,6) ~"Asian",
    RACE %in% c(3, 7, 8, 9) ~ "Otherse"
  ))

# 11. HISPAN: collapse to year vs. no
# to make it easier, if the person doesn't report his/her hispanic, we treat it as no
dta <- dta %>%
  mutate(HISPAN = if_else(HISPAN ==0 , 0 , 1))

# 12. SPEAKENG_f: speak english or not, it covers similar information as race and education
# to make the dataset smaller, I decide to delete it

dta <- dta %>% dplyr::select(-SPEAKENG)

# 13. RACNUM_f: race groups, less useful information given we have race category
# delete it
dta <- dta %>% dplyr::select(-RACNUM)

# 14. HCOVANY: health insurance coverage
# 0 :No, 1:Yes
dta$HCOVANY <- dta$HCOVANY -1 

# 15 HCOVPRIV_f: delete
# 16 HINSEMP_f: delete
# 17 HINSPUR_f: delete
# 18 HCOVPUB_f: delete
# 19 HINSCAID_f: delete
# 20 HINSCARE_f: delte
# 21 HINSVA_f: delete
# 22 HINSIHS_f: delete

dta <- dta %>% dplyr::select(-c(HCOVPRIV, HINSEMP, HINSPUR, HCOVPUB,
                         HINSCAID, HINSCARE, HINSVA, HINSIHS))

# 23 EDUC: I would like to convert it into 
# 1: less than high school
# 2: high school
# 3. college or greater

dta <- dta %>%
  mutate(EDUC = case_when(
    EDUC <= 3 ~ "Less than high school",
    EDUC %in% c(4,5,6) ~ "High school",
    EDUC >= 7 ~ "College or greater"
  ))

# 24.SCHLTYPE_f: school type , less important, just delete

# 25. EMPSTAT: employment status, recoding it to make NA explicit
# 26. LABFORCE: labor force status
# WE just creat a new variable WORK_STATUS
dta$WORK_STATUS <- NA
dta$WORK_STATUS <- ifelse(dta$EMPSTAT==1, "Employed", dta$WORK_STATUS)
dta$WORK_STATUS <- ifelse(dta$EMPSTAT ==2, "Unemployed", dta$WORK_STATUS)
dta$WORK_STATUS <- ifelse(dta$EMPSTAT == 3|dta$LABFORCE==1, "Not in labor force", dta$WORK_STATUS)
dta <- dta %>% dplyr::select(-EMPSTAT,-LABFORCE)

# 27. CLASSWKR:self-employed vs. work for wages. 
dta$CLASSWKR[dta$CLASSWKR == 0 ] <- NA
dta$CLASSWKR <- ifelse(dta$CLASSWKR == 1, "Self-employed","Works for wages")


# 28. WKSWORK2: Weeks worked last year, intervalled. Just convert it to a categorical variable
dta$WKSWORK2[dta$WKSWORK2==0] <- NA
dta <- dta %>%
  mutate(WKSWORK2 = case_when(
    WKSWORK2 == 1 ~ "1-13 weeks",
    WKSWORK2 == 2 ~ "14-26 weeks",
    WKSWORK2 == 3 ~ "27-39 weeks",
    WKSWORK2 == 4 ~ "40-47 weeks",
    WKSWORK2 == 5 ~ "48-49 weeks",
    WKSWORK2 == 6 ~ "50-52 weeks"
  ))

# 29. value WRKLSTWK_f: worked last week ? this one is not of much use and can be sensible to the 
# survey time, so just delete it
dta <- dta %>% dplyr::select(-WRKLSTWK)

# 30. value ABSENT: absent last week. Same reason, just delete it
dta <- dta %>% dplyr::select(-ABSENT)

# 31. Looking : looing for work, less important than work status, delete it
dta <- dta %>% dplyr::select(-LOOKING)

# 32. AVAILBLE: convert the variable as Collen suggested
# 1. avaliable for work or has a work
# 2. Not avaliable for work because of illness
# 3. Not avaliable for work because of other reasons
dta$AVAILBLE[dta$AVAILBLE %in% c(0, 5)] <- NA
dta$AVAILBLE <- ifelse(dta$AVAILBLE %in% c(1,4), "Avaliable for work or has a job", dta$AVAILBLE)
dta$AVAILBLE <- ifelse(dta$AVAILBLE == 2, "Not avaliable because of illness", dta$AVAILBLE)
dta$AVAILBLE <- ifelse(dta$AVAILBLE == 3, "Not avaliable because of oteher reasons", dta$AVAILBLE)


# 33. VETDIASB: not found in the data
# 34. DIFFHEAR: that's our outcome
# 0:NO, 1:yes
dta$DIFFHEAR[dta$DIFFHEAR==0] <- NA
dta$DIFFHEAR <- dta$DIFFHEAR - 1

# 35. VETSTAT: just keep this information for veteran
dta$VETSTAT[dta$VETSTAT %in% c(0, 9)] <- NA
dta$VETSTAT <- ifelse(dta$VETSTAT == 1, "Not a veteran", "Veteran")

# 36. VETSTATD_f
# 37. VET01LTR_f
# 38. VET90X01_f
# 39. VET75X90_f
# 40. VETVIETN_f
# 41. VET55X64_f
# 42. VETKOREA_f
# 43. VET47X50_f
# 44. VETWWII_f
# 45. VETOTHER_f
# delete
dta <- dta %>% dplyr::select(-c(VETSTATD, VET01LTR, VET90X01, VET75X90, VETVIETN,
                         VET55X64, VETKOREA, VET47X50, VETWWII, VETOTHER))

# 46. TRANWOR: not much useful because a lot of 0 (NAs)
table(dta$TRANWORK==0) %>% prop.table()
# you can see about 83.5% are missing
dta <- dta %>% dplyr::select(-TRANWORK)

# 46. Carpool: convert it
dta$CARPOOL[dta$CARPOOL==0] <- NA
dta$CARPOOL <- if_else(dta$CARPOOL==1, "Drives alone", "Carpools")

# 47. RIDERS: we already have the carpool variable, which makes this variable less useful
dta <- dta %>% dplyr::select(-RIDERS)

# 48. GCHHOUSE: Own grandchildren living in household
dta$GCHOUSE[dta$GCHOUSE==0] <- NA
dta$GCHOUSE <- dta$GCHOUSE-1

# 49. GCMONTHS: less useful compared to GXRESPON
dta <- dta %>% dplyr::select(-GCMONTHS)

# 50. GCRESPON
dta$GCRESPON[dta$GCRESPON == 0] <- NA
dta$GCRESPON <- dta$GCRESPON - 1

#51. AGE: keep the original continuous variable

# 52. UHRSWORK: keep the original continuous variable
# if work hour is 0, we treat it as 0 instead of missing

# 53. WORKEDYR_f: worked last year
dta$WORKEDYR[dta$WORKEDYR==0] <- NA
dta <- dta %>% mutate(WORKEDYR = case_when(
  WORKEDYR == 1 ~ "No",
  WORKEDYR ==2 ~ "No, but worked 1-5 yrs age",
  WORKEDYR == 3 ~"Yes"
))
View(dta)

# 54. YRMARR: year of married, not much useful but keep it here
# we can calculate the age of married

# 55. TRANTIME: time of transportaton, keep original value
dta$TRANTIME[dta$TRANTIME==0]<- NA


## 56. Arrive and departs
dta$ARRIVES[dta$ARRIVES == 0] <- NA
dta$ARRIVES[dta$ARRIVES <= 1200] <- "AM"
dta$ARRIVES[dta$ARRIVES > 1200] <- "PM"

dta$DEPARTS[dta$DEPARTS == 0] <- NA
dta$DEPARTS[dta$DEPARTS <= 1200] <- "AM"
dta$DEPARTS[dta$DEPARTS > 1200] <- "PM"


## 57. VETDISAB VA service-connected disability rating
dta$VETDISAB[dta$VETDISAB == 0] <- NA

dta$VETDISAB <-if_else(dta$VETDISAB== 1, 0, 1)
#############################
###########################
# check the missingness situation

sapply(dta, function(x){
  sum(is.na(x))/length(x) %>% sum
})

# the missingness proportion for most variables are 0,
# the DIVINYR and WIDINYR are missing because some people are never married
# other missing values are over 50%.
# I would like to try to impute classwkr, but delete other variables which is not of much use

dta <- dta %>% dplyr::select(-AVAILBLE, -CARPOOL,-TRANTIME,-GCRESPON,-WKSWORK2, -VETDISAB)
saveRDS(dta, "clean_data_whole.rds")

dta_train <- dta %>% dplyr::filter(dataset == "train")
saveRDS(dta_train, "clean_data_train.rds")



dta_test <- dta %>% dplyr::filter(dataset == "test")
saveRDS(dta_test, "clean_data_test.rds")
write_csv(dta_test, "clean_data_test.csv")
