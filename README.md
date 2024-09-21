# Short guide to Neonatal Weight Analysis Code:

* Data is present in nbwt1996_2021.xlsx, with incorrect neonatal sepsis info
* Correct neonatal sepsis info is present in birthweight.xlsx
* The "merge.do" file merges these and produces a "all_match_data.dta" file
* The "cleaning.do" file then cleans the merged data into a "clean_data.dta" file
* The "univar.do" file then does univariate analysis, and similarly "bivar.do" does bivariate analysis.
* Before running "multivar.do" for multivariate analysis, run "missing.do" to perform multiple imputation for missing data
* Then run "multivar.do"

* All graphs are saved in the "graphs" folder
* Some tables are in the "tables" folder
* Some tables are in the "docs" folder
* All data is stored in the "data" folder

This code used the following external packages:
* estout (ssc install estout)
* asdoc (ssc install asdoc)
* mivif (ssc install mivif)

Note: the "missing.do" file is extremely compute-intensive, and can take ~30 mins - 1 hour to run on a normal computer

