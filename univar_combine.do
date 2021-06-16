clear all
use data/clean_data.dta
**********Analysis: Generate Univar summaries***********

*Univar graphs
hist gage, normal xtitle("Gestational Age (weeks)") title("Histogram of Neonates by Gestational Age in Weeks")
graph save stata_graphs/univar_gage.gph,replace
hist delivery_date, xtitle("Date of Birth") title("Histogram of Neonates by Date of Birth")
graph save stata_graphs/univar_dtbirth.gph,replace

graph bar (count), blabel(bar) over(female) b1title("Neonate Sex") ytitle("Number") title("Distribution of Neonates by Sex")
graph save stata_graphs/univar_sex.gph,replace
graph bar (count), blabel(bar) over(m_edu4) b1title("Mother's Education Level") ytitle("Number") title("Distribution of Neonates by Mother's Education Level")
graph save stata_graphs/univar_m_edu.gph,replace
graph bar (count), blabel(bar) over(f_edu4) b1title("Father's Education Level") ytitle("Number") title("Distribution of Neonates by Father's Education Level")
graph save stata_graphs/univar_f_edu.gph,replace
graph bar (count), blabel(bar) over(grav4) b1title("Mother's Gravidity") ytitle("Number") title("Distribution of Neonates by Mother's Gravidity")
graph save stata_graphs/univar_grav.gph,replace
graph bar (count), blabel(bar) over(para5) b1title("Mother's Parity") ytitle("Number") title("Distribution of Neonates by Mother's Parity")
graph save stata_graphs/univar_para.gph,replace
graph bar (count), blabel(bar) over(program_year, label(angle(90))) b1title("Year of Birth") ytitle("Number") title("Distribution of Neonates by (Program) Year of Birth") 
graph save stata_graphs/univar_year.gph,replace
graph bar (count), blabel(bar) over(CHW_visits) b1title("Number of Home Pregnancy Visits") ytitle("Number") title("Distribution of Neonates by Number of CHW Home Visits")
graph save stata_graphs/univar_CHW_v.gph,replace
graph bar (count), blabel(bar) over(institutional_delivery) b1title("Number of Home Pregnancy Visits") ytitle("Number") title("Distribution of Neonates by Delivery Place")
graph save stata_graphs/univar_CHW_v.gph,replace
graph bar (count), blabel(bar) over(isfad) b1title("CHW At Delivery?") ytitle("Number") title("Distribution of Neonates by CHW at Delivery")
graph save stata_graphs/univar_CHW_present.gph,replace


graph bar (count), blabel(bar) over(twin) b1title("Twin Birth") ytitle("Number") title("Distribution of Neonates by Twin Birth")
graph save stata_graphs/univar_twin.gph,replace
graph bar (count), blabel(bar) over(hrisk1) b1title("High Risk on Day 1") ytitle("Number") title("Distribution of Neonates by Risk on Day 1")
graph save stata_graphs/univar_hrisk1.gph,replace

graph bar (count), blabel(bar) over(ba) b1title("Birth Asphyxia Occurrence") ytitle("Number") title("Distribution of Neonates by Birth Asphyxia Occurrence")
graph save stata_graphs/univar_bi_asph.gph,replace
graph bar (count), blabel(bar) over(neo) b1title("Neonatal Sgphis Occurrence") ytitle("Number") title("Distribution of Neonates by Neonatal Sgphis Occurrence")
graph save stata_graphs/univar_neo_sep.gph,replace
graph bar (count), blabel(bar) over(hemo)  b1title("Hemorrhage Occurrence") ytitle("Number") title("Distribution of Neonates by Hemorrhage Occurrence")
graph save stata_graphs/univar_hemo.gph,replace
graph bar (count), blabel(bar) over(hypo)  b1title("Hypothermia Occurrence") ytitle("Number") title("Distribution of Neonates by Hypothermia Occurrence")
graph save stata_graphs/univar_hypo.gph,replace
graph bar (count), blabel(bar) over(unfev) b1title("Unexplained Fever Occurrence") ytitle("Number") title("Distribution of Neonates by Unexplained Fever Occurrence")
graph save stata_graphs/univar_u_fev.gph,replace
graph bar (count), blabel(bar) over(feed_m)  b1title("Mother Feeding Problem Occurrence") ytitle("Number") title("Distribution of Neonates by Mother Feeding Problem Occurrence")
graph save stata_graphs/univar_fdpr_m.gph,replace
graph bar (count), blabel(bar) over(feed_b)  b1title("Neonate Feeding Problem Occurrence") ytitle("Number") title("Distribution of Neonates by Neonate Feeding Problem Occurrence")
graph save stata_graphs/univar_fdpr_b.gph,replace
graph bar (count), blabel(bar) over(conj)  b1title("Conjunctivitis Occurrence") ytitle("Number") title("Distribution of Neonates by Conjunctivitis Occurrence")
graph save stata_graphs/univar_conj.gph,replace
graph bar (count), blabel(bar) over(bsi)  b1title("Bacterial Skin Infection Occurrence") ytitle("Number") title("Distribution of Neonates by Bacterial Skin Infection Occurrence")
graph save stata_graphs/univar_bsi.gph,replace
graph bar (count), blabel(bar) over(jaun) b1title("Jaundice Occurrence") ytitle("Number") title("Distribution of Neonates by Jaundice Occurrence")
graph save stata_graphs/univar_jaun.gph,replace
graph bar (count), blabel(bar) over(pnm_ch)  b1title("Pneumonia Occurrence") ytitle("Number") title("Distribution of Neonates by Pneumonia Occurrence")
graph save stata_graphs/univar_pnm.gph,replace
graph bar (count), blabel(bar) over(umbi)  b1title("Umbilical Sgphis Occurrence") ytitle("Number") title("Distribution of Neonates by Umbilical Sgphis Occurrence")
graph save stata_graphs/univar_umb_sep.gph,replace
graph bar (count), blabel(bar) over(tobause)  b1title("Tobacco Usage") ytitle("Number") title("Distribution of Neonates by Mother Tobacco Use in Pregnancy")
graph save stata_graphs/univar_tobause.gph,replace
graph bar (count), blabel(bar) over(tobause)  b1title("Obstetric History") ytitle("Number") title("Distribution of Neonates by Mother Obstetric History")
graph save stata_graphs/univar_boh.gph,replace

hist wt1_g, normal xtitle("Weight at Day 1") title("Histogram of Neonates by Weight on Day 1")
graph save stata_graphs/univar_wt1.gph,replace
hist wt7_g, normal xtitle("Weight at Day 7") title("Histogram of Neonates by Weight on Day 7")
graph save stata_graphs/univar_wt7.gph,replace
hist wt15_g, normal xtitle("Weight at Day 15") title("Histogram of Neonates by Weight on Day 15")
graph save stata_graphs/univar_wt15.gph,replace
hist wt28_g, normal  xtitle("Weight at Day 28") title("Histogram of Neonates by Weight on Day 28")
graph save stata_graphs/univar_wt28.gph,replace
hist chwt_128, normal xtitle("Weight Change From D1-28") title("Histogram of Neonates by Weight Change from D1-28")
graph save stata_graphs/univar_chwt28.gph,replace
hist growth_vel, normal xtitle("Growth velocity (kg/g/d)") title("Histogram of Neonates by Weight Change from D1-28")
graph save stata_graphs/univar_g_vel.gph,replace
hist exp_growth_vel, normal xtitle("Growth velocity (kg/g/d)") title("Histogram of Neonates by (Exponential) Weight Change from D1-28")
graph save stata_graphs/univar_exp_g_vel.gph,replace

cd stata_graphs

graph combine univar_bi_asph.gph univar_fdpr_b.gph univar_jaun.gph univar_umb_sep.gph univar_boh.gph univar_fdpr_m.gph   univar_bsi.gph 	univar_neo_sep.gph 	 univar_pnm.gph univar_conj.gph univar_hemo.gph univar_tobause.gph  	univar_hrisk1.gph univar_twin.gph  univar_hypo.gph univar_u_fev.gph univar_CHW_present.gph,rows(6) cols(3)
graph export combined_comorbs.eps,replace

graph combine univar_sex.gph univar_f_edu.gph univar_m_edu.gph univar_year.gph univar_CHW_v.gph,rows(3) cols (2)
graph export combined_demo.eps,replace

!zip -r combs.zip *.eps
