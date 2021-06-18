**********Analysis: Regressions***********
clear all
use data/imputed_data.dta
capture log close
log using logs/multivar.log, text replace

**Computing complete-case regression table
mi xeq 0: eststo cca:reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
mi xeq 0: eststo cca_gage:reg chwt_128 gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
mi xeq 0: eststo cca_morb:reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

*Check normality of residuals
mi xeq 0: predict r, resid
mi xeq 0: kdensity r, normal title("Regression Residuals Normality")
graph export graphs/norm_resid.eps,replace


mi xeq 0: eststo gr_cca:reg growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
mi xeq 0: eststo gr_cca_gage:reg growth_vel gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
mi xeq 0: eststo gr_cca_morb:reg growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)


mi xeq 0: eststo exp_cca:reg exp_growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
mi xeq 0: eststo exp_cca_gage:reg exp_growth_vel gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
mi xeq 0: eststo exp_cca_morb:reg exp_growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)


*****Imputation adjusted regression
eststo mi_o: mi estimate,nosmall post: reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_gage: mi estimate,nosmall post: reg chwt_128 gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_morb: mi estimate,nosmall post: reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

esttab cca mi_o cca_gage mi_gage cca_morb mi_morb using tables/change_table.rtf,replace

eststo mi_o: mi estimate,nosmall post: reg growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_gage: mi estimate,nosmall post: reg growth_vel gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_morb: mi estimate,nosmall post: reg growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

esttab gr_cca mi_o gr_cca_gage mi_gage gr_cca_morb mi_morb using tables/gr_table.rtf,replace


eststo mi_o: mi estimate,nosmall post: reg exp_growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_gage: mi estimate,nosmall post: reg exp_growth_vel gage wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)
eststo mi_morb: mi estimate,nosmall post: reg exp_growth_vel wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay morbidity_num tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

esttab exp_cca mi_o exp_cca_gage mi_gage exp_cca_morb mi_morb using tables/exp_table.rtf,replace

clear
use data/imputed_data.dta

quietly mi estimate,nosmall: reg chwt_128 wt1_g year_birth female institutional_delivery twin hrisk1 feed_b feed_m isfad delay ba cong umbi conj unfev hemo hypo neo pnm_ch bsi jaun boh tobause i.CHW_visits i.m_edu4 i.f_edu4 i.para5,vce(robust)

*Check VIF for multicollinearity
mi convert flong
mivif


**********Close***********
log close

!zip -r zips/tables.zip tables/*.rtf
