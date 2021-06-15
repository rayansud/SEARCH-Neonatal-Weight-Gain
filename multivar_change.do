**********Analysis: Regressions***********
clear all
use data/clean_data.dta
capture log close
log using logs/multivar.log, text replace

**Computing complete-case regression table

eststo cca:reg chwt_128 sex mage i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth wt1,vce(robust)
eststo cca_gage:reg chwt_128 sex mage i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth wt1 gage,vce(robust)



*Check normality of residuals
predict r, resid
kdensity r, normal title("Regression Residuals Normality")
graph export graphs/norm_resid.eps,replace

*Check VIF 
vif

*****Imputation adjusted regression
mdesc

mi set mlong
mi register imputed chwt_128 mage gage sex m_edu4 f_edu4 para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin wt1 n_preg_visits year_birth

mi impute chained (regress) chwt_128 year_birth wt1 mage gage (logit) sex prev_st hypo jaun conj fdpr_m fdpr_b pnm twin (mlogit) m_edu4 f_edu4 (ologit) para5 n_preg_visits,add(20) rseed(12345) augment

eststo mi_o: mi estimate,nosmall post: reg chwt_128 sex mage wt1 i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth,vce(robust)

eststo mi_gage: mi estimate,nosmall post: reg chwt_128 sex mage  gage wt1 i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth,vce(robust)

eststo mi_morb: mi estimate,nosmall post: reg chwt_128 sex mage  gage wt1 i.m_edu4 i.f_edu4 i.para5 morbidity_num n_preg_visits year_birth,vce(robust)

esttab cca mi_o cca_gage mi_gage mi_morb using tables/change_table.rtf


save data/imputed_change_data.dta, replace

quietly mi estimate,nosmall: reg chwt_128 sex mage wt1 i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth,vce(robust)

*Check VIF for multicollinearity
mi convert flong
mivif

**********Close***********
log close