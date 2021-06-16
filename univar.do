clear all
use data/clean_data.dta
capture log close
log using logs/univar.log,text replace
**********Analysis: Generate Univar & Bivar summaries***********

****Summary statistics***

*Patient characteristics
sum gage
tab1 female m_edu4 f_edu4 grav4 para5,miss

tab1 institutional_delivery,missing

*Comorbidities
tab1 twin hrisk1, miss
tab1 feed_b feed_m, miss
tab1 ba cong umbi conj unfev hemo  hypo failu neo pnm_ch bsi jaun boh tobause, miss

tab program_year,miss

tab CHW_visits,miss

*Outcome variables: neonatal weights
sum wt1_g wt7_g wt15_g wt28_g

*Outcome variables: neonatal weight changes
sum chwt_17 chwt_715 chwt_1528 chwt_128 growth_vel exp_growth_vel


/*
*Univar graphs - done separately and combined for now, can be uncommented for specific wanted graphs
hist gage, normal xtitle("Gestational Age (weeks)") title("Histogram of Neonates by Gestational Age in Weeks")
graph export graphs/univar_gage.eps,replace
hist delivery_date, xtitle("Date of Birth") title("Histogram of Neonates by Date of Birth")
graph export graphs/univar_dtbirth.eps,replace

graph bar (count),over(female) b1title("Neonate Sex") ytitle("Number") title("Distribution of Neonates by Sex")
graph export graphs/univar_sex.eps,replace
graph bar (count),over(m_edu4) b1title("Mother's Education Level") ytitle("Number") title("Distribution of Neonates by Mother's Education Level")
graph export graphs/univar_m_edu.eps,replace
graph bar (count),over(f_edu4) b1title("Father's Education Level") ytitle("Number") title("Distribution of Neonates by Father's Education Level")
graph export graphs/univar_f_edu.eps,replace
graph bar (count),over(grav4) b1title("Mother's Gravidity") ytitle("Number") title("Distribution of Neonates by Mother's Gravidity")
graph export graphs/univar_grav.eps,replace
graph bar (count),over(para5) b1title("Mother's Parity") ytitle("Number") title("Distribution of Neonates by Mother's Parity")
graph export graphs/univar_para.eps,replace
graph bar (count),over(program_year) b1title("Year of Birth") ytitle("Number") title("Distribution of Neonates by (Program) Year of Birth")
graph export graphs/univar_year.eps,replace
graph bar (count),over(CHW_visits) b1title("Number of Home Pregnancy Visits") ytitle("Number") title("Distribution of Neonates by Number of CHW Home Visits")
graph export graphs/univar_CHW_v.eps,replace
graph bar (count),over(institutional_delivery) b1title("Number of Home Pregnancy Visits") ytitle("Number") title("Distribution of Neonates by Delivery Place")
graph export graphs/univar_CHW_v.eps,replace
graph bar (count),over(isfad) b1title("CHW At Delivery?") ytitle("Number") title("Distribution of Neonates by CHW at Delivery")
graph export graphs/univar_CHW_present.eps,replace


graph bar (count),over(twin) b1title("Twin Birth") ytitle("Number") title("Distribution of Neonates by Twin Birth")
graph export graphs/univar_twin.eps,replace
graph bar (count),over(hrisk1) b1title("High Risk on Day 1") ytitle("Number") title("Distribution of Neonates by Risk on Day 1")
graph export graphs/univar_hrisk1.eps,replace

graph bar (count),over(ba) b1title("Birth Asphyxia Occurrence") ytitle("Number") title("Distribution of Neonates by Birth Asphyxia Occurrence")
graph export graphs/univar_bi_asph.eps,replace
graph bar (count),over(neo) b1title("Neonatal Sepsis Occurrence") ytitle("Number") title("Distribution of Neonates by Neonatal Sepsis Occurrence")
graph export graphs/univar_neo_sep.eps,replace
graph bar (count),over(hemo)  b1title("Hemorrhage Occurrence") ytitle("Number") title("Distribution of Neonates by Hemorrhage Occurrence")
graph export graphs/univar_hemo.eps,replace
graph bar (count),over(hypo)  b1title("Hypothermia Occurrence") ytitle("Number") title("Distribution of Neonates by Hypothermia Occurrence")
graph export graphs/univar_hypo.eps,replace
graph bar (count),over(unfev) b1title("Unexplained Fever Occurrence") ytitle("Number") title("Distribution of Neonates by Unexplained Fever Occurrence")
graph export graphs/univar_u_fev.eps,replace
graph bar (count),over(feed_m)  b1title("Mother Feeding Problem Occurrence") ytitle("Number") title("Distribution of Neonates by Mother Feeding Problem Occurrence")
graph export graphs/univar_fdpr_m.eps,replace
graph bar (count),over(feed_b)  b1title("Neonate Feeding Problem Occurrence") ytitle("Number") title("Distribution of Neonates by Neonate Feeding Problem Occurrence")
graph export graphs/univar_fdpr_b.eps,replace
graph bar (count),over(conj)  b1title("Conjunctivitis Occurrence") ytitle("Number") title("Distribution of Neonates by Conjunctivitis Occurrence")
graph export graphs/univar_conj.eps,replace
graph bar (count),over(bsi)  b1title("Bacterial Skin Infection Occurrence") ytitle("Number") title("Distribution of Neonates by Bacterial Skin Infection Occurrence")
graph export graphs/univar_bsi.eps,replace
graph bar (count),over(jaun) b1title("Jaundice Occurrence") ytitle("Number") title("Distribution of Neonates by Jaundice Occurrence")
graph export graphs/univar_jaun.eps,replace
graph bar (count),over(pnm_ch)  b1title("Pneumonia Occurrence") ytitle("Number") title("Distribution of Neonates by Pneumonia Occurrence")
graph export graphs/univar_pnm.eps,replace
graph bar (count),over(umbi)  b1title("Umbilical Sepsis Occurrence") ytitle("Number") title("Distribution of Neonates by Umbilical Sepsis Occurrence")
graph export graphs/univar_umb_sep.eps,replace
graph bar (count),over(tobause)  b1title("Tobacco Usage") ytitle("Number") title("Distribution of Neonates by Mother Tobacco Use in Pregnancy")
graph export graphs/univar_tobause.eps,replace
graph bar (count),over(tobause)  b1title("Obstetric History") ytitle("Number") title("Distribution of Neonates by Mother Obstetric History")
graph export graphs/univar_boh.eps,replace

hist wt1_g, normal xtitle("Weight at Day 1") title("Histogram of Neonates by Weight on Day 1")
graph export graphs/univar_wt1.eps,replace
hist wt7_g, normal xtitle("Weight at Day 7") title("Histogram of Neonates by Weight on Day 7")
graph export graphs/univar_wt7.eps,replace
hist wt15_g, normal xtitle("Weight at Day 15") title("Histogram of Neonates by Weight on Day 15")
graph export graphs/univar_wt15.eps,replace
hist wt28_g, normal  xtitle("Weight at Day 28") title("Histogram of Neonates by Weight on Day 28")
graph export graphs/univar_wt28.eps,replace
hist chwt_128, normal xtitle("Weight Change From D1-28") title("Histogram of Neonates by Weight Change from D1-28")
graph export graphs/univar_chwt28.eps,replace
hist growth_vel, normal xtitle("Growth velocity (kg/g/d)") title("Histogram of Neonates by Weight Change from D1-28")
graph export graphs/univar_g_vel.eps,replace
hist exp_growth_vel, normal xtitle("Growth velocity (kg/g/d)") title("Histogram of Neonates by (Exponential) Weight Change from D1-28")
graph export graphs/univar_exp_g_vel.eps,replace
*/
log close
