/*
NOTE:  This is just the proc format step which will set up the formats associated with the project data

My advice would be to save this to you folder and just call it in as first line in you program like this
%include ".../..directory../format project data.sas";
*/


proc format;

value FAMSIZE_f
  01 = "1 family member present"
  02 = "2 family members present"
  03 = "3"
  04 = "4"
  05 = "5"
  06 = "6"
  07 = "7"
  08 = "8"
  09 = "9"
  10 = "10"
  11 = "11"
  12 = "12"
  13 = "13"
  14 = "14"
  15 = "15"
  16 = "16"
  17 = "17"
  18 = "18"
  19 = "19"
  20 = "20"
  21 = "21"
  22 = "22"
  23 = "23"
  24 = "24"
  25 = "25"
  26 = "26"
  27 = "27"
  28 = "28"
  29 = "29"
;

value ELDCH_f
  00 = "Less than 1 year old"
  01 = "1"
  02 = "2"
  03 = "3"
  04 = "4"
  05 = "5"
  06 = "6"
  07 = "7"
  08 = "8"
  09 = "9"
  10 = "10"
  11 = "11"
  12 = "12"
  13 = "13"
  14 = "14"
  15 = "15"
  16 = "16"
  17 = "17"
  18 = "18"
  19 = "19"
  20 = "20"
  21 = "21"
  22 = "22"
  23 = "23"
  24 = "24"
  25 = "25"
  26 = "26"
  27 = "27"
  28 = "28"
  29 = "29"
  30 = "30"
  31 = "31"
  32 = "32"
  33 = "33"
  34 = "34"
  35 = "35"
  36 = "36"
  37 = "37"
  38 = "38"
  39 = "39"
  40 = "40"
  41 = "41"
  42 = "42"
  43 = "43"
  44 = "44"
  45 = "45"
  46 = "46"
  47 = "47"
  48 = "48"
  49 = "49"
  50 = "50"
  51 = "51"
  52 = "52"
  53 = "53"
  54 = "54"
  55 = "55"
  56 = "56"
  57 = "57"
  58 = "58"
  59 = "59"
  60 = "60"
  61 = "61"
  62 = "62"
  63 = "63"
  64 = "64"
  65 = "65"
  66 = "66"
  67 = "67"
  68 = "68"
  69 = "69"
  70 = "70"
  71 = "71"
  72 = "72"
  73 = "73"
  74 = "74"
  75 = "75"
  76 = "76"
  77 = "77"
  78 = "78"
  79 = "79"
  80 = "80"
  81 = "81"
  82 = "82"
  83 = "83"
  84 = "84"
  85 = "85"
  86 = "86"
  87 = "87"
  88 = "88"
  89 = "89"
  90 = "90"
  91 = "91"
  92 = "92"
  93 = "93"
  94 = "94"
  95 = "95"
  96 = "96"
  97 = "97"
  98 = "98"
  99 = "N/A"
;

;

value SEX_f
  1 = "Male"
  2 = "Female"
;


value MARST_f
  1 = "Married, spouse present"
  2 = "Married, spouse absent"
  3 = "Separated"
  4 = "Divorced"
  5 = "Widowed"
  6 = "Never married/single"
;

value MARRNO_f
  0 = "Not Applicable"
  1 = "Married once"
  2 = "Married twice (or more)"
  3 = "Married thrice (or more)"
  4 = "Four times"
  5 = "Five times"
  6 = "Six times"
  7 = "Unknown"
  8 = "Illegible"
  9 = "Missing"
;

value MARRINYR_f
  0 = "N/A"
  1 = "Blank (No)"
  2 = "Yes"
;

value DIVINYR_f
  0 = "N/A"
  1 = "Blank (No)"
  2 = "Yes"
;

value WIDINYR_f
  0 = "N/A"
  1 = "Blank (No)"
  2 = "Yes"
;

value FERTYR_f
  0 = "N/A"
  1 = "No"
  2 = "Yes"
  8 = "Suppressed"
;

value RACE_f
  1 = "White"
  2 = "Black/African American/Negro"
  3 = "American Indian or Alaska Native"
  4 = "Chinese"
  5 = "Japanese"
  6 = "Other Asian or Pacific Islander"
  7 = "Other race, nec"
  8 = "Two major races"
  9 = "Three or more major races"
;

value HISPAN_f
  0 = "Not Hispanic"
  1 = "Mexican"
  2 = "Puerto Rican"
  3 = "Cuban"
  4 = "Other"
  9 = "Not Reported"
;


value SPEAKENG_f
  0 = "N/A (Blank)"
  1 = "Does not speak English"
  2 = "Yes, speaks English..."
  3 = "Yes, speaks only English"
  4 = "Yes, speaks very well"
  5 = "Yes, speaks well"
  6 = "Yes, but not well"
  7 = "Unknown"
  8 = "Illegible"
;



value RACNUM_f
  1 = "1 race group"
  2 = "2 race groups"
  3 = "3 race groups"
  4 = "4 race groups"
  5 = "5 race groups"
  6 = "6 race groups"
;

value HCOVANY_f
  1 = "No health insurance coverage"
  2 = "With health insurance coverage"
;

value HCOVPRIV_f
  1 = "Without private health insurance coverage"
  2 = "With private health insurance coverage"
;

value HINSEMP_f
  1 = "No insurance through employer/union"
  2 = "Has insurance through employer/union"
;

value HINSPUR_f
  1 = "No insurance purchased directly"
  2 = "Has insurance purchased directly"
;

value HCOVPUB_f
  1 = "Without public health insurance coverage"
  2 = "With public health insurance coverage"
;

value HINSCAID_f
  1 = "No insurance through Medicaid"
  2 = "Has insurance through Medicaid"
;

value HINSCARE_f
  1 = "No"
  2 = "Yes"
;

value HINSVA_f
  1 = "No insurance through VA"
  2 = "Has insurance through VA"
;

value HINSIHS_f
  1 = "No insurance through Indian Health Service"
  2 = "Has insurance through Indian Health Service"
;


value EDUC_f
  00 = "N/A or no schooling"
  01 = "Nursery school to grade 4"
  02 = "Grade 5, 6, 7, or 8"
  03 = "Grade 9"
  04 = "Grade 10"
  05 = "Grade 11"
  06 = "Grade 12"
  07 = "1 year of college"
  08 = "2 years of college"
  09 = "3 years of college"
  10 = "4 years of college"
  11 = "5+ years of college"
;


value SCHLTYPE_f
  0 = "N/A"
  1 = "Not enrolled"
  2 = "Public school"
  3 = "Private school (1960,1990-2000,ACS,PRCS)"
  4 = "Church-related (1980)"
  5 = "Parochial (1970)"
  6 = "Other private, 1980"
  7 = "Other private, 1970"
;

value EMPSTAT_f
  0 = "N/A"
  1 = "Employed"
  2 = "Unemployed"
  3 = "Not in labor force"
;

value LABFORCE_f
  0 = "N/A"
  1 = "No, not in the labor force"
  2 = "Yes, in the labor force"
;

value CLASSWKR_f
  0 = "N/A"
  1 = "Self-employed"
  2 = "Works for wages"
;

value WKSWORK2_f
  0 = "N/A"
  1 = "1-13 weeks"
  2 = "14-26 weeks"
  3 = "27-39 weeks"
  4 = "40-47 weeks"
  5 = "48-49 weeks"
  6 = "50-52 weeks"
;

value WRKLSTWK_f
  0 = "N/A"
  1 = "Did not work"
  2 = "Worked"
  3 = "Not Reported"
;

value ABSENT_f
  0 = "N/A"
  1 = "No"
  2 = "Yes, laid off"
  3 = "Yes, other reason (vacation, illness, labor dispute, etc.)"
  4 = "Not reported"
;

value LOOKING_f
  0 = "N/A"
  1 = "No, did not look for work"
  2 = "Yes, looked for work"
  3 = "Not reported"
;

value AVAILBLE_f
  0 = "N/A"
  1 = "No, already has job"
  2 = "No, temporarily ill"
  3 = "No, other reason(s)"
  4 = "Yes, available for work"
  5 = "Not reported"
;
;

value VETDISAB_f
  0 = "N/A"
  1 = "No disability rating"
  2 = "0 percent disability rating"
  3 = "10 or 20 percent disability rating"
  4 = "30 or 40 percent"
  5 = "50 or 60 percent"
  6 = "70 percent or higher"
  9 = "Has disability rating, level not reported"
;


value DIFFHEAR_f
  0 = "N/A"
  1 = "No"
  2 = "Yes"
;

value VETSTAT_f
  0 = "N/A"
  1 = "Not a veteran"
  2 = "Veteran"
  9 = "Unknown"
;

value VETSTATD_f
  00 = "N/A"
  10 = "Not a veteran"
  11 = "   No military service"
  12 = "   Currently on active duty"
  13 = "   Training for Reserves or National Guard only"
  20 = "Veteran"
  21 = "   Veteran, on active duty prior to past year"
  22 = "   Veteran, on active duty in past year"
  23 = "   Veteran, on active duty in Reserves or National Guard only"
  99 = "Unknown"
;

value VET01LTR_f
  0 = "N/A"
  1 = "Did not serve this period"
  2 = "Served this period"
;

value VET90X01_f
  0 = "N/A"
  1 = "Did not serve this period"
  2 = "Served this period"
;

value VET75X90_f
  0 = "N/A or No"
  1 = "No"
  2 = "Yes, served this period"
;

value VETVIETN_f
  0 = "N/A (all years) and No)"
  1 = "No"
  2 = "Yes, Vietnam-era veteran"
;

value VET55X64_f
  0 = "N/A or No"
  1 = "No"
  2 = "Yes, served this period"
;

value VETKOREA_f
  0 = "N/A or No"
  1 = "No"
  2 = "Yes, served this period"
;

value VET47X50_f
  0 = "N/A"
  1 = "Did not serve this period"
  2 = "Served this period"
;

value VETWWII_f
  0 = "N/A; N/A or No (1980, 1990 US)"
  1 = "No"
  2 = "Yes, served this period"
;

value VETOTHER_f
  0 = "N/A (all years) or No "
  1 = "No "
  2 = "Yes, served this period(s)"
;

value TRANWORK_f
  00 = "N/A "
  10 = "Auto, truck, or van"
  11 = "Auto"
  12 = "Driver"
  13 = "Passenger"
  14 = "Truck"
  15 = "Van"
  20 = "Motorcycle"
  30 = "Bus or streetcar"
  31 = "Bus or trolley bus"
  32 = "Streetcar or trolley car"
  33 = "Subway or elevated"
  34 = "Railroad"
  35 = "Taxicab"
  36 = "Ferryboat"
  40 = "Bicycle"
  50 = "Walked only"
  60 = "Other"
  70 = "Worked at home"
;

value CARPOOL_f
  0 = "N/A"
  1 = "Drives alone"
  2 = "Carpools"
  3 = "Shares driving"
  4 = "Drives others only"
  5 = "Passenger only"
;

value RIDERS_f
  0 = "N/A"
  1 = "Drives alone"
  2 = "2 people"
  3 = "3"
  4 = "4"
  5 = "5"
  6 = "6"
  7 = "7+ (1980,2000)"
  8 = "7-9 (1990,ACS,PRCS)"
  9 = "10 or more (1990,ACS,PRCS)"
;

value GCHOUSE_f
  0 = "N/A"
  1 = "No"
  2 = "Yes"
;

value GCMONTHS_f
  0 = "N/A"
  1 = "Less than 6 months"
  2 = "6 to 11 months"
  3 = "1 to 2 years"
  4 = "3 to 4 years"
  5 = "5 or more years"
;

value GCRESPON_f
  0 = "N/A"
  1 = "No"
  2 = "Yes"
;

value AGE_f
  000 = "Less than 1 year old"
  001 = "1"
  002 = "2"
  003 = "3"
  004 = "4"
  005 = "5"
  006 = "6"
  007 = "7"
  008 = "8"
  009 = "9"
  010 = "10"
  011 = "11"
  012 = "12"
  013 = "13"
  014 = "14"
  015 = "15"
  016 = "16"
  017 = "17"
  018 = "18"
  019 = "19"
  020 = "20"
  021 = "21"
  022 = "22"
  023 = "23"
  024 = "24"
  025 = "25"
  026 = "26"
  027 = "27"
  028 = "28"
  029 = "29"
  030 = "30"
  031 = "31"
  032 = "32"
  033 = "33"
  034 = "34"
  035 = "35"
  036 = "36"
  037 = "37"
  038 = "38"
  039 = "39"
  040 = "40"
  041 = "41"
  042 = "42"
  043 = "43"
  044 = "44"
  045 = "45"
  046 = "46"
  047 = "47"
  048 = "48"
  049 = "49"
  050 = "50"
  051 = "51"
  052 = "52"
  053 = "53"
  054 = "54"
  055 = "55"
  056 = "56"
  057 = "57"
  058 = "58"
  059 = "59"
  060 = "60"
  061 = "61"
  062 = "62"
  063 = "63"
  064 = "64"
  065 = "65"
  066 = "66"
  067 = "67"
  068 = "68"
  069 = "69"
  070 = "70"
  071 = "71"
  072 = "72"
  073 = "73"
  074 = "74"
  075 = "75"
  076 = "76"
  077 = "77"
  078 = "78"
  079 = "79"
  080 = "80"
  081 = "81"
  082 = "82"
  083 = "83"
  084 = "84"
  085 = "85"
  086 = "86"
  087 = "87"
  088 = "88"
  089 = "89"
  090 = "90 (90+ in 1980 and 1990)"
  091 = "91"
  092 = "92"
  093 = "93"
  094 = "94"
  095 = "95"
  096 = "96"
  097 = "97"
  098 = "98"
  099 = "99"
  100 = "100 (100+ in 1960-1970)"
  101 = "101"
  102 = "102"
  103 = "103"
  104 = "104"
  105 = "105"
  106 = "106"
  107 = "107"
  108 = "108"
  109 = "109"
  110 = "110"
  111 = "111"
  112 = "112 (112+ in the 1980 internal data)"
  113 = "113"
  114 = "114"
  115 = "115 (115+ in the 1990 internal data)"
  116 = "116"
  117 = "117"
  118 = "118"
  119 = "119"
  120 = "120"
  121 = "121"
  122 = "122"
  123 = "123"
  124 = "124"
  125 = "125"
  126 = "126"
  129 = "129"
  130 = "130"
  135 = "135"
;
value UHRSWORK_f
  00 = "N/A"
  01 = "1"
  02 = "2"
  03 = "3"
  04 = "4"
  05 = "5"
  06 = "6"
  07 = "7"
  08 = "8"
  09 = "9"
  10 = "10"
  11 = "11"
  12 = "12"
  13 = "13"
  14 = "14"
  15 = "15"
  16 = "16"
  17 = "17"
  18 = "18"
  19 = "19"
  20 = "20"
  21 = "21"
  22 = "22"
  23 = "23"
  24 = "24"
  25 = "25"
  26 = "26"
  27 = "27"
  28 = "28"
  29 = "29"
  30 = "30"
  31 = "31"
  32 = "32"
  33 = "33"
  34 = "34"
  35 = "35"
  36 = "36"
  37 = "37"
  38 = "38"
  39 = "39"
  40 = "40"
  41 = "41"
  42 = "42"
  43 = "43"
  44 = "44"
  45 = "45"
  46 = "46"
  47 = "47"
  48 = "48"
  49 = "49"
  50 = "50"
  51 = "51"
  52 = "52"
  53 = "53"
  54 = "54"
  55 = "55"
  56 = "56"
  57 = "57"
  58 = "58"
  59 = "59"
  60 = "60"
  61 = "61"
  62 = "62"
  63 = "63"
  64 = "64"
  65 = "65"
  66 = "66"
  67 = "67"
  68 = "68"
  69 = "69"
  70 = "70"
  71 = "71"
  72 = "72"
  73 = "73"
  74 = "74"
  75 = "75"
  76 = "76"
  77 = "77"
  78 = "78"
  79 = "79"
  80 = "80"
  81 = "81"
  82 = "82"
  83 = "83"
  84 = "84"
  85 = "85"
  86 = "86"
  87 = "87"
  88 = "88"
  89 = "89"
  90 = "90"
  91 = "91"
  92 = "92"
  93 = "93"
  94 = "94"
  95 = "95"
  96 = "96"
  97 = "97"
  98 = "98"
  99 = "99 (Topcode)"
;

value WORKEDYR_f
  0 = "N/A"
  1 = "No"
  2 = "No, but worked 1-5 years ago (ACS only)"
  3 = "Yes"
;
run;
