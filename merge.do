clear all
import excel data/birthweight.xlsx,firstrow case(lower)

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

drop if program_year == "1995-96"

duplicates drop id,force

save data/sepsis_master,replace

clear

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

drop if program_year == "2019-20" | program_year == "2020-21" | program_year == "1995-96"
duplicates drop id,force

save data/new_id,replace

clear

use data/sepsis_master
merge 1:1 id using data/new_id,force
drop if _merge==2
drop _merge

save data/new_data

clear
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

use data/new_data
append using data/latest_year
save data/all_matched_data,replace
