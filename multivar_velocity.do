clear all
capture log close
log using logs/multivar_velocity.log,text replace
use data/clean_data.dta

**********Analysis: Regressions***********
**Computing regression table

eststo gvel_regtable:reg growth_vel sex mage i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth,vce(robust)
eststo gvel_regtable_gage:reg growth_vel sex mage i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth gage,vce(robust)

*Check normality of residuals
predict r, resid
kdensity r, normal title("Regression Residuals Normality")
graph export graphs/vel_norm_resid.eps,replace

*Check VIF 
vif

*Imputation adjusted regression
mdesc

mi set mlong
mi register imputed mage gage sex m_edu4 f_edu4 para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth

mi impute chained (regress) year_birth mage gage (logit) sex prev_st hypo jaun conj fdpr_m fdpr_b pnm twin (mlogit) m_edu4 f_edu4 (ologit) para5 n_preg_visits,add(10) rseed(12345) augment

eststo mi_gvel_morb: mi estimate,nosmall post: reg growth_vel sex mage i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth morbidity_num,vce(robust)

eststo mi_gvel: mi estimate,nosmall post: reg growth_vel sex mage i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth,vce(robust)

eststo mi_exp_gvel: mi estimate,nosmall post: reg exp_growth_vel sex mage i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth,vce(robust)

eststo mi_gvel_gage: mi estimate,nosmall post: reg growth_vel sex mage i.m_edu4 i.f_edu4 i.para5 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth gage,vce(robust)

esttab gvel_regtable mi_gvel mi_exp_gvel gvel_regtable_gage mi_gvel_gage mi_gvel_morb using tables/velocity_table.rtf,se replace mtitle("Complete Case Regression" "Chained MI Regression" "Complete Case Regression w/Gest Age" "Complete Case Regression w/Gest Age") nonumbers eqlabels(none) collabels(none)



save data/imputed_velocity_data.dta, replace

*Check VIF for multicollinearity
mi convert flong
mivif


log close