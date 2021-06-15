clear
use data/imputed_change_data.dta
capture log close
log uisng logs/panel.log,text replace
**********Analysis: Experimental Panel Data Analysis***********

****Turning to a long dataset shape
mi reshape long wt,i(srno) j(day_wt)
*Setting as panel data
mi xtset srno day_wt

**********Analysis: Experimental GEE Analysis***********

**GEE model
**Repeating usual regression, now with day_of_measurement as a variable & cluster standard errors
mi estimate,nosmall:reg wt sex mage gage d_m_edu42 d_m_edu43 d_m_edu44  d_f_edu42 d_f_edu43 d_f_edu44 dpara52 dpara53 dpara54 dpara55 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin wt1 n_preg_visits year_birth i.day_wt,vce(cluster srno)

*Running estimate of GEE with robust standard errors
mi estimate,nosmall:xtgee wt sex mage gage d_m_edu42 d_m_edu43 d_m_edu44  d_f_edu42 d_f_edu43 d_f_edu44 dpara52 dpara53 dpara54 dpara55 prev_st hypo conj hemo fdpr_m fdpr_b jaun pnm twin n_preg_visits year_birth i.day_wt,vce(robust)

log close