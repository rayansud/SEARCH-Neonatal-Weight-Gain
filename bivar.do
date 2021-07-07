* Do-File 4/6
* SEARCH - HBNC Neonatal Weight Gain Analysis
* Written by Rayan Sud, June 2021
* Based on early-draft code by Rushina Cholera, July 2010


* bivar.do
/* This file produces bivariate analysis.
*/

*Here, as in the univariate case, we have for loops to perform analysis for each type of variable. For continuous predictor variables, we perform ordinary linear regression. For binary predictor variables, we perform independent two-tailed Student's t-tests. For categorical predictor variables with more then 2 categories, we use a one-way ANOVA test.

*Note: Here, we use all 3 possible outcome variables - change in weight, linear-formula growth velocity, and exponential-formula growth velocity.

clear all
use data/clean_data.dta

capture log close
log using logs/bivar.log, text replace

*For-loop for analysis of continuous variable
foreach cont_var in gage wt1_g year_birth {
  local varlabel : variable label `cont_var'
  *Using the estout package, we store the results of each regression.
  eststo chwt: regress chwt_128 `cont_var'
  eststo gr: regress growth_vel `cont_var'
  eststo exp: regress exp_growth_vel `cont_var'
  *Using the esttab command from the estout package, we output the results of the regressions. This can then be copied from Stata to Excel.
  esttab chwt gr exp

  *Now we generate graphs. For continuous variables, we put the linear fit line with a 95% confidence interval on top of a scatter plot of the outcome vs predictor variable.
  graph twoway (lfitci chwt_128 `cont_var') (scatter chwt_128 `cont_var'),xtitle("`varlabel'") ytitle("Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight vs. `varlabel'")
  graph export graphs/bivar_ch_`cont_var'.eps,replace

  graph twoway (lfitci growth_vel `cont_var') (scatter growth_vel `cont_var'),xtitle("`varlabel'") ytitle("(Linear) Neonate Growth Velocity (g/kg/day)") title("Change in Neonate Weight vs. `varlabel'")
  graph export graphs/bivar_gr_`cont_var'.eps,replace

  graph twoway (lfitci exp_growth_vel `cont_var') (scatter exp_growth_vel `cont_var'),xtitle("`varlabel'") ytitle("(Exponential) Neonate Growth Velocity (g/kg/day)") title("Change in Neonate Weight vs. `varlabel'")
  graph export graphs/bivar_exp_`cont_var'.eps,replace

}

foreach bi_var in female institutional_delivery twin hrisk1 feed_b feed_m ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause isfad delay {
  *For binary variables, we save a t-test, then output it to a .rtf file.
  local varlabel : variable label `bi_var'
  estpost ttest chwt_128,by(`bi_var')
  esttab . using tables/ch_bivar_`bi_var'.rtf,replace noobs cells("mu_1" "mu_2" "b(star)" "se(par)")

  estpost ttest growth_vel,by(`bi_var')
  esttab . using tables/gr_bivar_`bi_var'.rtf,replace noobs cells("mu_1" "mu_2" "b(star)" "se(par)")

  estpost ttest exp_growth_vel,by(`bi_var')
  esttab . using tables/exp_bivar_`bi_var'.rtf,replace noobs cells("mu_1" "mu_2" "b(star)" "se(par)")

  *Generating graphs: a bar graph for each binary variable and outcome variable.
  graph bar chwt_128,over(`bi_var') b1title("`varlabel'") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by `varlabel'")
  graph export graphs/bivar_ch_`bi_var'.eps,replace
  graph bar growth_vel,over(`bi_var') b1title("`varlabel'") ytitle("(Linear) Neonate Growth Velocity (g/kg/day)") title("(Linear) Neonate Growth Velocity by `varlabel'")
  graph export graphs/bivar_gr_`bi_var'.eps,replace
  graph bar exp_growth_vel,over(`bi_var') b1title("`varlabel'") ytitle("(Exponential) Neonate Growth Velocity (g/kg/day)") title("(Exponential) Neonate Growth Velocity by `varlabel'")
  graph export graphs/bivar_exp_`bi_var'.eps,replace
}



foreach multi_var in program_year CHW_visits m_edu4 f_edu4 grav4 para5 morbidity_num{
  *Here we use the asdoc package instead of estout for ANOVA. We save each ANOVA into a Word doc.
  local varlabel : variable label `multi_var'
  asdoc oneway chwt_128 `multi_var',tabulate noobs nofreq save(docs/bivar.doc)
  asdoc oneway growth_vel `multi_var',tabulate noobs nofreq save(docs/bivar.doc)
  asdoc oneway exp_growth_vel `multi_var',tabulate noobs nofreq save(docs/bivar.doc)

  *Bar graphs are generated for each outcome and predictor
  graph bar chwt_128,over(`multi_var') b1title("`varlabel'") ytitle("Mean Change in Neonate Weight, D1-28 (g)") title("Change in Neonate Weight by `varlabel'")
  graph export graphs/bivar_`multi_var'.eps,replace
  graph export graphs/bivar_ch_`multi_var'.eps,replace
  graph bar growth_vel,over(`multi_var') b1title("`varlabel'") ytitle("Neonate Growth Velocity (kg/g/day)") title("Neonate Growth Velocity by `varlabel'")
  graph export graphs/bivar_gr_`multi_var'.eps,replace
  graph bar exp_growth_vel,over(`multi_var') b1title("`varlabel'") ytitle("(Exp) Neonate Growth Velocity (kg/g/day)") title("(Exp) Neonate Growth Velocity by `varlabel'")
  graph export graphs/bivar_exp_`multi_var'.eps,replace
}


*Another form of bivariate analysis is generating profile plots for some chosen variables against outcomes. Rather than looking at a correlation between an outcome and predictor, we are looking at the change in the outcome variable over time.

*Profile plots
collapse (mean) chwt_128,by(year_birth)
graph twoway line chwt_128 year_birth,title("Change in Weight D1-28 over time") xtitle("Year of Birth") ytitle("Mean Change in Weight D1-28 (g)")
graph export graphs/profile_chwt128_year.eps,replace
clear
use data/clean_data.dta

collapse (mean) growth_vel,by(year_birth)
graph twoway line growth_vel year_birth,title("(Linear) Growth Velocity") xtitle("Year of Birth") ytitle("(Linear) Growth Velocity (g/kg/d)")
graph export graphs/profile_gvel_year.eps,replace
clear
use data/clean_data.dta

collapse (mean) exp_growth_vel,by(year_birth)
graph twoway line exp_growth_vel year_birth,title("(Exponential) Growth Velocity over time") xtitle("Year of Birth") ytitle("(Exponential) Growth Velocity (g/kg/d)")
graph export graphs/profile_expgvel_year.eps,replace
clear
use data/clean_data.dta

collapse (mean) wt1_g,by(year_birth)
graph twoway line wt1 year_birth,title("Birth Weight over Time") xtitle("Year of Birth") ytitle("Mean Birth Weight (g)")
graph export graphs/profile_wt1_year.eps,replace
clear
use data/clean_data.dta


*Another form of bivariate analysis is generating trajectory plots. This looks at how the weight of newborns changes over time. This is not ready for publication, since there is significant missing data in the measurements from day 7, 15, and 21. It may be better to produce these plots only for the newborns that have data on all measurement days. However, it may still be interesting.


*trajectory plots by day
gen pwt1 = wt1_g
gen pwt7 = wt7_g
gen pwt15 = wt15_g
gen pwt21 = wt21_g
gen pwt28 = wt28_g

*Reshaping data to allow for trajectory plot
reshape long pwt,i(id) j(day_wt)


*Relabel to get rid of special chars
label def m_edu4_l 0 "Illiterate" 1 "Literate to 4" 2 "5 to 10" 3 "11 and over"
label val m_edu4 m_edu4_l
label def f_edu_l 0 "Illiterate" 1 "Literate to 4" 2 "5 to 10" 3 "11 and over"
label val f_edu4 f_edu4_l

save data/panel-format.dta,replace

*Generating graphs, split by some categorical variables of interest
collapse (mean) pwt,by(day_wt female)
xtline pwt,overlay t(day_wt) i(female) title("Growth Trajectory by Sex") xtitle("Day of Measurement") ytitle("Mean Weight (g)") note("only using complete data")
graph export graphs/bivar_trajectory_sex.eps,replace
clear
use data/panel-format.dta

collapse (mean) pwt,by(day_wt m_edu4)
xtline pwt,overlay t(day_wt) i(m_edu4) title("Growth Trajectory by Mother Education") xtitle("Day of Measurement") ytitle("Mean Weight (g)") note("only using complete data")
graph export graphs/bivar_trajectory_m_edu.eps,replace
clear
use data/panel-format.dta

collapse (mean) pwt,by(day_wt f_edu4)
xtline pwt,overlay t(day_wt) i(f_edu4) title("Growth Trajectory by Father Education") xtitle("Day of Measurement") ytitle("Mean Weight (g)") note("only using complete data")
graph export graphs/bivar_trajectory_f_edu.eps,replace
clear
use data/panel-format.dta

collapse (mean) wt,by(day_wt CHW_visits)
xtline wt,overlay t(day_wt) i(CHW_visits) title("Growth Trajectory by No. CHW Visits") xtitle("Day of Measurement") ytitle("Mean Weight (g)") note("only using complete data")
graph export graphs/bivar_trajectory_preg_v.eps,replace

log close
