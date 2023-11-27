keep mv503 mv505 mv131 mv012 mv024 mv106 mv130 mv171a mv171b mv501 mv525 mv766a mv766b mv836 smstate mv025 mv750
drop if mv012>24
rename mv012 age
rename mv024 region
rename mv025 area
rename mv106 edu_level
rename mv130 religion
rename mv171a internet
rename mv171b finternet
rename mv501 marital_status
rename mv525 sex_debut
rename mv766a nospes
rename mv766b nospis
rename mv836 tlnosp
rename smstate state 
rename mv750 ehosti
rename mv503 nounions
rename mv505 nowives
rename mv131 ethnic
generate gender=0

