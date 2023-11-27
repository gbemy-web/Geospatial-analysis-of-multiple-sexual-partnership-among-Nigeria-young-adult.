generate Religion=1 if religion<=2
replace Religion=2 if religion==3
replace Religion=0 if religion>=4
label define Religion 1 "christian" 2 "islam" 0 "tradiotionalist/others"
label values Religion Religion



generate Ethnic = 3 if ethnic==2|ethnic==3
replace Ethnic = 1 if ethnic==10
replace Ethnic = 2 if ethnic==6
replace Ethnic=0 if ethnic==1
replace Ethnic=0 if ethnic==4
replace Ethnic=0 if ethnic==5
replace Ethnic=0 if ethnic==7
replace Ethnic=0 if ethnic==8
replace Ethnic=0 if ethnic==9
replace Ethnic=0 if ethnic==96
replace Ethnic=0 if ethnic==98
label define Ethnic 3 "HausaF" 1 "Yoruba" 2 "Igbo" 0 "Others"
label values Ethnic Ethnic
 
generate internetuse= 1 if internet>0
replace internetuse=0 if internet==0
label define Internnet 0 "Yes" 1 "No"
label values internetuse Internnet

generate Marital_status=1 if marital_status==1
replace Marital_status=0 if marital_status==0|marital_status==2
replace Marital_status=2 if marital_status==3|marital_status==4|marital_status==5
label define Marital_status 0 "Never_married" 1 "Married" 2 "Seperated"
label values Marital_status Marital_status


generate multiple_partners=0 if tlnosp==1
replace multiple_partners=1 if tlnosp>=2

drop if tlnosp==.


generate mpis=0 if nospis<=1
replace mpis=1 if nospis>=2


label define gender 0 "Male" 1 "Female" 
label values gender gender

generate Age=0 if age<18
replace Age = 1 if Age!=0
replace Age =2 if age>20
label define Age 0 "15 - 17" 1 "18 - 20" 2 "21-14" 
label values Age Age

generate first_sex=0 if sex_debut<15
replace first_sex=1 if first_sex!=0
replace first_sex=2 if sex_debut>17
replace first_sex=3 if sex_debut>20
label define first_sex 0 "<15" 1 "15 - 17" 2 "18 - 20" 3 "21-14" 
label values first_sex first_sex

label value state

