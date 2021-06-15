clear all
set more off

capture log close
log using logs/bivar_velocity.log, text replace

use data/clean_data.dta

******Bivariate correlation checks****
regress growth_vel mage
regress growth_vel gage
regress growth_vel dt_birth

ttest growth_vel,by(sex)
oneway growth_vel m_edu4,tabulate
oneway growth_vel f_edu4,tabulate
oneway growth_vel grav4,tabulate
oneway growth_vel para5,tabulate
oneway growth_vel year_birth,tabulate
oneway growth_vel n_preg_visits,tabulate

ttest growth_vel ,by(bi_asph)
ttest growth_vel ,by(neo_sep)
ttest growth_vel ,by(hemo)
ttest growth_vel ,by(twin)
ttest growth_vel ,by(hypo)
ttest growth_vel ,by(u_fev)
ttest growth_vel ,by(fdpr_m)
ttest growth_vel ,by(fdpr_b)
ttest growth_vel ,by(conj)
ttest growth_vel ,by(bsi)
ttest growth_vel ,by(abjaun)
ttest growth_vel ,by(jaun)
ttest growth_vel ,by(pnm)
ttest growth_vel ,by(uri)
ttest growth_vel ,by(umb_sep)


**Bivar statistic graphs
graph twoway (lfitci growth_vel mage) (scatter growth_vel mage),xtitle("Maternal Age (years)") ytitle("Neonatal Growth Velocity, D1-28") title("Neonatal Growth Velocity vs. Maternal Age")
graph export graphs/vel_bivar_mage.eps,replace
graph twoway (lfitci growth_vel gage) (scatter growth_vel gage),xtitle("Gestational Age (weeks)") ytitle("Neonatal Growth Velocity, D1-28") title("Neonatal Growth Velocity vs. Gestational Age")

graph export graphs/vel_bivar_wt1.eps,replace
graph twoway (lfitci growth_vel dt_birth) (scatter growth_vel dt_birth),xtitle("Date of Birth") ytitle("Neonatal Growth Velocity, D1-28") title("Neonatal Growth Velocity vs. Date of Birth")
graph export graphs/vel_bivar_dtbirth.eps,replace

graph bar growth_vel,over(sex) b1title("Neonate Sex") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Sex")
graph export graphs/vel_bivar_sex.eps,replace
graph bar growth_vel ,over(m_edu4) b1title("Mother's Education") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Mother's Education")
graph export graphs/vel_bivar_m_edu.eps,replace
graph bar growth_vel ,over(f_edu4) b1title("Father's Education") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Mother's Education")
graph export graphs/vel_bivar_f_edu.eps,replace
graph bar growth_vel ,over(grav4)  b1title("Mother's Gravidity") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Mother's Gravidity")
graph export graphs/vel_bivar_grav.eps,replace
graph bar growth_vel ,over(para5)  b1title("Mother's Parity") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Mother's Parity")
graph export graphs/vel_bivar_para.eps,replace
graph bar growth_vel ,over(year_birth)  b1title("Year of Birth") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Year of Birth")
graph export graphs/vel_bivar_year.eps,replace
graph bar growth_vel ,over(n_preg_visits)  b1title("Number of Home Pregnancy Visits") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Number of Home Pregnancy Visits")
graph export graphs/vel_bivar_preg_v.eps,replace

graph bar growth_vel ,over(bi_asph)  b1title("Birth Asphyxia Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Birth Asphyxia Occurrence")
graph export graphs/vel_bivar_bi_asph.eps,replace
graph bar growth_vel ,over(neo_sep) b1title("Neonate Sepsis Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Neonate Sepsis Occurrence")
graph export graphs/vel_bivar_neo_sep.eps,replace
graph bar growth_vel ,over(hemo)  b1title("Hemorrhage Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Hemorrhage Occurrence")
graph export graphs/vel_bivar_hemo.eps,replace
graph bar growth_vel ,over(twin)  b1title("Twin Status") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Twin Status")
graph export graphs/vel_bivar_twin.eps,replace
graph bar growth_vel ,over(hypo)  b1title("Hypothermia Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Hypothermia Occurrence")
graph export graphs/vel_bivar_hypo.eps,replace
graph bar growth_vel ,over(u_fev) b1title("Unexplained Fever Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Unexplained Fever Occurrence")
graph export graphs/vel_bivar_u_fev.eps,replace
graph bar growth_vel ,over(fdpr_m)  b1title("Mother's Feeding Problem Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Mother's Feeding Problem Occurrence")
graph export graphs/vel_bivar_fdpr_m.eps,replace
graph bar growth_vel ,over(fdpr_b) b1title("Neonate Feeding Problem Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Neonate Feeding Problem Occurrence")
graph export graphs/vel_bivar_fdpr_b.eps,replace
graph bar growth_vel ,over(conj) b1title("Conjunctivitis Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Conjunctivitis Occurrence")
graph export graphs/vel_bivar_conj.eps,replace
graph bar growth_vel ,over(bsi) b1title("Bacterial Skin Infection Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Bacterial Skin Infection Occurrence")
graph export graphs/vel_bivar_bsi.eps,replace
graph bar growth_vel ,over(abjaun) b1title("Abonrmal Jaundice Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Abonrmal Jaundice Occurrence")
graph export graphs/vel_bivar_abjaun.eps,replace
graph bar growth_vel ,over(jaun) b1title("Jaundice Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Jaundice Occurrence")
graph export graphs/vel_bivar_jaun.eps,replace
graph bar growth_vel ,over(pnm) b1title("Pneumonia Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Pneumonia Occurrence")
graph export graphs/vel_bivar_pnm.eps,replace
graph bar growth_vel ,over(uri)  b1title("Upper Respiratory Infection Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Upper Respiratory Infection Occurrence")
graph export graphs/vel_bivar_uri.eps,replace
graph bar growth_vel ,over(umb_sep) b1title("Umbilical Sepsis Occurrence") ytitle("Mean Neonatal Growth Velocity, D1-28 (kg/g/day)") title("Neonatal Growth Velocity by Umbilical Sepsis Occurrence")
graph export graphs/vel_bivar_umb_sep.eps,replace

*Profile plots
collapse (mean) growth_vel,by(year_birth)
graph twoway line growth_vel year_birth,title("Growth vel over time") xtitle("Year of Birth") ytitle("Mean Growth Velocity (kg/g/day)")
graph export graphs/vel_profile_gvel_year.eps,replace


log close


