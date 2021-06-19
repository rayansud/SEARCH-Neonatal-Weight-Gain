clear all
use data/clean_data.dta
**********Analysis: Generate Univar summaries***********


hist wt1_g, frequency addlabels xtitle("Birth Weight (g)") title("Histogram of Neonates by Birth Weight (g)") width(500) start(0) xlabel(0 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000,angle(vertical))
graph save graphs/g1.gph
hist wt28_g, frequency addlabels xtitle("Day 28 Weight (g)") title("Histogram of Neonates by Day 28 Weight (g)") width(500) start(0)  xlabel(0 500 1000 1500 2000 2500 3000 3500 4000 4500 5000 5500 6000,angle(vertical))
graph save graphs/g2.gph
graph combine graphs/g1.gph graphs/g2.gph,rows(1) cols(2)
graph export graphs/outliers.eps,replace
!rm -rf graphs/*.gph

*Univar graphs
hist gage, normal xtitle("Gestational Age (weeks)") title("Histogram of Neonates by Gestational Age in Weeks")
graph export stata_graphs/univar_gage.eps,replace
hist delivery_date, xtitle("Date of Birth") title("Histogram of Neonates by Date of Birth")
graph export stata_graphs/univar_dtbirth.eps,replace

graph bar (count), blabel(bar) over(female) b1title("Neonate Sex") ytitle("Number") title("Distribution of Neonates by Sex")
graph export stata_graphs/univar_sex.eps,replace
graph bar (count), blabel(bar) over(m_edu4) b1title("Mother's Education Level") ytitle("Number") title("Distribution of Neonates by Mother's Education Level")
graph export stata_graphs/univar_m_edu.eps,replace
graph bar (count), blabel(bar) over(f_edu4) b1title("Father's Education Level") ytitle("Number") title("Distribution of Neonates by Father's Education Level")
graph export stata_graphs/univar_f_edu.eps,replace
graph bar (count), blabel(bar) over(grav4) b1title("Mother's Gravidity") ytitle("Number") title("Distribution of Neonates by Mother's Gravidity")
graph export stata_graphs/univar_grav.eps,replace
graph bar (count), blabel(bar) over(para5) b1title("Mother's Parity") ytitle("Number") title("Distribution of Neonates by Mother's Parity")
graph export stata_graphs/univar_para.eps,replace
graph bar (count), blabel(bar) over(program_year, label(angle(90))) b1title("Year of Birth") ytitle("Number") title("Distribution of Neonates by (Program) Year of Birth")
graph export stata_graphs/univar_year.eps,replace
graph bar (count), blabel(bar) over(CHW_visits) b1title("Number of Home Pregnancy Visits") ytitle("Number") title("Distribution of Neonates by Number of CHW Home Visits")
graph export stata_graphs/univar_CHW_v.eps,replace
graph bar (count), blabel(bar) over(institutional_delivery) b1title("Number of Home Pregnancy Visits") ytitle("Number") title("Distribution of Neonates by Delivery Place")
graph export stata_graphs/univar_CHW_v.eps,replace
graph bar (count), blabel(bar) over(isfad) b1title("CHW At Delivery?") ytitle("Number") title("Distribution of Neonates by CHW at Delivery")
graph export stata_graphs/univar_CHW_present.eps,replace


graph bar (count), blabel(bar) over(twin) b1title("Twin Birth") ytitle("Number") title("Distribution of Neonates by Twin Birth")
graph export stata_graphs/univar_twin.eps,replace
graph bar (count), blabel(bar) over(hrisk1) b1title("High Risk on Day 1") ytitle("Number") title("Distribution of Neonates by Risk on Day 1")
graph export stata_graphs/univar_hrisk1.eps,replace

graph bar (count), blabel(bar) over(ba) b1title("Birth Asphyxia Occurrence") ytitle("Number") title("Distribution of Neonates by Birth Asphyxia Occurrence")
graph export stata_graphs/univar_bi_asph.eps,replace
graph bar (count), blabel(bar) over(neo) b1title("Neonatal Sgphis Occurrence") ytitle("Number") title("Distribution of Neonates by Neonatal Sgphis Occurrence")
graph export stata_graphs/univar_neo_sep.eps,replace
graph bar (count), blabel(bar) over(hemo)  b1title("Hemorrhage Occurrence") ytitle("Number") title("Distribution of Neonates by Hemorrhage Occurrence")
graph export stata_graphs/univar_hemo.eps,replace
graph bar (count), blabel(bar) over(hypo)  b1title("Hypothermia Occurrence") ytitle("Number") title("Distribution of Neonates by Hypothermia Occurrence")
graph export stata_graphs/univar_hypo.eps,replace
graph bar (count), blabel(bar) over(unfev) b1title("Unexplained Fever Occurrence") ytitle("Number") title("Distribution of Neonates by Unexplained Fever Occurrence")
graph export stata_graphs/univar_u_fev.eps,replace
graph bar (count), blabel(bar) over(feed_m)  b1title("Mother Feeding Problem Occurrence") ytitle("Number") title("Distribution of Neonates by Mother Feeding Problem Occurrence")
graph export stata_graphs/univar_fdpr_m.eps,replace
graph bar (count), blabel(bar) over(feed_b)  b1title("Neonate Feeding Problem Occurrence") ytitle("Number") title("Distribution of Neonates by Neonate Feeding Problem Occurrence")
graph export stata_graphs/univar_fdpr_b.eps,replace
graph bar (count), blabel(bar) over(delay)  b1title("Neonate Feeding Problem Occurrence") ytitle("Number") title("Distribution of Neonates by Breastfeeding Delay")
graph export stata_graphs/univar_fdpr_b.eps,replace
graph bar (count), blabel(bar) over(conj)  b1title("Conjunctivitis Occurrence") ytitle("Number") title("Distribution of Neonates by Conjunctivitis Occurrence")
graph export stata_graphs/univar_conj.eps,replace
graph bar (count), blabel(bar) over(bsi)  b1title("Bacterial Skin Infection Occurrence") ytitle("Number") title("Distribution of Neonates by Bacterial Skin Infection Occurrence")
graph export stata_graphs/univar_bsi.eps,replace
graph bar (count), blabel(bar) over(jaun) b1title("Jaundice Occurrence") ytitle("Number") title("Distribution of Neonates by Jaundice Occurrence")
graph export stata_graphs/univar_jaun.eps,replace
graph bar (count), blabel(bar) over(pnm_ch)  b1title("Pneumonia Occurrence") ytitle("Number") title("Distribution of Neonates by Pneumonia Occurrence")
graph export stata_graphs/univar_pnm.eps,replace
graph bar (count), blabel(bar) over(umbi)  b1title("Umbilical Sepsis Occurrence") ytitle("Number") title("Distribution of Neonates by Umbilical Sepsis Occurrence")
graph export stata_graphs/univar_umb_sep.eps,replace
graph bar (count), blabel(bar) over(tobause)  b1title("Tobacco Usage") ytitle("Number") title("Distribution of Neonates by Mother Tobacco Use in Pregnancy")
graph export stata_graphs/univar_tobause.eps,replace
graph bar (count), blabel(bar) over(tobause)  b1title("Obstetric History") ytitle("Number") title("Distribution of Neonates by Mother Obstetric History")
graph export stata_graphs/univar_boh.eps,replace

hist wt1_g, normal xtitle("Weight at Day 1") title("Histogram of Neonates by Weight on Day 1")
graph export stata_graphs/univar_wt1.eps,replace
hist wt7_g, normal xtitle("Weight at Day 7") title("Histogram of Neonates by Weight on Day 7")
graph export stata_graphs/univar_wt7.eps,replace
hist wt15_g, normal xtitle("Weight at Day 15") title("Histogram of Neonates by Weight on Day 15")
graph export stata_graphs/univar_wt15.eps,replace
hist wt28_g, normal  xtitle("Weight at Day 28") title("Histogram of Neonates by Weight on Day 28")
graph export stata_graphs/univar_wt28.eps,replace
hist chwt_128, normal xtitle("Weight Change From D1-28") title("Histogram of Neonates by Weight Change from D1-28")
graph export stata_graphs/univar_chwt28.eps,replace
hist growth_vel, normal xtitle("Growth velocity (g/kg/d)") title("Histogram of Neonates by Weight Change from D1-28")
graph export stata_graphs/univar_g_vel.eps,replace
hist exp_growth_vel, normal xtitle("Growth velocity (g/kg/d)") title("Histogram of Neonates by (Exponential) Weight Change from D1-28")
graph export stata_graphs/univar_exp_g_vel.eps,replace

/*
cd stata_graphs

graph combine univar_bi_asph.eps univar_fdpr_b.eps univar_jaun.eps univar_umb_sep.eps univar_boh.eps univar_fdpr_m.eps   univar_bsi.eps 	univar_neo_sep.eps 	 univar_pnm.eps univar_conj.eps univar_hemo.eps univar_tobause.eps  	univar_hrisk1.eps univar_twin.eps  univar_hypo.eps univar_u_fev.eps univar_CHW_present.eps,rows(6) cols(3)
graph export combined_comorbs.eps,replace

graph combine univar_sex.eps univar_f_edu.eps univar_m_edu.eps univar_year.eps univar_CHW_v.eps,rows(3) cols (2)
graph export combined_demo.eps,replace

graph combine univar_gage.eps univar_para.eps univar_grav.eps,rows(2) cols(2)
graph export combined_chars.eps,replace

graph combine univar_g_vel.eps univar_exp_g_vel.eps, rows(2)
graph export combined_vel.eps,replace
graph combine univar_wt1.eps univar_wt7.eps univar_wt15.eps univar_wt28.eps univar_chwt28.eps, rows(3) cols(2)
graph export combined_wts.eps,replace

cd ..
*/

/*
estpost sum gage
esttab . using tables/univar_gage.rtf,cells("count mean sd min max")


estpost tab1 female m_edu4 f_edu4 grav4 para5 institutional_delivery twin hrisk1 feed_b feed_m ba cong umbi conj unfev hemo  hypo failu neo pnm_ch bsi jaun boh tobause program_year CHW_visits,miss
esttab . using tables/univar_categorical.rtf,cells("b pct")

*Outcome variables: neonatal weights
estpost sum wt1_g wt7_g wt15_g wt28_g
esttab . using tables/univar_weights.rtf,cells("count mean sd min max")

*Outcome variables: neonatal weight changes
estpost sum chwt_17 chwt_715 chwt_1528 chwt_128 growth_vel exp_growth_vel
esttab . using tables/univar_changes.rtf,cells("count mean sd min max")

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
*/
!zip -r zips/graphs.zip graphs/*.eps
