clear all
set more off

capture log close
log using logs/cleaning.log, text replace

use data/new_data.dta

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
*TODO: what is more reliable? Gestational age or Preterm classification? No need to keep both.
*Similar for LBW

rename hv1 dt_hv1
rename hv2 dt_hv2
rename hv3 dt_hv3

*Label dataset variables

*ID:
label var srno "serial number"
label var bplace "birthplace- village"
label var reg_dt "registration date"

*Demographics:
label var sex "neonate gender"
label var mage "age of mother (yrs)"
label var m_edu "maternal education"
label var f_edu "father's education"
label var m_occ "mother's occupation"
label var f_occ "father's occupation"

*Pregnancy info
label var grav_m "completed months of pregnancy"
label var grav_d "completed days of pregnancy"
label var  grav "gravida"
label var para "para"
label var lmp "last menstrual period"
label var dt_hv1 "pregnancy visit 1"
label var dt_hv2 "pregnancy visit 2"
label var dt_hv3 "pregnancy visit 3"



*Outcomes
label var dt1 "date_day 1 (birth)"
label var wt1 "weight_day1 (birth)"
label var dt7 "date_ neon day 7"
label var wt7 "weight_neon day7"
label var dt15 "date_neon day 15"
label var wt15 "weight_neon day15"
label var dt28 "date_neon day 28"
label var wt28 "weight_neon day 28"


*Comorbidities:
label var prev_st "previous stillbirth"
label var bi_asph "birth asphyxia"
label var cong "congenital anomaly"
label var lbw "low birth weight"
label var d_feed "delayed feeding"
label var f_feed "feeding problem"
* confirm criteria for feeding variables!!!!
label var f_prob "feeding problem"
label var neo_sep "neonatal sepsis"
label var nseps_c "sepsis criteria"
label var hemo "hemorrhage"
label var conj "conjunctivitis"
label var bsi "bacterial skin infxn"
label var abjaun "abnl jaundice"
label var jaun "jaundice"
label var asp_pnm "aspiration pneumonia"
label var hmd "hyaline membrane disease"
label var pnm "pneumonia only"
label var uri "upper respiratory infxn"
label var hypo "hypothermia"
label var umb_sep "umbilical sepsis"
label var u_fev "unexplained fever"
label var neo_dth "neonatal death"
label var dthday "day of death in neon pd"
label var fdpr_m "mom feeding problem"
label var fdpr_b "baby feeding problem"
label var fdpr_both "both feeding problem"
label var dt_birth "date of birth"
label var hrk_d1 "high risk on d1"
note: day 1 is day of birth
label var fdpr_d1 "feeding problem on d1"
label var still "stillbirth"
label var twin "twins"

**********Cleaning: Dropping Unneccessary Variables***********
drop _merge7 _merge15 _merge28 _mergemom _mergesex _mergemorbid m_occ f_occ _mergestill _mergemiss
*dropped occupation data bc only present at beginning and not collected by SEARCH- recorded from census. Maheshbhau says education is a better surrogate for SES. can add back in if needed

drop diet7 diet8 diet9 eat7 eat8 eat9
*data collected in under 50% of cases

drop f_prob
*mostly missing data

drop nseps_c
*criteria already coded into n_seps variable

drop asp_pnm
drop hmd
*mostly missing data

drop preterm
*same data as in gestational age, and coarser, so dropped

drop lbw
*same data as in wt1, and coarser, so dropped

*drop f_feed,d_feed,fdpr_d1,fdpr_both - just using fdpr_m and fdpr_b
drop f_feed
drop d_feed
label def fdpr_both 0 "yes" 1 "no"
label val fdpr_both fdpr_both
replace fdpr_both=1 if fdpr_both==.
drop fdpr_both

**********Cleaning: Recoding data***********

*Recode missing from 0 to "."
recode wt1 0=.
recode wt7 0=.
recode wt15 0=.
recode wt28 0=.
recode grav_m 0=.
recode mage 0=.
recode mage 1=.
recode mage 2=.

recode grav (0=.)
*gravidity= # of times a woman has been pregnant and INCLUDES current preg. so no one would be 0. 0 are missing.

*Recode down by 1
recode m_edu (0=.) (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6)
recode f_edu (0=.) (1=0) (2=1) (3=2) (4=3) (5=4) (6=5) (7=6)

label define m_edu 0 "illiterate" 1 "literate" 2 "1-4 primary educ" 3 "5-7" 4 "8-10" 5 "11-12" 6 ">12"
label val m_edu m_edu
label define f_edu 0 "illiterate" 1 "literate" 2 "1-4 primary educ" 3 "5-7" 4 "8-10" 5 "11-12" 6 ">12"
label val f_edu f_edu

*Recoding comorbities. Assumptions: missing data, or "incorrect code" data, means comorbidity not present.
*IE - Anything exceept a "yes" is interpreted as a "no"
recode prev_st (0=.) (1=0) (2=1) (3=.)
label def prev_st 0 "yes" 1 "no"
label val prev_st prev_st
replace prev_st=1 if prev_st==.

recode sex (0=.) (1=0) (2=1)
label def sex 0 "male" 1 "female"
label val sex sex

recode bi_asph (0=.)(1=0) (2=1)
label def bi_asph 0 "yes" 1 "no" 
label val bi_asph bi_asph
replace bi_asph=1 if bi_asph==.


label def fy 1996 "apr 1996" 1 "no", modify

recode cong (0=.)(1=0) (2=1) 
label def cong 0 "yes" 1 "no", modify
label val cong cong
replace cong=1 if cong==.

recode neo_sep (0=.) (1=0) (2=1)
label def neo_sep 0 "yes" 1 "no" 
label val neo_sep neo_sep
replace neo_sep=1 if neo_sep==.

recode hemo (0=.) (1=0) (2=1)
label def hemo 0 "yes" 1 "no" 
label val hemo hemo
replace hemo=1 if hemo==.

recode conj (0=.) (1=0) (2=1)
label def conj 0 "yes" 1 "no" 
label val conj conj
replace conj=1 if conj==.

recode bsi (0=.) (1=0) (2=1)
label def bsi 0 "yes" 1 "no" 
label val bsi bsi
replace bsi=1 if bsi==.

recode abjaun (0=.) (1=0) (2=1)
label def abjaun 0 "yes" 1 "no" 
label val abjaun abjaun
replace abjaun=1 if abjaun==.

recode jaun (0=.) (1=0) (2=1)
label def jaun 0 "yes" 1 "no" 
label val jaun jaun
replace jaun=1 if jaun==.

recode pnm (0=.) (1=0) (2=1)
label def pnm 0 "yes" 1 "no" 
label val pnm pnm
replace pnm=1 if pnm==.

recode uri (0=.) (1=0) (2=1)
label def uri 0 "yes" 1 "no" 
label val uri uri
replace uri=1 if uri==.

recode hypo (0=.) (1=0) (2=1)
label def hypo 0 "yes" 1 "no" 
label val hypo hypo
replace hypo=1 if hypo==.

recode umb_sep (0=.) (1=0) (2=1)
label def umb_sep 0 "yes" 1 "no" 
label val umb_sep umb_sep
replace umb_sep=1 if umb_sep==.

recode u_fev (0=.) (1=0) (2=1)
label def u_fev 0 "yes" 1 "no" 
label val u_fev u_fev
replace u_fev=1 if u_fev==.

replace still=2 if still==0
recode still(1=0) (2=1)
label def still 0 "yes" 1 "no"
label val still still

recode twin (0=1)(2=0) (3=2)
label def twin 0 "yes" 1 "no" 2 "triplets"
label val twin twin

replace fdpr_m=1 if fdpr_m==.
label def fdpr_m 0 "yes" 1 "no" 
label val fdpr_m fdpr_m

replace fdpr_b=1 if fdpr_b==.
label def fdpr_b 0 "yes" 1 "no" 
label val fdpr_b fdpr_b

encode fdpr_d1, generate(fpr_d1)
drop fdpr_d1
recode fpr_d1 (1=0) (2=1)
label def fpr_d1 0 "yes" 1 "no", modify
label val fpr_d1 fpr_d1
replace fpr_d1=1 if fpr_d1==.

encode hrk_d1, generate(hr_d1)
drop hrk_d1
recode hr_d1(1=0) (2=1)
label def hr_d1 0 "yes" 1 "no", modify
label val hr_d1 hr_d1


label def neo_dth 0 "yes" 1 "no"
label val neo_dth neo_dth
replace neo_dth=1 if wt28>0 & wt28<.

gen year_birth = year(dofc(dt_birth))

**********Cleaning: Dropping Data Points***********
*TODO: figure out biasing here
*dropping stillbirths
drop if still==0
*dropping those not at final followup
drop if wt28==.
*drop babies who have no d1 weight
drop if wt1==.
drop dthday
drop neo_dth

*TODO: drop if certain key variables missing
*drop if sex==.
*drop if mage==.
*potentially important auxilliary variables for missing weight data: m_edu, f_edu, n_preg_visits
**********Cleaning: Generating convenient variables***********

*Convert weight from kg to g
gen wt1_g= wt1*1000
label var wt1_g "weight at birth in grams"
gen wt7_g= wt7*1000
label var wt7_g "weight at d7 in grams"
gen wt15_g= wt15*1000
label var wt15_g "weight at d15 in grams"
gen wt28_g= wt28*1000
label var wt28_g "weight at d28 in grams"


*Generate new variable to look at change in weight over time in grams
gen chwt_17= wt7_g-wt1_g
label var chwt_17 "weight change from birth to d7 (g)"
gen chwt_715= wt15_g-wt7_g
label var chwt_715 "weight change from d7 to d15 (g)"
gen chwt_1528= wt28_g-wt15_g
label var chwt_1528 "weight change from d15 to d28 (g)"
gen chwt_128=wt28_g-wt1_g
label var chwt_128 "weight change from birth to d28 (g)"

*Generate variable to look at growth velocity
gen growth_vel = (chwt_128/wt1)/28
label var growth_vel "Growth velocity in kg/g/d"

*Patel et al exponential estimate of GV
gen exp_growth_vel = 1000*log(wt28/wt1)/28

*Generate new variable for gestational age that combines days and months
*convert months to weeks:
gen m_wk= grav_m*4.348
*convert days to weeks:
gen d_wk= grav_d/7
*create gestational age variable:
gen gage= m_wk + d_wk
label var gage "Gestational Age in weeks"
drop m_wk d_wk

*Collapse m_edu, f_edu, grav, para into 4,4,4,5 categories respectively
gen m_edu4= 0
replace m_edu4=1 if m_edu==1 |m_edu==2
replace m_edu4=2 if m_edu==3 | m_edu==4
replace m_edu4=3 if m_edu==5 | m_edu==6
replace m_edu4=. if m_edu==.

label var m_edu4 "Maternal Educ in 4 Categories"
label def m_edu4 0 "Illiterate" 1 "1-4/Literate" 2 "5-10" 3 ">=11"
label val m_edu4 m_edu4
notes m_edu4: TS maternal edu in 4 categories 

gen f_edu4= 0
replace f_edu4=1 if f_edu==1 |f_edu==2
replace f_edu4=2 if f_edu==3 | f_edu==4
replace f_edu4=3 if f_edu==5 | f_edu==6
replace f_edu4=. if f_edu==.

label var f_edu4 "Paternal Educ in 4 Categories"
label def f_edu4 0 "Illiterate" 1 "1-4/Literate" 2 "5-10" 3 ">=11"
label val f_edu4 f_edu4
notes f_edu4: TS paternal edu in 4 categories 

gen grav4= 1
replace grav4=2 if grav==2
replace grav4=3 if grav==3
replace grav4=4 if grav>=4 & grav<.
replace grav4=. if grav==.

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

*Generate dummies for maternal & gestational age ranges (for later adjusted mean calculation)
gen d_mage = 0
replace d_mage = 1 if mage>=20 & mage <25
replace d_mage = 2 if mage>=25 & mage <30
replace d_mage = 3 if mage>=30 & mage <35
replace d_mage = 4 if mage>=35 & mage <40
replace d_mage = 5 if mage>=40 & mage <.
replace d_mage =. if mage==.

label var d_mage "Maternal Age Ranges"
label def mage_categories 0 "<20 years" 1 "20-24 years" 2 "25-29 years" 3 "30-34 years" 4 ">=35-39 years" 5 ">=40 years"
label values d_mage mage_categories

gen d_gage = 0
replace d_gage = 1 if gage>=30 & mage <32
replace d_gage = 2 if gage>=32 & mage <34
replace d_gage = 3 if gage>=34 & mage <36
replace d_gage = 4 if gage>=36 & mage <38
replace d_gage = 5 if gage>=38 & mage <40
replace d_gage = 6 if gage>=40 & mage <42
replace d_gage = 7 if gage>=42 & mage <44
replace d_gage = 8 if gage>=44 & mage <.
replace d_gage =. if gage==.

label var d_gage "Gestational Age Ranges"
label def gage_categories 0 "<30 weeks" 1 "30-32 weeks" 2 "32-34 weeks" 3 "34-36 weeks" 4 ">=36-38 weeks" 5 "38-40 weeks" 6 "40-42 weeks" 7 "42-44 weeks" 8 ">=44 weeks"
label val d_gage gage_categories

***TODO: correctly generate number of pregnancy visit variable
*Generate new variable for pregnancy visits
*if have dates for visits 2 and 3 but not 1...does this mean 3 visits?
*look back in data and see if there is a variable for # of visits during pregnancy.

gen n_preg_visits = 0
replace n_preg_visits = 0 if dt_hv3==. & dt_hv2==. & dt_hv1==.
replace n_preg_visits = 1 if dt_hv3==. & dt_hv2==. & dt_hv1>0 & dt_hv1<.
replace n_preg_visits = 2 if dt_hv3==. & dt_hv1>0 & dt_hv1<. & dt_hv2>0 & dt_hv2<.
replace n_preg_visits = 3 if dt_hv3>0 & dt_hv3<. & dt_hv2>0 & dt_hv2<. & dt_hv1>0 & dt_hv1<.
label define n_preg_visits 0 "0 visits" 1 "1 visit" 2 "2 visits" 3 "3 visits"
label val n_preg_visits n_preg_visits


gen morbidity_num = bi_asph + neo_sep + hemo + twin + hypo + u_fev + fpr_d1 + fdpr_m + fdpr_b + cong + conj + bsi + abjaun + jaun + pnm + uri + umb_sep

compress
save data/clean_data.dta,replace
log close


