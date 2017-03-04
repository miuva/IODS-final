# 4.3.2017 Mirva Turkia
# Introduction to Open Data Science

# This is the script file for the data wrangling part of my final assignment

# Here is the information of the data I will use:
# Konu, Anne (University of Tampere): SCHOOL WELL-BEING PROFILE 2015-2016: LOWER SECONDARY SCHOOL, GRADES 7-9 [electronic data]. Version 1.0 (2016-07-18). The Finnish Social Science Data Archive [distributor]. http://urn.fi/urn:nbn:fi:fsd:T-FSD3117


getwd()
setwd("/Users/mirva/IODS-final/Data")

# At first I installed package "memisc" and then I´ll read the SPSS data into R
library(memisc); library(dplyr)
data <- as.data.set(spss.portable.file('daF3117.por'))

# As you can see the data is very large; it has 91 variables and 9820 observations
data
str(data)
dim(data)


# I will use only the following 27 variables:
# [Q1] Gender
# [Q6_7] Koulun säännöt ovat järkeviä (The rules of the school are reasonable)
# [Q6_8] Koulun rangaistukset ovat oikeudenmukaisia (The punishments of the school are fair.)
# [Q7_9] Opettajat kohtelevat meitä oppilaita oikeudenmukaisesti. (The teachers treat us with justice.)
# [Q7_10] Opettajien kanssa on helppo tulla toimeen. (It is easy to get along with the teachers.)
# [Q7_11] Useimmat opettajat ovat kiinnostuneita siitä, mitä minulle kuuluu. (Most of the teachers are interested in how I feel.)
# [Q7_12] Useimmat opettajat ovat ystävällisiä. (Most of the teachers are friendly.)
# [Q10_1] Vanhempani arvostavat koulutyötäni. (My parents appreciate my schoolwork.)
# [Q10_2] Vanhempani kannustavat minua menestymään koulussa. (My parents encourage me to do well at school.)
# [Q10_3] Tarvittaessa vanhempani auttavat koulutehtävissä. (My parents help me with my homework if necessary.)
# [Q10_4] Tarvittaessa vanhempani auttavat kouluun liittyvissä ongelmissa. (My parents help me with problems related to school if necessary.)
# [Q10_5] Vanhempani ovat tarvittaessa halukkaita tulemaan kouluun keskustelemaan opettajan kanssa. (My parents are willing to come to the school to talk with a teacher if necessary.)
# [Q11_1]  Minun työtäni arvostetaan koulussa. (My work is appreciated at school.)
# [Q11_2] Minua pidetään koulussa henkilönä, jolla on merkitystä. (At school I´m regarded as a person who has a meaning.)
# [Q11_3] Opettajat rohkaisevat minua ilmaisemaan mielipiteeni. (The teachers encourage me to tell my opinion.)
# [Q11_15] Saan apua opettajalta, jos tarvitsen sitä. (A teachers helps me if I need it.)
# [Q11_16] Saan tukiopetusta, jos tarvitsen sitä. (I receive remediation if I need it.)
# [Q11_17] Saan erityisopetusta, jos tarvitsen sitä. (I receive special education if I need it.)
# [Q11_18] Saan ohjausta opiskeluuni, jos tarvitsen sitä. (I receive quidance if I need it.)
# [Q11_19] Opettajat kannustavat minua opiskelussa. (The teachers encourage me with studying.)
# [Q11_20] Saan kiitosta, jos olen suoriutunut hyvin tehtävissäni. (I reserve acknowledgement if I do well with my tasks.)
# Onko sinulla tämän lukukauden aikana ollut jotakin seuraavista oireista tai sairauksista? Kuinka usein?: (Have you had some of the following symptoms or illnesses during this semester? How often?)
# [Q13_4] Jännittyneisyyttä tai hermostuneisuutta. (Tension or nervousness.)
# [Q13_5] Ärtyneisyyttä tai kiukunpurkauksia. (Irritability or outbursts of anger.)
# [Q13_6] Vaikeuksia päästä uneen tai heräilemistä öisin. (Problems with falling asleep or waking up at night time.)
# [Q13_8] Väsymystä tai heikotusta. (Tiredness or weakness.)
# [Q13_9] Alakuloisuutta. (Depression.)
# [Q13_10] Pelkoa. (Fear.)

# I will check how the variable names are coded
variable.names(data)

# Now that I know the exact names of the variables I will create a new dataset of the ones I'm interested in
school <- data[, c("q1", "q6_7", "q6_8", "q7_9", "q7_10", "q7_11", "q7_12", "q10_1", "q10_2", "q10_3", "q10_4", "q10_5", "q11_1", "q11_2", "q11_3", "q11_15", "q11_16", "q11_17", "q11_18", "q11_19", "q11_20", "q13_4", "q13_5", "q13_6", "q13_8", "q13_9", "q13_10")]

# Now there are 27 variables and 9820 observations
dim(school)

# I will remove all rows with missing values (since I don´t know enough of imputation yet)
complete.cases(school)
data.frame(school[-1], comp = complete.cases(school))
school_ <- stats::filter(school, complete.cases(school))

