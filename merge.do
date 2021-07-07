* Do-File 1/6
* SEARCH - HBNC Neonatal Weight Gain Analysis
* Written by Rayan Sud, June 2021
* Based on early-draft code by Rushina Cholera, July 2010


* merge.do
/* The master datasets for analysis are initially available in 2 separate files. In the Excel file birthweight.xlsx, the master records of all newborns with  serial numbers, DOBs, and neonatal sepsis variables are found. In the Excel file nbwt1996_2021.xlsx, data on all remaining variables is found, along with (incorrect) neonatal sepsis data. The purpose of this merge.do file is to combine the two datasets, using birthweight.xlsx as the master file. [Note: For the year 2019-20 only, nbwt1996_2021.xlsx is the master data.]
In addition, the data used for analysis is to only include 'complete' analysis years - 1996-2019. For this purpose, a variable using the "analysis year" (April - March) is generated.
In the birthweight.xlsx file, data is only present upto 2019, and so data from the year 1995-96 is dropped.
In the nbwt1996_2021.xlsx file, data is present upto 2021. Data from 1995-96 is dropped. Then, for the purpos of merging onto the master birthweight.xlsx, data from 2019-20 is temporarily dropped. Data from 2020-21 is incomplete and so dropped permanently. Data is merged on the master birthweight.xlsx, and then data from 2019-20 from nbwt1996_2021.xlsx is added back in.
In both files, the id variable is a combination of the serial number and date of birth (srno_DOB). This is the unique ID for merging.
*/


clear all
import excel data/birthweight.xlsx,firstrow case(lower)

* The program_year variable is generated, checking a newborns DOB in the range of April 1 to March 31.
gen delivery_date = date4
gen program_year = "None"
replace program_year = "1995-96" if delivery_date >= date("01Apr1995","DMY") & delivery_date < date("01Apr1996","DMY")
replace program_year = "1996-97" if delivery_date >= date("01Apr1996","DMY") & delivery_date < date("01Apr1997","DMY")
replace program_year = "1997-98" if delivery_date >= date("01Apr1997","DMY") & delivery_date < date("01Apr1998","DMY")
replace program_year = "1998-99" if delivery_date >= date("01Apr1998","DMY") & delivery_date < date("01Apr1999","DMY")
replace program_year = "1999-00" if delivery_date >= date("01Apr1999","DMY") & delivery_date < date("01Apr2000","DMY")
replace program_year = "2000-01" if delivery_date >= date("01Apr2000","DMY") & delivery_date < date("01Apr2001","DMY")
replace program_year = "2001-02" if delivery_date >= date("01Apr2001","DMY") & delivery_date < date("01Apr2002","DMY")
replace program_year = "2002-03" if delivery_date >= date("01Apr2002","DMY") & delivery_date < date("01Apr2003","DMY")
replace program_year = "2003-04" if delivery_date >= date("01Apr2003","DMY") & delivery_date < date("01Apr2004","DMY")
replace program_year = "2004-05" if delivery_date >= date("01Apr2004","DMY") & delivery_date < date("01Apr2005","DMY")
replace program_year = "2005-06" if delivery_date >= date("01Apr2005","DMY") & delivery_date < date("01Apr2006","DMY")
replace program_year = "2006-07" if delivery_date >= date("01Apr2006","DMY") & delivery_date < date("01Apr2007","DMY")
replace program_year = "2007-08" if delivery_date >= date("01Apr2007","DMY") & delivery_date < date("01Apr2008","DMY")
replace program_year = "2008-09" if delivery_date >= date("01Apr2008","DMY") & delivery_date < date("01Apr2009","DMY")
replace program_year = "2009-10" if delivery_date >= date("01Apr2009","DMY") & delivery_date < date("01Apr2010","DMY")
replace program_year = "2010-11" if delivery_date >= date("01Apr2010","DMY") & delivery_date < date("01Apr2011","DMY")
replace program_year = "2011-12" if delivery_date >= date("01Apr2011","DMY") & delivery_date < date("01Apr2012","DMY")
replace program_year = "2012-13" if delivery_date >= date("01Apr2012","DMY") & delivery_date < date("01Apr2013","DMY")
replace program_year = "2013-14" if delivery_date >= date("01Apr2013","DMY") & delivery_date < date("01Apr2014","DMY")
replace program_year = "2014-15" if delivery_date >= date("01Apr2014","DMY") & delivery_date < date("01Apr2015","DMY")
replace program_year = "2015-16" if delivery_date >= date("01Apr2015","DMY") & delivery_date < date("01Apr2016","DMY")
replace program_year = "2016-17" if delivery_date >= date("01Apr2016","DMY") & delivery_date < date("01Apr2017","DMY")
replace program_year = "2017-18" if delivery_date >= date("01Apr2017","DMY") & delivery_date < date("01Apr2018","DMY")
replace program_year = "2018-19" if delivery_date >= date("01Apr2018","DMY") & delivery_date < date("01Apr2019","DMY")
replace program_year = "2019-20" if delivery_date >= date("01Apr2019","DMY") & delivery_date < date("01Apr2020","DMY")
replace program_year = "2020-21" if delivery_date >= date("01Apr2020","DMY") & delivery_date < date("01Apr2021","DMY")
label var program_year "Program Year of Birth, from April - March"

* 1996-96 year dropped
drop if program_year == "1995-96"

* Duplicates in this dataset are dropped
duplicates drop id,force

* The data from birthweight.xlsx is saved to sepsis_master.dta
save data/sepsis_master,replace

clear


import excel data/nbwt1996_2021.xlsx,firstrow case(lower)
gen delivery_date = date4

label var delivery_date "Delivery Date"
* Program year is generated for the nbwt1996_2021.xlsx file.
gen program_year = "None"
replace program_year = "1995-96" if delivery_date >= date("01Apr1995","DMY") & delivery_date < date("01Apr1996","DMY")
replace program_year = "1996-97" if delivery_date >= date("01Apr1996","DMY") & delivery_date < date("01Apr1997","DMY")
replace program_year = "1997-98" if delivery_date >= date("01Apr1997","DMY") & delivery_date < date("01Apr1998","DMY")
replace program_year = "1998-99" if delivery_date >= date("01Apr1998","DMY") & delivery_date < date("01Apr1999","DMY")
replace program_year = "1999-00" if delivery_date >= date("01Apr1999","DMY") & delivery_date < date("01Apr2000","DMY")
replace program_year = "2000-01" if delivery_date >= date("01Apr2000","DMY") & delivery_date < date("01Apr2001","DMY")
replace program_year = "2001-02" if delivery_date >= date("01Apr2001","DMY") & delivery_date < date("01Apr2002","DMY")
replace program_year = "2002-03" if delivery_date >= date("01Apr2002","DMY") & delivery_date < date("01Apr2003","DMY")
replace program_year = "2003-04" if delivery_date >= date("01Apr2003","DMY") & delivery_date < date("01Apr2004","DMY")
replace program_year = "2004-05" if delivery_date >= date("01Apr2004","DMY") & delivery_date < date("01Apr2005","DMY")
replace program_year = "2005-06" if delivery_date >= date("01Apr2005","DMY") & delivery_date < date("01Apr2006","DMY")
replace program_year = "2006-07" if delivery_date >= date("01Apr2006","DMY") & delivery_date < date("01Apr2007","DMY")
replace program_year = "2007-08" if delivery_date >= date("01Apr2007","DMY") & delivery_date < date("01Apr2008","DMY")
replace program_year = "2008-09" if delivery_date >= date("01Apr2008","DMY") & delivery_date < date("01Apr2009","DMY")
replace program_year = "2009-10" if delivery_date >= date("01Apr2009","DMY") & delivery_date < date("01Apr2010","DMY")
replace program_year = "2010-11" if delivery_date >= date("01Apr2010","DMY") & delivery_date < date("01Apr2011","DMY")
replace program_year = "2011-12" if delivery_date >= date("01Apr2011","DMY") & delivery_date < date("01Apr2012","DMY")
replace program_year = "2012-13" if delivery_date >= date("01Apr2012","DMY") & delivery_date < date("01Apr2013","DMY")
replace program_year = "2013-14" if delivery_date >= date("01Apr2013","DMY") & delivery_date < date("01Apr2014","DMY")
replace program_year = "2014-15" if delivery_date >= date("01Apr2014","DMY") & delivery_date < date("01Apr2015","DMY")
replace program_year = "2015-16" if delivery_date >= date("01Apr2015","DMY") & delivery_date < date("01Apr2016","DMY")
replace program_year = "2016-17" if delivery_date >= date("01Apr2016","DMY") & delivery_date < date("01Apr2017","DMY")
replace program_year = "2017-18" if delivery_date >= date("01Apr2017","DMY") & delivery_date < date("01Apr2018","DMY")
replace program_year = "2018-19" if delivery_date >= date("01Apr2018","DMY") & delivery_date < date("01Apr2019","DMY")
replace program_year = "2019-20" if delivery_date >= date("01Apr2019","DMY") & delivery_date < date("01Apr2020","DMY")
replace program_year = "2020-21" if delivery_date >= date("01Apr2020","DMY") & delivery_date < date("01Apr2021","DMY")
label var program_year "Program Year of Birth, from April - March"

drop if program_year == "2019-20" | program_year == "2020-21" | program_year == "1995-96"
duplicates drop id,force

*Data is saved to new_id.dta
save data/new_id,replace

clear

*Merging of the datasets
use data/sepsis_master
merge 1:1 id using data/new_id,force
*Unmerged data is dropped
drop if _merge==2
drop _merge

save data/new_data

clear
*The entire process is repeated on nbwt1996_2021.xlsx just for 2019-20 data.
import excel data/nbwt1996_2021.xlsx,firstrow case(lower)
gen delivery_date = date4

label var delivery_date "Delivery Date"

gen program_year = "None"

replace program_year = "1995-96" if delivery_date >= date("01Apr1995","DMY") & delivery_date < date("01Apr1996","DMY")
replace program_year = "1996-97" if delivery_date >= date("01Apr1996","DMY") & delivery_date < date("01Apr1997","DMY")
replace program_year = "1997-98" if delivery_date >= date("01Apr1997","DMY") & delivery_date < date("01Apr1998","DMY")
replace program_year = "1998-99" if delivery_date >= date("01Apr1998","DMY") & delivery_date < date("01Apr1999","DMY")
replace program_year = "1999-00" if delivery_date >= date("01Apr1999","DMY") & delivery_date < date("01Apr2000","DMY")
replace program_year = "2000-01" if delivery_date >= date("01Apr2000","DMY") & delivery_date < date("01Apr2001","DMY")
replace program_year = "2001-02" if delivery_date >= date("01Apr2001","DMY") & delivery_date < date("01Apr2002","DMY")
replace program_year = "2002-03" if delivery_date >= date("01Apr2002","DMY") & delivery_date < date("01Apr2003","DMY")
replace program_year = "2003-04" if delivery_date >= date("01Apr2003","DMY") & delivery_date < date("01Apr2004","DMY")
replace program_year = "2004-05" if delivery_date >= date("01Apr2004","DMY") & delivery_date < date("01Apr2005","DMY")
replace program_year = "2005-06" if delivery_date >= date("01Apr2005","DMY") & delivery_date < date("01Apr2006","DMY")
replace program_year = "2006-07" if delivery_date >= date("01Apr2006","DMY") & delivery_date < date("01Apr2007","DMY")
replace program_year = "2007-08" if delivery_date >= date("01Apr2007","DMY") & delivery_date < date("01Apr2008","DMY")
replace program_year = "2008-09" if delivery_date >= date("01Apr2008","DMY") & delivery_date < date("01Apr2009","DMY")
replace program_year = "2009-10" if delivery_date >= date("01Apr2009","DMY") & delivery_date < date("01Apr2010","DMY")
replace program_year = "2010-11" if delivery_date >= date("01Apr2010","DMY") & delivery_date < date("01Apr2011","DMY")
replace program_year = "2011-12" if delivery_date >= date("01Apr2011","DMY") & delivery_date < date("01Apr2012","DMY")
replace program_year = "2012-13" if delivery_date >= date("01Apr2012","DMY") & delivery_date < date("01Apr2013","DMY")
replace program_year = "2013-14" if delivery_date >= date("01Apr2013","DMY") & delivery_date < date("01Apr2014","DMY")
replace program_year = "2014-15" if delivery_date >= date("01Apr2014","DMY") & delivery_date < date("01Apr2015","DMY")
replace program_year = "2015-16" if delivery_date >= date("01Apr2015","DMY") & delivery_date < date("01Apr2016","DMY")
replace program_year = "2016-17" if delivery_date >= date("01Apr2016","DMY") & delivery_date < date("01Apr2017","DMY")
replace program_year = "2017-18" if delivery_date >= date("01Apr2017","DMY") & delivery_date < date("01Apr2018","DMY")
replace program_year = "2018-19" if delivery_date >= date("01Apr2018","DMY") & delivery_date < date("01Apr2019","DMY")
replace program_year = "2019-20" if delivery_date >= date("01Apr2019","DMY") & delivery_date < date("01Apr2020","DMY")
replace program_year = "2020-21" if delivery_date >= date("01Apr2020","DMY") & delivery_date < date("01Apr2021","DMY")
label var program_year "Program Year of Birth, from April - March"

keep if program_year == "2019-20"
duplicates drop id,force
save data/latest_year.dta,replace

clear
*2019-20 data is appended to the merged file.
use data/new_data
append using data/latest_year
save data/all_matched_data,replace
