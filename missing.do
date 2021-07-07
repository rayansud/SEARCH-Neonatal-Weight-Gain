* Do-File 5/6
* SEARCH - HBNC Neonatal Weight Gain Analysis
* Written by Rayan Sud, June 2021
* Based on early-draft code by Rushina Cholera, July 2010


* missing.do
/* This file performs multiple imputation on missing data, to prepare for multivariate analysis.
*/

*Here, as in the univariate case, we have for loops to perform analysis for each type of variable. For continuous predictor variables, we perform ordinary linear regression. For binary predictor variables, we perform independent two-tailed Student's t-tests. For categorical predictor variables with more then 2 categories, we use a one-way ANOVA test.

*Note: Here, we use all 3 possible outcome variables - change in weight, linear-formula growth velocity, and exponential-formula growth velocity.


clear all
use data/clean_data.dta

capture log close
log using "logs/missing.log", text replace

*First, we use the "mdesc" package to produce a table of all missing data
mdesc

*Stata requires us to "mi set" data in a format, and the usual convenient format is "mlong"
mi set mlong

*Stata requires the "registration" of variables. First, we "register" the variables which have missing data, and need to be imputed
mi register imputed grav4 m_edu4 f_edu4 institutional_delivery female gage
*Next, we "register" the "regular" variables which do NOT have missing data, and which are used to help impute the missing data.
mi register regular pnm_ch neosep twins ba bwt hrisk1  feed_b feed_m cong umbi conj jaun unfev hemo hypo bsi wt28_g wt1_g boh para tobause delivery_date CHW_visits isfad delay chwt_128 growth_vel exp_growth_vel morbidity_num

*This is the main Stata imputation command. We are using "chained" imputation. This means that each missing variable is imputed using a regression that is appropriate to its type. For continuous variables, we use ordinary linear regression. For binary variables, we use logistic regression. Finally for categorical variables, although we would usually use ordinal logistic or multinomial logistic regression, there are issues in the convergence of the imputation, so instead we use a method called "predictive mean matching". (https://www.stata.com/manuals/mimiimputepmm.pdf) Basically, this is a form of "nearest-neighbours" matching. The option specified (knn(10)) says to use the 10 nearest neighbors in mean-matching.

*The "=" sign is used to separate the missing variables from the regular variables. The "add(25)" options says to use 25 imputations, which is a generally good number used in the literature. The "rseed(12345)" option sets the random-generator seed, which allows reproduction of results, but it is not necessary. The "augment" option adds a small amount of low-weightage noise data, to prevent a computational issue called "perfect prediction".
mi impute chained (regress) gage (logit) institutional_delivery female (pmm, knn(10)) grav4 m_edu4 f_edu4 = twins ba bwt hrisk1 isfad delay neosep feed_b feed_m cong umbi conj jaun unfev hemo hypo bsi wt28_g wt1_g boh para tobause delivery_date CHW_visits,add(25) rseed(12345) augment

save data/imputed_data.dta
log close
