* Do-File 3/6
* SEARCH - HBNC Neonatal Weight Gain Analysis
* Written by Rayan Sud, June 2021
* Based on early-draft code by Rushina Cholera, July 2010


* univar.do
/* This file produces univariate summary statistic tables and graphs for presentation.
*/


clear all
use data/clean_data.dta
capture log close
log using logs/univar.log,text replace


*Here, we use the "asdoc" community Stata package, which writes summary tables into Word documents for easy output.

*First, we output all continuous variables of interest
asdoc sum gage wt1_g wt7_g wt15_g wt21_g wt28_g chwt_17 chwt_715 chwt_1521 chwt_2128 chwt_128 growth_vel exp_growth_vel,missing label save(docs/univar.doc) replace
*Next, we output all categorical variables of interest
asdoc tab1 female m_edu4 f_edu4 grav4 para5 institutional_delivery twin hrisk1 feed_b feed_m ba cong umbi conj unfev hemo hypo failu neosep pnm_ch bsi jaun boh tobause program_year CHW_visits isfad delay morbidity_num,missing label save(docs/univar.doc)

*Now, we generate summary statistic graphs.
*There are 2 types of variables - continuous and categorical. For continuous variables, we use histograms as a summary. For categorical, we use bar charts.
*These 2 for loops go over each variable, and generate the appropriate type of graph, then save the graph.

foreach cont_var in gage wt1_g wt7_g wt15_g wt21_g wt28_g chwt_17 chwt_715 chwt_1521 chwt_2128 chwt_128 growth_vel exp_growth_vel {
  *Using the variable label in the title and x-axis title
  local varlabel : variable label `cont_var'
  hist `cont_var', xtitle("`varlabel'") title("Histogram of Neonates by `varlabel'") normal
  graph export graphs/univar_`cont_var'.eps,replace
}

foreach cat_var in female institutional_delivery twin hrisk1 feed_b feed_m ba cong umbi conj unfev hemo hypo neosep pnm_ch bsi jaun boh tobause isfad delay  CHW_visits m_edu4 f_edu4 grav4 para5 morbidity_num {
  *Using the variable label in the title and x-axis title
  local varlabel : variable label `cat_var'
  graph bar (count), blabel(bar) over(`cat_var') b1title(`varlabel') ytitle("Number") title("Distribution of Neonates by `varlabel'")
  graph export graphs/univar_`cat_var'.eps,replace
}

log close
