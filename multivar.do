* Do-File 6/6
* SEARCH - HBNC Neonatal Weight Gain Analysis
* Written by Rayan Sud, June 2021
* Based on early-draft code by Rushina Cholera, July 2010


* multivar.do
/* This file performs multivariate analysis on the imputed data.
Here, we have several sets of analysis to perform. First, we have 3 outcome variables (change in weight, linear GV, exponntial GV), so all analysis is repeated 3 times.
Next, we have performed multiple imputation, so all analysis is repeated using the imputed data as well as the complete-case-analysis data (simply dropping all missing data) to ensure that the results do not differ too much.
Finally, there are some meaningful choices to be made in the model - whether or not to include gestational age, which may be a collider variable (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3243938/) and whether to combine all comorbidities into a single "number of comorbidities" variable, since there are many of them and they do not appear very significant.
Each of these options is analysed and presented for comparison.
*/
clear all
use data/imputed_data.dta
capture log close
log using logs/multivar.log, text replace


*Computing complete-case regression table for change-in-weight outcome (note: mi xeq 0 is a command that uses the original data, without imputation)
* We store the results of the regression again using the "estout" package
mi xeq 0: eststo cca:reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

*As a little extra check on the regression, we check normality of residuals using a kernel density plot with a normal curve overlaid.
mi xeq 0: predict r, resid
mi xeq 0: kdensity r, normal title("Regression Residuals Normality")
graph export graphs/norm_resid.eps,replace

*Computing complete-case regression table for change-in-weight outcome, with gestational age included
mi xeq 0: eststo cca_gage:reg chwt_128 gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
*Computing complete-case regression table for change-in-weight outcome, combining comorbidities
mi xeq 0: eststo cca_morb:reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

*Computing complete-case regression table for linear-GV outcome
mi xeq 0: eststo gr_cca:reg growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
*Computing complete-case regression table for linear-GV outcome, including gestational age
mi xeq 0: eststo gr_cca_gage:reg growth_vel gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
*Computing complete-case regression table for linear-GV outcome, combining comorbidities
mi xeq 0: eststo gr_cca_morb:reg growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

*Computing complete-case regression table for exponential-GV outcome
mi xeq 0: eststo exp_cca:reg exp_growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

*Computing complete-case regression table for exponential-GV outcome, including gestational age
mi xeq 0: eststo exp_cca_gage:reg exp_growth_vel gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
*Computing complete-case regression table for exponential-GV outcome, combining comorbidities
mi xeq 0: eststo exp_cca_morb:reg exp_growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)



*Next, we repeat the same analysis, but we remove the "mi xeq 0" prefix. That means that we are now using the multiple-imputation adjusted data.

*MI, change-weight
eststo mi_o: mi estimate,nosmall post: reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
*MI, change-weight with gest_age
eststo mi_gage: mi estimate,nosmall post: reg chwt_128 gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
*MI, change-weight with combined comorbs
eststo mi_morb: mi estimate,nosmall post: reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

*Here, we use the esttab command from the "estout" package to turn the regression data into a single clean regression table in an .rtf file.
esttab cca mi_o cca_gage mi_gage cca_morb mi_morb using tables/change_table.rtf,replace se ar2


*Similar analysis is repeated below for the other 2 outcome variables.
eststo mi_o: mi estimate,nosmall post: reg growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_gage: mi estimate,nosmall post: reg growth_vel gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_morb: mi estimate,nosmall post: reg growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

esttab gr_cca mi_o gr_cca_gage mi_gage gr_cca_morb mi_morb using tables/gr_table.rtf,replace  se ar2


eststo mi_o: mi estimate,nosmall post: reg exp_growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_gage: mi estimate,nosmall post: reg exp_growth_vel gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_morb: mi estimate,nosmall post: reg exp_growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

esttab exp_cca mi_o exp_cca_gage mi_gage exp_cca_morb mi_morb using tables/exp_table.rtf,replace se ar2

*The regression is repeated once more, so that the "mivif" command can be used to check the data for multicollinearity using Variance Inflation Factors.

clear
use data/imputed_data.dta

quietly mi estimate,nosmall: reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

*Check VIF for multicollinearity
mi convert flong
mivif


**********Close***********
log close
