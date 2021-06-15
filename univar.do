clear all
use data/clean_data.dta
capture log close
log using logs/univar.log,text replace
**********Analysis: Generate Univar & Bivar summaries***********

****Summary statistics***

*Patient characteristics
sum mage
sum gage
tab sex,miss
tab m_edu4,miss
tab f_edu4,miss
tab grav4,miss
tab para5,miss
tab n_preg_visits,miss

*Comorbidities
tab bi_asph
tab neo_sep
tab hemo
tab twin
tab hypo
tab u_fev
tab fpr_d1
tab fdpr_m
tab fdpr_b
tab cong
tab conj
tab bsi
tab abjaun
tab jaun
tab pnm
tab uri
tab umb_sep

*Outcome variables: neonatal weights
sum wt1 wt7 wt15 wt28 growth_vel

*Outcome variables: neonatal weight changes
sum chwt_17 chwt_715 chwt_1528 chwt_128 growth_vel

*Univar graphs
hist mage, normal xtitle("Maternal Age (years)") title("Histogram of Neonates by Maternal Age in Years")
graph export graphs/univar_mage.eps,replace
hist gage, normal xtitle("Gestational Age (weeks)") title("Histogram of Neonates by Gestational Age in Weeks")
graph export graphs/univar_gage.eps,replace
hist dt_birth, xtitle("Date of Birth") title("Histogram of Neonates by Date of Birth")
graph export graphs/univar_dtbirth.eps,replace


graph bar (count),over(sex) b1title("Neonate Sex") ytitle("Number") title("Distribution of Neonates by Sex")
graph export graphs/univar_sex.eps,replace
graph bar (count),over(m_edu4) b1title("Mother's Education Level") ytitle("Number") title("Distribution of Neonates by Mother's Education Level")
graph export graphs/univar_m_edu.eps,replace
graph bar (count),over(f_edu4) b1title("Father's Education Level") ytitle("Number") title("Distribution of Neonates by Father's Education Level")
graph export graphs/univar_f_edu.eps,replace
graph bar (count),over(grav4) b1title("Mother's Gravidity") ytitle("Number") title("Distribution of Neonates by Mother's Gravidity")
graph export graphs/univar_grav.eps,replace
graph bar (count),over(para5) b1title("Mother's Parity") ytitle("Number") title("Distribution of Neonates by Mother's Parity")
graph export graphs/univar_para.eps,replace
graph bar (count),over(year_birth) b1title("Year of Birth") ytitle("Number") title("Distribution of Neonates by Year of Birth")
graph export graphs/univar_year.eps,replace
graph bar (count),over(n_preg_visits) b1title("Number of Home Pregnancy Visits") ytitle("Number") title("Distribution of Neonates by Number of Home Pregnancy Visits")
graph export graphs/univar_preg_v.eps,replace


graph bar (count),over(bi_asph) b1title("Birth Asphyxia Occurrence") ytitle("Number") title("Distribution of Neonates by Birth Asphyxia Occurrence")
graph export graphs/univar_bi_asph.eps,replace
graph bar (count),over(neo_sep) b1title("Neonatal Sepsis Occurrence") ytitle("Number") title("Distribution of Neonates by Neonatal Sepsis Occurrence") 
graph export graphs/univar_neo_sep.eps,replace
graph bar (count),over(hemo)  b1title("Hemorrhage Occurrence") ytitle("Number") title("Distribution of Neonates by Hemorrhage Occurrence")
graph export graphs/univar_hemo.eps,replace
graph bar (count),over(twin) b1title("Twin Birth") ytitle("Number") title("Distribution of Neonates by Twin Birth") 
graph export graphs/univar_twin.eps,replace
graph bar (count),over(hypo)  b1title("Hypothermia Occurrence") ytitle("Number") title("Distribution of Neonates by Hypothermia Occurrence")
graph export graphs/univar_hypo.eps,replace
graph bar (count),over(u_fev) b1title("Unexplained Fever Occurrence") ytitle("Number") title("Distribution of Neonates by Unexplained Fever Occurrence") 
graph export graphs/univar_u_fev.eps,replace
graph bar (count),over(fdpr_m)  b1title("Mother Feeding Problem Occurrence") ytitle("Number") title("Distribution of Neonates by Mother Feeding Problem Occurrence")
graph export graphs/univar_fdpr_m.eps,replace
graph bar (count),over(fdpr_b)  b1title("Neonate Feeding Problem Occurrence") ytitle("Number") title("Distribution of Neonates by Neonate Feeding Problem Occurrence")
graph export graphs/univar_fdpr_b.eps,replace
graph bar (count),over(conj)  b1title("Conjunctivitis Occurrence") ytitle("Number") title("Distribution of Neonates by Conjunctivitis Occurrence")
graph export graphs/univar_conj.eps,replace
graph bar (count),over(bsi)  b1title("Bacterial Skin Infection Occurrence") ytitle("Number") title("Distribution of Neonates by Bacterial Skin Infection Occurrence")
graph export graphs/univar_bsi.eps,replace
graph bar (count),over(abjaun) b1title("Abnormal Jaundice Occurrence") ytitle("Number") title("Distribution of Neonates by Abnormal Jaundice Occurrence") 
graph export graphs/univar_abjaun.eps,replace
graph bar (count),over(jaun) b1title("Jaundice Occurrence") ytitle("Number") title("Distribution of Neonates by Jaundice Occurrence") 
graph export graphs/univar_jaun.eps,replace
graph bar (count),over(pnm)  b1title("Pneumonia Occurrence") ytitle("Number") title("Distribution of Neonates by Pneumonia Occurrence")
graph export graphs/univar_pnm.eps,replace
graph bar (count),over(uri)  b1title("Upper Respiratory Infection Occurrence") ytitle("Number") title("Distribution of Neonates by Upper Respiratory Infection Occurrence")
graph export graphs/univar_uri.eps,replace
graph bar (count),over(umb_sep)  b1title("Umbilical Sepsis Occurrence") ytitle("Number") title("Distribution of Neonates by Umbilical Sepsis Occurrence")
graph export graphs/univar_umb_sep.eps,replace

hist wt1, normal xtitle("Weight at Day 1") title("Histogram of Neonates by Weight on Day 1")
graph export graphs/univar_wt1.eps,replace
hist wt7, normal xtitle("Weight at Day 7") title("Histogram of Neonates by Weight on Day 7")
graph export graphs/univar_wt7.eps,replace
hist wt15, normal xtitle("Weight at Day 15") title("Histogram of Neonates by Weight on Day 15")
graph export graphs/univar_wt15.eps,replace
hist wt28, normal  xtitle("Weight at Day 28") title("Histogram of Neonates by Weight on Day 28")
graph export graphs/univar_wt28.eps,replace
hist chwt_128, normal xtitle("Weight Change From D1-28") title("Histogram of Neonates by Weight Change from D1-28")
graph export graphs/univar_chwt28.eps,replace
hist growth_vel, normal xtitle("Growth velocity (kg/g/d)") title("Histogram of Neonates by Weight Change from D1-28")
graph export graphs/univar_g_vel.eps,replace

log close

