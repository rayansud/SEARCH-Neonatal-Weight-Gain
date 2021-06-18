clear all
use data/clean_data.dta

capture log close
log using "logs/missing.log", text replace

*****Multiply impute all missing data
mdesc

mi set mlong

mi register imputed grav4 m_edu4 f_edu4 institutional_delivery female gage

mi register regular pnm_ch neosep twins ba bwt hrisk1 feed_b feed_m cong umbi conj jaun unfev hemo hypo bsi wt28_g wt1_g boh para tobause delivery_date CHW_visits isfad delay chwt_128 growth_vel exp_growth_vel morbidity_num

mi impute chained (regress) gage (logit) institutional_delivery female (pmm, knn(10)) grav4 m_edu4 f_edu4 = twins ba bwt hrisk1 isfad delay neosep feed_b feed_m cong umbi conj jaun unfev hemo hypo bsi wt28_g wt1_g boh para tobause delivery_date CHW_visits,add(25) rseed(12345) augment

save data/imputed_data.dta
log close
