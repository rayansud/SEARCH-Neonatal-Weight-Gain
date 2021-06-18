clear all
set more off

capture log close
log using logs/cleaning.log, text replace

use data/all_matched_data

*analysis.do - DO FILE TO ANALYZE NEWBORN WEIGHT GAIN

*Created JULY 23, 2010
*Author: Rushina Cholera
*SEARCH, Gadchiroli, India

*Updated MAY 22, 2021
*By: Rayan Sud
*SEARCH, Gadchiroli, India

**********Cleaning: Labelling***********
*TODO: check for impossible values in all variables and set to missing
*e.g. -  grav_m too low


*Label dataset variables

*ID:
label var srno "serial number"
label var villno "home village number"
label var vr_no "CHW village register number"
label var m_resi "Mother resident or outsider"
label var bplace "Birthplace village"
label var placed "Place of delivery"
label var date4 "Date of birth"

*Demographics:
label var sex "neonate sex"
label var m_ht "mother's height"
label var meduct "maternal education"
label var heduct "father's education"
label var moccup "mother's occupation"
label var hoccup "father's occupation"

label var inde "Gestational Age not known"

*Pregnancy info
label var grav_m "completed months of pregnancy"
label var grav_d "completed days of pregnancy"
label var  gravida "gravidity"
label var para "parity"

*Outcomes
label var bwt "neonate weight on day 1 (birth)"
label var nbwt7 "neonate weight on day 7"
label var nbwt15 "neonate weight on day 15"
label var nbwt21 "neonate weight on day 21"
label var wt28 "neonate weight on day 28"

*Other factors
label var mpre "Premature"
label var twin "twins"
label var hrisk1 "high risk on d1"
label var b_feed1 "baby feeding problem on d1"
label var delay "delayed breast feeding problem"
label var feed_m "mom feeding problem"
label var feed_b "baby feeding problem"

*Comorbidities:
label var ba "birth asphyxia"
label var cong "congenital anomaly"
label var aspnm "meconium aspiration"
label var hmd "hyaline membrane disease"
label var umbi "umbilical sepsis"
label var conj "conjunctivitis"
label var unfev "unexplained fever"
label var hemo "hemorrhage"
label var hypo "hypothermia"
label var failu "failure to gain weight"
label var neosep "neonatal sepsis"
label var pnm_ch "pneumonia only"
label var bsi "bacterial skin infxn"
label var jaun "jaundice"
label var boh "bad obstetric history"
label var tobause "mother tobacco use in pregnancy"

label var nbdth "neonatal death"
label var nbdth_d "day of death in neon pd"

label var isfad "CHW present at delivery"
label var ancvisit "ANC visits to mother"
label var nbvisit "CHW visits to baby"



**********Cleaning: Recoding data***********

*Recode missing continuous vars from 0 to "."
recode bwt 0=.
recode nbwt7 0=.
recode nbwt15 0=.
recode nbwt21 0=.
recode wt28 0=.

recode grav_m 0=.
*0 months of pregnancy - must be missing
recode grav_m 2=.
recode grav_m 5=.
*1 observation each for 2 and 5 month - drop

recode gravida (0=.)
*gravidity= # of times a woman has been pregnant and INCLUDES current preg. so no one would be 0. 0 are missing.

*Recode & label education
recode meduct (0=.) (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6)
recode heduct (0=.) (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6)
label define meduct 0 "illiterate" 1 "literate" 2 "1-4 primary educ" 3 "5-7" 4 "8-10" 5 "11-12" 6 ">12"
label val meduct meduct
label define heduct 0 "illiterate" 1 "literate" 2 "1-4 primary educ" 3 "5-7" 4 "8-10" 5 "11-12" 6 ">12"
label val heduct heduct

*Recode & label delivery place
gen institutional_delivery = .
replace institutional_delivery = 1 if placed==2 | placed==3 | placed==4 | placed==5
replace institutional_delivery = 0 if placed==1 | placed==6
drop placed
label var institutional_delivery "Institutional delivery"
label def institutional_delivery 0 "Home delivery" 1 "Hospital/PHC delivery"
label val institutional_delivery institutional_delivery

*Recoding comorbities. Assumptions: missing data, or "incorrect code" data, means comorbidity not present.
*IE - Anything except a "yes" is interpreted as a "no"
gen female = .
replace female = 0 if sex == 1
replace female = 1 if sex == 2
label def female 0 "male" 1 "female"
label val female female

gen year_birth = year(delivery_date)
label var year_birth "Calendar Year of Birth"

recode isfad (0=0)(1=1) (2=0)
recode delay (0=0)(1=1) (2=0)
recode twin (0=0)(1=1) (2=0)
recode hrisk1 (0=0)(1=1) (2=0)

recode feed_b (0=0)(1=1) (2=0)
recode feed_m (0=0)(1=1) (2=0)

recode ba (0=0)(1=1) (2=0)
recode cong (0=0)(1=1) (2=0)
recode aspnm (0=0)(1=1) (2=0)
recode hmd (0=0)(1=1) (2=0)
recode umbi (0=0)(1=1) (2=0)
recode conj (0=0)(1=1) (2=0)
recode unfev (0=0)(1=1) (2=0)
recode hemo (0=0)(1=1) (2=0)
recode hypo (0=0)(1=1) (2=0)
recode failu (0=0)(1=1) (2=0)
recode neosep (0=0)(1=1) (2=0) (.=0)
recode pnm_ch (0=0)(1=1) (2=0) (.=0)
recode bsi (0=0)(1=1) (2=0)
recode jaun (0=0)(1=1) (2=0)
recode boh (0=0)(1=1) (2=0)
recode tobause (0=0)(1=1) (2=0)

label def binary_label 0 "No" 1 "Yes"

label val isfad binary_label
label val delay binary_label
label val twin binary_label
label val hrisk1 binary_label

label val feed_b binary_label
label val feed_m binary_label

label val ba binary_label
label val cong binary_label
label val aspnm binary_label
label val hmd binary_label
label val umbi binary_label
label val conj binary_label
label val unfev binary_label
label val hemo binary_label
label val hypo binary_label
label val failu binary_label
label val neosep binary_label
label val pnm_ch binary_label
label val bsi binary_label
label val jaun binary_label
label val boh binary_label
label val tobause binary_label

**********Cleaning: Dropping Unneccessary Variables***********
drop moccup hoccup
*dropped occupation data

drop wtdiff
*Unneccessary

drop vr_no m_resi villno bplace
*Not needed

drop neo
*old data

drop aspnm
*Only 15 cases total
drop hmd
*Only 14 cases total
*Both mostly missing data

drop mpre
*same data as in gestational age, and coarser, so dropped

drop b_feed1
*drop b_feed1 - just using feed_m and feed_b for now

drop m_ht ancvisit
*data present only after 2008

drop inde
* not needed

**********Cleaning: Dropping Data Points***********
*drop deaths
drop if nbdth==1 | ch_dth == 1
drop nbdth_d
drop nbdth
drop ch_dth
drop dthday


*drop babies who have no d1 weight
drop if bwt==.
*drop babies who have no d28 weight
drop if wt28==.

*Recode extreme outliers to missing
drop if bwt > 4.5
drop if wt28 > 6
* Keeping outliers - small number so unlikely to affect

*TODO: check correlations to dropped variables
**********Cleaning: Generating convenient variables***********

*Convert weight from kg to g
gen wt1_g= bwt*1000
label var wt1_g "weight at birth in grams"
gen wt7_g= nbwt7*1000
label var wt7_g "weight at d7 in grams"
gen wt15_g= nbwt15*1000
label var wt15_g "weight at d15 in grams"
gen wt21_g= nbwt21*1000
label var wt21_g "weight at d21 in grams"
gen wt28_g= wt28*1000
label var wt28_g "weight at d28 in grams"

*Generate new variables to look at change in weight over time in grams
gen chwt_17= wt7_g-wt1_g
label var chwt_17 "weight change from birth to d7 (g)"
gen chwt_715= wt15_g-wt7_g
label var chwt_715 "weight change from d7 to d15 (g)"
gen chwt_1521= wt21_g-wt15_g
label var chwt_1521 "weight change from d15 to d21 (g)"
gen chwt_2128= wt28_g-wt21_g
label var chwt_2128 "weight change from d21 to d28 (g)"
gen chwt_128=wt28_g-wt1_g
label var chwt_128 "weight change from birth to d28 (g)"

*Generate variable to look at linear growth velocity
gen growth_vel = (chwt_128/bwt)/28
label var growth_vel "Growth velocity in g/kg/d"

*Patel et al exponential estimate of GV
gen exp_growth_vel = 1000*log(wt28_g/wt1_g)/28
label var exp_growth_vel "Exponential growth velocity (g/kg/d)"

*Generate new variable for gestational age that combines days and months
*convert months to weeks:
gen m_wk= grav_m*4.348
*convert days to weeks:
gen d_wk= grav_d/7
*create gestational age variable:
gen gage = m_wk + d_wk
label var gage "Gestational Age in weeks"
drop m_wk d_wk grav_m grav_d

*Collapse m_edu, f_edu, grav, para into 4,4,4,5 categories respectively
gen m_edu4= 0
replace m_edu4=1 if meduct==1 |meduct==2
replace m_edu4=2 if meduct==3 | meduct==4
replace m_edu4=3 if meduct==5 | meduct==6
replace m_edu4=. if meduct==.

label var m_edu4 "Maternal Educ in 4 Categories"
label def m_edu4 0 "Illiterate" 1 "1-4/Literate" 2 "5-10" 3 ">=11"
label val m_edu4 m_edu4
notes m_edu4: TS maternal edu in 4 categories

gen f_edu4= 0
replace f_edu4=1 if heduct==1 |heduct==2
replace f_edu4=2 if heduct==3 | heduct==4
replace f_edu4=3 if heduct==5 | heduct==6
replace f_edu4=. if heduct==.

label var f_edu4 "Paternal Educ in 4 Categories"
label def f_edu4 0 "Illiterate" 1 "1-4/Literate" 2 "5-10" 3 ">=11"
label val f_edu4 f_edu4
notes f_edu4: TS paternal edu in 4 categories

gen grav4= 1
replace grav4=2 if gravida==2
replace grav4=3 if gravida==3
replace grav4=4 if gravida>=4 & gravida<.
replace grav4=. if gravida==.

label var grav4 "Gravidity in 4 Categories"
label def grav4 1 "1st preg" 2 "2nd preg" 3 "3rd preg" 4 ">=4 preg"
label val grav4 grav4

gen para5= 0
replace para5=1 if para==1
replace para5=2 if para==2
replace para5=3 if para==3
replace para5=4 if para>=4 & para<.
replace para5=. if para==.

label var para5 "Parity in 5 Categories"
label def para5 0 "0 children" 1 "1 child" 2 "2 children" 3 "3 children" 4 ">=4 children"
label val para5 para5

gen morbidity_num = ba + cong + umbi + conj + unfev + hemo + hypo + neosep + pnm_ch + bsi + jaun + boh

gen CHW_visits = .
replace CHW_visits = 0 if nbvisit==0
replace CHW_visits = 1 if nbvisit>=1 & nbvisit<=5
replace CHW_visits = 2 if nbvisit>=6 & nbvisit<=10
replace CHW_visits = 3 if nbvisit>10
label var CHW_visits "Number of CHW visits"
label def CHW_visits 0 "0 visits" 1 "1-5 visits" 2 "5-10 visits" 3 "10+ visits"
label val CHW_visits CHW_visits

compress
save data/clean_data.dta,replace
log close
