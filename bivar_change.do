clear all
use data/clean_data.dta

capture log close
log using logs/bivar_change.log, text replace


******Bivariate correlation checks****
regress chwt_128 mage
regress chwt_128 gage
regress chwt_128 wt1
regress chwt_128 dt_birth

ttest chwt_128,by(sex)
oneway chwt_128 m_edu4,tabulate
oneway chwt_128 f_edu4,tabulate
oneway chwt_128 grav4,tabulate
oneway chwt_128 para5,tabulate
oneway chwt_128 year_birth,tabulate
oneway chwt_128 n_preg_visits,tabulate

estpost ttest chwt_128 ,by(bi_asph)
esttab . using tables/ttest_chwt_bisaph.rtf,replace cells("N_1 mu_1 ."  "N_2 mu_2 ." ". b(star) & se(par) p") incelldelimiter(<br>)

ttest chwt_128 ,by(neo_sep)
ttest chwt_128 ,by(hemo)
ttest chwt_128 ,by(twin)
ttest chwt_128 ,by(hypo)
ttest chwt_128 ,by(u_fev)
ttest chwt_128 ,by(fdpr_m)
ttest chwt_128 ,by(fdpr_b)
ttest chwt_128 ,by(conj)
ttest chwt_128 ,by(bsi)
ttest chwt_128 ,by(abjaun)
ttest chwt_128 ,by(jaun)
ttest chwt_128 ,by(pnm)
ttest chwt_128 ,by(uri)
ttest chwt_128 ,by(umb_sep)


**Bivar statistic graphs
graph twoway (lfitci chwt_128 mage) (scatter chwt_128 mage),xtitle("Maternal Age (years)") ytitle("Change in Neonate Weight, D1-28") title("Change in Neonate Weight vs. Maternal Age")
graph export graphs/bivar_mage.eps,replace
graph twoway (lfitci chwt_128 gage) (scatter chwt_128 gage),xtitle("Gestational Age (weeks)") ytitle("Change in Neonate Weight, D1-28") title("Change in Neonate Weight vs. Gestational Age")
graph export graphs/bivar_gage.eps,replace
graph twoway (lfitci chwt_128 wt1_g) (scatter chwt_128 wt1_g),xtitle("Weight at Day 1 (g)") ytitle("Change in Neonate Weight, D1-28") title("Change in Neonate Weight vs. Neonate at Day 1")
graph export graphs/bivar_wt1.eps,replace
graph twoway (lfitci chwt_128 dt_birth) (scatter chwt_128 dt_birth),xtitle("Date of Birth") ytitle("Change in Neonate Weight, D1-28") title("Change in Neonate Weight vs. Date of Birth")
graph export graphs/bivar_dtbirth.eps,replace

graph bar chwt_128,over(sex) b1title("Neonate Sex") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Sex")
graph export graphs/bivar_sex.eps,replace
graph bar chwt_128 ,over(m_edu4) b1title("Mother's Education") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Mother's Education")
graph export graphs/bivar_m_edu.eps,replace
graph bar chwt_128 ,over(f_edu4) b1title("Father's Education") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Mother's Education")
graph export graphs/bivar_f_edu.eps,replace
graph bar chwt_128 ,over(grav4)  b1title("Mother's Gravidity") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Mother's Gravidity")
graph export graphs/bivar_grav.eps,replace
graph bar chwt_128 ,over(para5)  b1title("Mother's Parity") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Mother's Parity")
graph export graphs/bivar_para.eps,replace
graph bar chwt_128 ,over(year_birth)  b1title("Year of Birth") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Year of Birth")
graph export graphs/bivar_year.eps,replace
graph bar chwt_128 ,over(n_preg_visits)  b1title("Number of Home Pregnancy Visits") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Number of Home Pregnancy Visits")
graph export graphs/bivar_preg_v.eps,replace

graph bar chwt_128 ,over(bi_asph)  b1title("Birth Asphyxia Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Birth Asphyxia Occurrence")
graph export graphs/bivar_bi_asph.eps,replace
graph bar chwt_128 ,over(neo_sep) b1title("Neonate Sepsis Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Neonate Sepsis Occurrence")
graph export graphs/bivar_neo_sep.eps,replace
graph bar chwt_128 ,over(hemo)  b1title("Hemorrhage Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Hemorrhage Occurrence")
graph export graphs/bivar_hemo.eps,replace
graph bar chwt_128 ,over(twin)  b1title("Twin Status") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Twin Status")
graph export graphs/bivar_twin.eps,replace
graph bar chwt_128 ,over(hypo)  b1title("Hypothermia Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Hypothermia Occurrence")
graph export graphs/bivar_hypo.eps,replace
graph bar chwt_128 ,over(u_fev) b1title("Unexplained Fever Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Unexplained Fever Occurrence")
graph export graphs/bivar_u_fev.eps,replace
graph bar chwt_128 ,over(fdpr_m)  b1title("Mother's Feeding Problem Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Mother's Feeding Problem Occurrence")
graph export graphs/bivar_fdpr_m.eps,replace
graph bar chwt_128 ,over(fdpr_b) b1title("Neonate Feeding Problem Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Neonate Feeding Problem Occurrence")
graph export graphs/bivar_fdpr_b.eps,replace
graph bar chwt_128 ,over(conj) b1title("Conjunctivitis Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Conjunctivitis Occurrence")
graph export graphs/bivar_conj.eps,replace
graph bar chwt_128 ,over(bsi) b1title("Bacterial Skin Infection Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Bacterial Skin Infection Occurrence")
graph export graphs/bivar_bsi.eps,replace
graph bar chwt_128 ,over(abjaun) b1title("Abonrmal Jaundice Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Abonrmal Jaundice Occurrence")
graph export graphs/bivar_abjaun.eps,replace
graph bar chwt_128 ,over(jaun) b1title("Jaundice Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Jaundice Occurrence")
graph export graphs/bivar_jaun.eps,replace
graph bar chwt_128 ,over(pnm) b1title("Pneumonia Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Pneumonia Occurrence")
graph export graphs/bivar_pnm.eps,replace
graph bar chwt_128 ,over(uri)  b1title("Upper Respiratory Infection Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Upper Respiratory Infection Occurrence")
graph export graphs/bivar_uri.eps,replace
graph bar chwt_128 ,over(umb_sep) b1title("Umbilical Sepsis Occurrence") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by Umbilical Sepsis Occurrence")
graph export graphs/bivar_umb_sep.eps,replace


*Profile plots
collapse (mean) chwt_128,by(year_birth)
graph twoway line chwt_128 year_birth,title("Change in Weight D1-28 over time") xtitle("Year of Birth") ytitle("Mean Change in Weight D1-28 (g)")
graph export graphs/profile_chwt128_year.eps,replace
clear
use data/clean_data.dta

collapse (mean) wt1,by(year_birth)
graph twoway line wt1 year_birth,title("Birth Weight over time") xtitle("Year of Birth") ytitle("Mean Birth Weight (kg)")
graph export graphs/profile_wt1_year.eps,replace
clear
use data/clean_data.dta


*Profile plots with by day

reshape long wt,i(srno) j(day_wt)
*Setting as panel data
xtset srno day_wt


*Relabel to get rid of special chars
label def m_edu4_l 0 "Illiterate" 1 "Literate to 4" 2 "5 to 10" 3 "11 and over"
label val m_edu4 m_edu4_l
label def f_edu_l 0 "Illiterate" 1 "Literate to 4" 2 "5 to 10" 3 "11 and over"
label val f_edu4 f_edu4_l

save data/panel-format.dta,replace

collapse (mean) wt,by(day_wt sex)
xtline wt,overlay t(day_wt) i(sex) title("Growth Trajectory by Sex") xtitle("Day of Measurement") ytitle("Mean Weight")
graph export graphs/bivar_trajectory_sex.eps,replace
clear
use data/panel-format.dta

collapse (mean) wt,by(day_wt m_edu4)
xtline wt,overlay t(day_wt) i(m_edu4) title("Growth Trajectory by Mother Education") xtitle("Day of Measurement") ytitle("Mean Weight (kg)")
graph export graphs/bivar_trajectory_m_edu.eps,replace
clear
use data/panel-format.dta

collapse (mean) wt,by(day_wt f_edu4)
xtline wt,overlay t(day_wt) i(f_edu4) title("Growth Trajectory by Father Education") xtitle("Day of Measurement") ytitle("Mean Weight (kg)")
graph export graphs/bivar_trajectory_f_edu.eps,replace
clear
use data/panel-format.dta

collapse (mean) wt,by(day_wt n_preg_visits)
xtline wt,overlay t(day_wt) i(n_preg_visits) title("Growth Trajectory by No. Pregnancy Visits") xtitle("Day of Measurement") ytitle("Mean Weight (kg)")
graph export graphs/bivar_trajectory_preg_v.eps,replace

log close


