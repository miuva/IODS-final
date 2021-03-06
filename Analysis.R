# Research question
### My aim is to explore if there is a connection between how well adolescents at grades 7-9 in lower secondary school get support from their teachers and families and how often they have mental symptoms. My hypothesis is that adolescents who get less support from their teachers and families, don´t feel appreciated and find their school´s rules unfair and unreasonable have more often (daily or weekly) mental symptoms which in this data are tension or nervousness, irritability or outbursts of ange, problems with falling asleep or waking up at night time, tiredness or weakness, depression or fear.

### The survey data I will use is part of Anne Konu´s (University of Tampere) School Well-being Profile -project which is collected in years 2015-2016. The sample is not random because schools have took part to the project by their own accord if they have wanted to investigate their well-being profile. More information about the project you can find [here (only in Finnish or Swedish)](http://www10.edu.fi/hyvinvointiprofiili/info.php?lang=) and [here](https://services.fsd.uta.fi/catalogue/FSD3117?lang=en&study_language=en). The data is provided by The Finnish Social Science Data Archive.
### Originally this data had 91 variables and 9820 observations. For this analysis I chose the following questions:
### * g1: Gender
### * q6_7: The rules of the school are reasonable.
### * q6_8 The punishments of the school are fair.
### * q7_9 The teachers treat us with justice.
### * q7_10 It is easy to get along with the teachers.
### * q7_11 Most of the teachers are interested in how I feel.
### * q7_12 Most of the teachers are friendly.
### * q10_1 My parents appreciate my schoolwork.
### * q10_2 My parents encourage me to do well at school.
### * q10_3 My parents help me with my homework if necessary.
### * q10_4 My parents help me with problems related to school if necessary.
### * q10_5 My parents are willing to come to the school to talk with a teacher if necessary.
### * q11_1 My work is appreciated at school.
### * q11_2 At school I´m regarded as a person who has a meaning.
### * q11_3 The teachers encourage me to tell my opinion.
### * q11_15 A teacher helps me if I need it.
### * q11_16 I receive remediation if I need it.
### * q11_17 I receive special education if I need it.
### * q11_18 I receive quidance if I need it.
### * q11_19 The teachers encourage me with studying.
### * q11_20 I reserve acknowledgement if I do well with my tasks.
### Have you had some of the following symptoms or illnesses during this semester? How often?
### * q13_4 Tension or nervousness?
### * q13_5 Irritability or outbursts of anger?
### * q13_6 Problems with falling asleep or waking up at night time?
### * q13_8 Tiredness or weakness?
### * q13_9 Depression?
### * q13_10 Fear?

### After selecting these questions to the data I removed all the observations with missing values.

### Questions from q6_7 to q11_20 are Likert scale questions with the following options:
### * 1 = Strongly disagree
### * 2 = Disagree
### * 3 = Neither agree nor disagree
### * 4 = Agree
### * 5 = Strongly agree

### In the original data these questions were categorical but I chose to change them to numeric to make their analysis easier.

### Questions from q13_4 to q13_10 were also categorical and their options where the following:
### * 0 = daily
### * 1 = weekly
### * 2 = monthly
### * 3 = rarely
### * 4 = none

### At first I changed the options to start from number 1 (daily) and to end to number 5 (none). Then I changed them to numeric. After that I created new binomial variables of them where the options daily and weekly get value "true" and the others get value "false".

### After all these changes there are now 34 variables and 8928 observations in this data.

getwd()
setwd("/Users/mirva/IODS-Final/Data")
school <- read.csv("school")
str(school)
library(dplyr); library(ggplot2); library(boot)

# Visualizing the data

## Likert-scale questions

### I will at first print the barplots for Likert-scale questions to see how the distributions of different questions look like.

g1 <- ggplot(data = school, aes(x = q6_7, fill = q1))
g1 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q6_7", subtitle = "The rules of the school are reasonable", caption = "Figure 1: The most popular answer here is 4 = agree and the least popular is 1 = strongly \n disagree. More boys than girls seem to answer 1 = strongly disagree.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g2 <- ggplot(data = school, aes(x = q6_8, fill = q1))
g2 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q6_8", subtitle = "The punishments of the school are fair", caption = "Figure 2: The most popular answer here is 4 = agree and 3 = neither agree nor disagree \n is also quite popular. Girls seem to think punishments fairer than boys.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g3 <- ggplot(data = school, aes(x = q7_9, fill = q1))
g3 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q7_9", subtitle = "The teachers treat us with justice", caption = "Figure 3: The most popular answer here is 4 = agree and the least popular is 1 = strongly \n disagree. Girls have answered more often 4 = agree than boys and boys have \n answered more often 1 = strongly disagree.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g4 <- ggplot(data = school, aes(x = q7_10, fill = q1))
g4 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q7_10", subtitle = "It is easy to get along with the teachers", caption = "Figure 4: The most popular answer here is 4 = agree and and only few have \n answered 1 = strongly disagree. Girls and boys have answered here almost \n as equally.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g5 <- ggplot(data = school, aes(x = q7_11, fill = q1))
g5 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q7_11", subtitle = "Most of the teachers are interested in how I feel",  caption = "Figure 5: The answers 3= neither agree or disagree and 4 = agree are the most popular \n ones in this question. Also here girls and boys have answered almost as equally.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g6 <- ggplot(data = school, aes(x = q7_12, fill = q1))
g6 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q7_12", subtitle = "Most of the teachers are friendly", caption = "Figure 6: The answer 4 = agree is the most popular here and also the answer  5 = strongly agree \n is quite popular. There aren´t big differences between gendes.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g7 <- ggplot(data = school, aes(x = q10_1, fill = q1))
g7 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q10_1", subtitle = "My parents appreciate my schoolwork",  caption = "Figure 7: The answers 5 = strongly agree and 4 = agree are the most popular ones. \n  Girls have answered more often 5 = strongly agree.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g8 <- ggplot(data = school, aes(x = q10_2, fill = q1))
g8 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q10_2", subtitle = "My parents encourage me to do well at school",  caption = "Figure 8: Also here the answer 5 = strongly agree is the most popular one \n and only a small minority has answered 1 = strongly disagree or 2 = disagree. \n Girls and boys have answered almost as equally.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g9 <- ggplot(data = school, aes(x = q10_3, fill = q1))
g9 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q10_3", subtitle = "My parents help me with my homework if necessary",  caption = "Figure 9: The answer 5 = strongly agree is the most popular one and also the answer \n 4 = agree is quite popular. There are no big differences between genders.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g10 <- ggplot(data = school, aes(x = q10_4, fill = q1))
g10 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q10_4", subtitle = "My parents help me with problems related to school if necessary",  caption = "Figure 10: The answers 5 = strongly agree and 4 = agree are the most popular ones here. \n And there is no big differences between boys and girls.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g11 <- ggplot(data = school, aes(x = q10_5, fill = q1))
g11 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q10_5", subtitle = "My parents are willing to come to the school to talk with a teacher if necessary",  caption = "Figure 11: Here the answer 5 = strongly agree is the most popular and almost \n as popular is the answer 4 = agree. Girls have answered more often 5 = strongly agree.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g12 <- ggplot(data = school, aes(x = q11_1, fill = q1))
g12 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q11_1", subtitle = "My work is appreciated at school",  caption = "Figure 12: Here the answer 5 = strongly agree is the most popular and almost \n as popular is the answer 4 = agree. There are no big differences between girls and boys.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g13 <- ggplot(data = school, aes(x = q11_2, fill = q1))
g13 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q11_2", subtitle = "At school I´m regarded as a person who has a meaning",  caption = "Figure 13: Here the answers 4 = agree and 3 = neither agree or disagree \n are the most popular ones. Boys seem to be little more confident than girls. ", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g14 <- ggplot(data = school, aes(x = q11_3, fill = q1))
g14 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q11_3", subtitle = "The teachers encourage me to tell my opinion",  caption = "Figure 14: Also here the answer 4 = agree is the most popular one and girls and boys have \n answered almost as equally.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g15 <- ggplot(data = school, aes(x = q11_15, fill = q1))
g15 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q11_15", subtitle = "A teacher helps me if I need it",  caption = "Figure 15: The most popular answer here is 4 = agree and girls and boys have \n answered almost equally.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g16 <- ggplot(data = school, aes(x = q11_16, fill = q1))
g16 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q11_16", subtitle = "I receive remediation if I need it",  caption = "Figure 16: As in earlier figures most of the answers are neutral (3) or \n positive (4 and 5) and there is no big difference between girls and boys.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g17 <- ggplot(data = school, aes(x = q11_17, fill = q1))
g17 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q11_17", subtitle = "I receive special education if I need it",  caption = "Figure 17: Also here the answer 4 = agree is the most popular one. \n There are only few who have answered 1 = strongly disagree or 2 = disagree. \n And there aren´t big differences between girls and boys.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g18 <- ggplot(data = school, aes(x = q11_18, fill = q1))
g18 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q11_18", subtitle = "I receive quidance if I need it",  caption = "Figure 18: If we look at this figure we can see that the answer 4 = agree \n is the most popular one and there aren´t big differences between genders.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g19 <- ggplot(data = school, aes(x = q11_19, fill = q1))
g19 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q11_19", subtitle = "The teachers encourage me with studying",  caption = "Figure 19: Also here the positive answers are the most common ones. Here the boys seem to feel slightly more encouraged than girls.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g20 <- ggplot(data = school, aes(x = q11_20, fill = q1))
g20 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q11_20", subtitle = "I reserve acknowledgement if I do well with my tasks",  caption = "Figure 20: Here the answer 4 is the most common one \n and there are no big differences between girls and boys", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

### As we can see from the plots above most of the pupils feel that they are appreciated and supported by their teachers and parents. But in every question there is a small minority of pupils who don´t agree with these statements. This is the group which is the most interesting. Do they have more mental symptoms than those who feel worthy and and supported?

## Symptoms and illnesses

g21 <- ggplot(data = school, aes(x = q13_4, fill = q1))
g21 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q13_4", subtitle = "Tension or nervousness",  caption = "Figure 21: Most of the boys don´t have had tension or nervousness \n during the semester or just rarely. The situation is quite different \n among girls; many of them have these symptoms rarely or monthly \n but there are also many who have them weekly or even daily.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g22 <- ggplot(data = school, aes(x = q13_5, fill = q1))
g22 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q13_5", subtitle = "Irritability or outbursts of anger",  caption = "Figure 22: Many of the pupils never have irritability or outbursts of \n anger but especially many of girls have them monthly or weekly. ", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g23 <- ggplot(data = school, aes(x = q13_6, fill = q1))
g23 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q13_6", subtitle = "Problems with falling asleep or waking up at night time",  caption = "Figure 23: Sleep problems seem also to be more common among girls than boys. \n Many of boys and also girls have them never or just rarely but \n some of them have them weekly or daily.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g24 <- ggplot(data = school, aes(x = q13_8, fill = q1))
g24 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q13_8", subtitle = "Tiredness or weakness",  caption = "Figure 24: Here the distributions between girls and boys are very different. \n Many of the girls have tiredness or weakness weekly or even daily. \n Boys have these symtpoms much more rarely or even never.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g25 <- ggplot(data = school, aes(x = q13_9, fill = q1))
g25 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q13_9", subtitle = "Depression",  caption = "Figure 25: Depression doesn´t seem to be so common symptom \n as the symptoms mentioned earlier. Most of the pupils have it \n never or only rarely. Girls seem to have it slightly more often than boys.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

g26 <- ggplot(data = school, aes(x = q13_10, fill = q1))
g26 + geom_bar(width = .6, position = "dodge") + labs(x = "", y = "Count", title ="Q13_10", subtitle = "Fear",  caption = "Figure 26: Fear seems to be the rarest symptom and most of the pupils never feel it. \n But there are also a few who feel it weekly or daily.", fill = "Gender") + theme(plot.caption = element_text(hjust = 0.5))

### As we can see these variables have more variation between girls and boys. Girls seem to have especially more tiredness, weakness and sleep problems. And many of the boys have rarely or never these symtomps although we can´t say on the grounds of these graphs whether they are always the same persons who have answered for example "never" to these questions or not.

# Logistic regression

### Now that we have explored the distributions of the chosen variables it´s time for logistic regression.
### I will use here the binomial variables of symptoms and illnesses instead of the original ones. I will also use bidirectional elimination of the variables to find the best model.

## Tension or nervousness

m1 <- glm(q13_4often ~ q1 + q6_7 + q6_8 + q7_9 + q7_10 + q7_11 + q7_12 + q10_1 + q10_2 + q10_3 + q10_4 + q10_5 + q11_1 + q11_2 + q11_3 + q11_15 + q11_16 + q11_17 + q11_18 + q11_19 + q11_20, data = school, family = "binomial")
sm1 <- step(m1, direction="both")
summary.glm(sm1)

### The variables which have the greatest and most significant negative connection to tension or nervousness are the following:
### * q1m = Gender: Male
### * q7_9 = The rules of the school are reasonable.
### * q10_1 = My parents appreciate my schoolwork.
### * q10_3 = My parents help me with my homework if necessary.
### * q11_1 = My work is appreciated at school.
### * q11_2 = At school I´m regarded as a person who has a meaning.

### Here are the coefficients of the model:
coef(sm1)

## Odds ratios and confidence intervals of the model:
OR1 <- coef(sm1) %>% exp
CI1 <- confint(sm1) %>% exp
cbind(OR1, CI1)
    
### If we look at the odds ratios and their confidence intervals we can see that 9 of the 13 variables in the model have odds ratios and their confidence intervals under 1. Gender has the biggest impact in this model (OR = 0.330) so odds to tension and nervousness are smaller among boys than girls. Other odds ratios have their upper limits of confidence intervals near 1 or even over it so they have quite small impact. After gender q11_2 = "At school I´m regarded as a person who has a meaning." (OR = 0.765) and q10_3 "My parents help me with my homework if necessary." (OR  = 0.817) have the smallest odds ratios meaning that the bigger the score the smaller the odds to have tension and nervousness daily or weekly.

## The predictive power of this model
probabilities1 <- predict(sm1, type = "response")
school <- mutate(school, probability1 = probabilities1)
school <- mutate(school, prediction1 = probability1 > 0.5)
table(q13_4often = school$q13_4often, prediction = school$prediction1)
gpp1 <- ggplot(school, aes(x = probability1, y = q13_4often, col = prediction1))
gpp1b <- gpp1 + geom_point() + labs(x = "Probability", y = "Symptoms daily or weekly", title ="Predictive power of the model", subtitle = "Tension or nervousness", color = "Prediction")
gpp1b
table(q13_4often = school$q13_4often, prediction = school$prediction1) %>% prop.table() %>% addmargins()

loss_func1 <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}
loss_func1(class = school$q13_4often, prob = school$probability1)
cv1 <- cv.glm(data = school, cost = loss_func1, glmfit = sm1, K = 10)
cv1$delta[1]

### As we can see from the matrix above there is approximately 76% chance to get true negative and approximately 3% chance to get true positive with this model so the predictive power of it is very low if we try to find pupils who have tension or nervousness daily or weekly.
### The average number of wrong predictions is approximately 0.21.


# Irritability or outbursts of anger
m2 <- glm(q13_5often ~ q1 + q6_7 + q6_8 + q7_9 + q7_10 + q7_11 + q7_12 + q10_1 + q10_2 + q10_3 + q10_4 + q10_5 + q11_1 + q11_2 + q11_3 + q11_15 + q11_16 + q11_17 + q11_18 + q11_19 + q11_20, data = school, family = "binomial")
sm2 <- step(m2, direction="both")
summary.glm(sm2)

### The variables which have the greatest and most significant negative connection to irritability or outbursts of anger are
### * q1m = Gender: Male
### * q6_7 = The rules of the school are reasonable.
### * q7_10 = It is easy to get along with the teachers.
### * q10_1 = My parents appreciate my schoolwork.
### * q10_3 = My parents help me with my homework if necessary.
### * q11_2 = At school I´m regarded as a person who has a meaning.
    
### Here are the coefficients of the model:
coef(sm2)

## Odds ratios and confidence intervals of the model:
OR2 <- coef(sm2) %>% exp
CI2 <- confint(sm2) %>% exp
cbind(OR2, CI2)

### If we look at the odds ratios here we can see that also here the most of the variables have their odds ratios near to one or their intervals even both sides of it. Smallest odds ratio is on gender (OR = 0.348) meaning that boys have smaller odds to have irritability or outbursts of anger daily or weekly. After gender the smallest odds ratios are on q11_2 "At school I´m regarded as a person who has a meaning." (OR = 0.817), q7_10 "It is easy to get along with the teachers." (OR = 0.818) and q10_3 (OR = 0.864) "My parents help me with my homework if necessary."

## The predictive power of this model
probabilities2 <- predict(sm2, type = "response")
school <- mutate(school, probability2 = probabilities2)
school <- mutate(school, prediction2 = probability2 > 0.5)
table(q13_5often = school$q13_5often, prediction = school$prediction2)
gpp2 <- ggplot(school, aes(x = probability2, y = q13_5often, col = prediction2))
gpp2b <- gpp2 + geom_point() + labs(x = "Probability", y = "Symptoms daily or weekly", title ="Predictive power of the model", subtitle = "Irritability or outbursts of anger", color = "Prediction")
gpp2b
table(q13_5often = school$q13_5often, prediction = school$prediction2) %>% prop.table() %>% addmargins()

loss_func2 <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}
loss_func2(class = school$q13_5often, prob = school$probability2)
cv2 <- cv.glm(data = school, cost = loss_func2, glmfit = sm2, K = 10)
cv2$delta[1]

### As we can see from the matrix above the predictive power of this model is quite low if we try to predict pupils who have irritability or outbursts of anger daily or weekly. There is approximately 78% chance to get true negative and only approximately 3% chance to get true positive with this model.
### The average number of wrong predictions is approximately 0.20.

# Problems with falling asleep or waking up at night time
m3 <- glm(q13_6often ~ q1 + q6_7 + q6_8 + q7_9 + q7_10 + q7_11 + q7_12 + q10_1 + q10_2 + q10_3 + q10_4 + q10_5 + q11_1 + q11_2 + q11_3 + q11_15 + q11_16 + q11_17 + q11_18 + q11_19 + q11_20, data = school, family = "binomial")
sm3 <- step(m3, direction="both")
summary.glm(sm3)

### The variables which have the greatest and most significant negative connection to sleep problems are
### * q1m = Gender: Male
### * q10_1 = My parents appreciate my schoolwork.
### * q10_3 = My parents help me with my homework if necessary.
### * q11_15 = A teacher helps me if I need it.

### Here are the coefficients of the model:
coef(sm3)

## Odds ratios and confidence intervals of the model:
OR3 <- coef(sm3) %>% exp
CI3 <- confint(sm3) %>% exp
cbind(OR3, CI3)

### If we look at the odds ratios we can see that boys have smaller odds (OR = 0.476) to sleep problems daily or weekly and after that the biggest impact is on questions q10_1 "My parents appreciate my schoolwork." (OR = 0.828) and q10_3 "My parents help me with my homework if necessary."

## The predictive power of this model
probabilities3 <- predict(sm3, type = "response")
school <- mutate(school, probability3 = probabilities3)
school <- mutate(school, prediction3 = probability3 > 0.5)
table(q13_6often = school$q13_6often, prediction = school$prediction3)
gpp3 <- ggplot(school, aes(x = probability3, y = q13_6often, col = prediction3))
gpp3b <- gpp3 + geom_point() + labs(x = "Probability", y = "Symptoms daily or weekly", title ="Predictive power of the model", subtitle = "Problems with falling asleep or waking up at night time", color = "Prediction")
gpp3b
table(q13_6often = school$q13_6often, prediction = school$prediction3) %>% prop.table() %>% addmargins()

loss_func3 <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}
loss_func3(class = school$q13_6often, prob = school$probability3)
cv3 <- cv.glm(data = school, cost = loss_func3, glmfit = sm3, K = 10)
cv3$delta[1]

### If we look at the matrix above we can see that predictiwe power of this matrix is also quite low if we try to find pupils who have sleep problems daily or weekly. The chance to get true negative is approximately 76% and true positive approximately 3%.
### The average number of wrong predictions is approximately 0.22.

# Tiredness or weakness
m4 <- glm(q13_8often ~ q1 + q6_7 + q6_8 + q7_9 + q7_10 + q7_11 + q7_12 + q10_1 + q10_2 + q10_3 + q10_4 + q10_5 + q11_1 + q11_2 + q11_3 + q11_15 + q11_16 + q11_17 + q11_18 + q11_19 + q11_20, data = school, family = "binomial")
sm4 <- step(m4, direction="both")
summary.glm(sm4)

### The variables which have the greatest and most significant negative connection to tiredness or weakness are
### * q1m = Gender: Male
### * q7_9 = The teachers treat us with justice.
### * q10_1 = My parents appreciate my schoolwork.
### * q10_3 = My parents help me with my homework if necessary.
### * q11_1 = My work is appreciated at school.

### Here are the coefficients of the model:
coef(sm4)

## Odds ratios and confidence intervals of the model:
OR4 <- coef(sm4) %>% exp
CI4 <- confint(sm4) %>% exp
cbind(OR4, CI4)

### If we look at the odds ratios and their confidence intervals here we can see that also here only the gender has big impact on the model (OR = 0.330) meaning that boys have smaller odds to have tiredness or weakness daily or weekly. After gender the biggest impact is on questions q10_3  "My parents help me with my homework if necessary." (OR = 0.837) and q10_1 "My parents appreciate my schoolwork." (OR = 0.837).

## The predictive power of this model
probabilities4 <- predict(sm4, type = "response")
school <- mutate(school, probability4 = probabilities4)
school <- mutate(school, prediction4 = probability4 > 0.5)
table(q13_8often = school$q13_8often, prediction = school$prediction4)
gpp4 <- ggplot(school, aes(x = probability4, y = q13_8often, col = prediction4))
gpp4b <- gpp4 + geom_point() + labs(x = "Probability", y = "Symptoms daily or weekly", title ="Predictive power of the model", subtitle = "Tiredness or weakness", color = "Prediction")
gpp4b
table(q13_8often = school$q13_8often, prediction = school$prediction4) %>% prop.table() %>% addmargins()

loss_func4 <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}
loss_func4(class = school$q13_8often, prob = school$probability4)
cv4 <- cv.glm(data = school, cost = loss_func4, glmfit = sm4, K = 10)
cv4$delta[1]

### If we look at the matrix above we can see that the predictive power of this model is better than earlier models but it´s still not big enough to find pupils who have tiredness or weakness daily or weekly. There is approximately a 65% chance to get true negative and approximately a 8% chance to get true positive with this model.
### The average number of wrong predictions is approximately 0.27.

# Depression
m5 <- glm(q13_9often ~ q1 + q6_7 + q6_8 + q7_9 + q7_10 + q7_11 + q7_12 + q10_1 + q10_2 + q10_3 + q10_4 + q10_5 + q11_1 + q11_2 + q11_3 + q11_15 + q11_16 + q11_17 + q11_18 + q11_19 + q11_20, data = school, family = "binomial")
sm5 <- step(m5, direction="both")
summary.glm(sm5)

### The variables which have the greatest and most significant negative connection to depression are
### * q1m = Gender: Male
### * q7_9 = The teachers treat us with justice.
### * q10_1 = My parents appreciate my schoolwork.
### * q10_3 = My parents help me with my homework if necessary.
### * q11_2 = At school I´m regarded as a person who has a meaning.
### * q11_20 = I reserve acknowledgement if I do well with my tasks.

### Here are the coefficients of the model:
coef(sm5)

## Odds ratios and confidence intervals of the model:
OR5 <- coef(sm5) %>% exp
CI5 <- confint(sm5) %>% exp
cbind(OR5, CI5)

### If we look at the odds ratios and their confidence intervals we can see that gender (OR = 0.273) and question q11_2 "At school I´m regarded as a person who has a meaning." (OR = 0.672) have really impact on the model meaning that boys and pupils who feel that they have meaning in their schools have smaller odds to have depression. Also questions q10_1 "My parents appreciate my schoolwork." (OR = 0.797) and q7_9 "The teachers treat us with justice." (OR = 0.828) have small impact on the model. Other variables are quite near to 1 or even on the both sides of it.

## The predictive power of this model
probabilities5 <- predict(sm5, type = "response")
school <- mutate(school, probability5 = probabilities5)
school <- mutate(school, prediction5 = probability5 > 0.5)
table(q13_9often = school$q13_9often, prediction = school$prediction5)
gpp5 <- ggplot(school, aes(x = probability5, y = q13_9often, col = prediction5))
gpp5b <- gpp5 + geom_point() + labs(x = "Probability", y = "Symptoms daily or weekly", title ="Predictive power of the model", subtitle = "Depression", color = "Prediction")
gpp5b
table(q13_9often = school$q13_9often, prediction = school$prediction5) %>% prop.table() %>% addmargins()

loss_func5 <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}
loss_func5(class = school$q13_9often, prob = school$probability5)
cv5 <- cv.glm(data = school, cost = loss_func5, glmfit = sm5, K = 10)
cv5$delta[1]

### If we look at the matrix above we can see that the predictive power of also this model is quite low if we try to find pupils who have depression daily or weekly. The chance to get true negative is approximately 84% and true positive approximately 2%.
### The average number of wrong predictions is approximately 0.14.

# Fear
m6 <- glm(q13_10often ~ q1 + q6_7 + q6_8 + q7_9 + q7_10 + q7_11 + q7_12 + q10_1 + q10_2 + q10_3 + q10_4 + q10_5 + q11_1 + q11_2 + q11_3 + q11_15 + q11_16 + q11_17 + q11_18 + q11_19 + q11_20, data = school, family = "binomial")
sm6 <- step(m6, direction="both")
summary.glm(sm6)

### The variables which have the greatest and most significant negative connection to fear are
### * q1m = Gender: Male
### * q11_2 = At school I´m regarded as a person who has a meaning.

### Here are the coefficients of the model:
coef(sm6)

## Odds ratios and confidence intervals of the model:
OR6 <- coef(sm6) %>% exp
CI6 <- confint(sm6) %>% exp
cbind(OR6, CI6)

### If we look at the odds ratios and their confidence intervals also here we can see that gender has the biggest impact on the model (OR = 0.360) meaning that boys have smaller odds to feel fear daily or weekly. Also question q11_2 "At school I´m regarded as a person who has a meaning." has quite small odds ratio (OR = 0.624) meaning the bigger the score the smaller the odds to feel fear daily or weekly. Question q11_1 "My work is appreciated at school." (OR = 0.800) might have some impact on the mode but it´s confidence interval is quite wide.

## The predictive power of this model
probabilities6 <- predict(sm6, type = "response")
school <- mutate(school, probability6 = probabilities6)
school <- mutate(school, prediction6 = probability6 > 0.5)
table(q13_10often = school$q13_10often, prediction = school$prediction6)
gpp6 <- ggplot(school, aes(x = probability6, y = q13_10often, col = prediction6))
gpp6b <- gpp6 + geom_point() + labs(x = "Probability", y = "Symptoms daily or weekly", title ="Predictive power of the model", subtitle = "Fear", color = "Prediction")
gpp6b
table(q13_10often = school$q13_10often, prediction = school$prediction6) %>% prop.table() %>% addmargins()

loss_func6 <- function(class, prob) {
  n_wrong <- abs(class - prob) > 0.5
  mean(n_wrong)
}
loss_func6(class = school$q13_10often, prob = school$probability6)
cv6 <- cv.glm(data = school, cost = loss_func6, glmfit = sm6, K = 10)
cv6$delta[1]

### If we look at the plot above we can see that the predictive power of this model is the smallest of all these models if we try to predict pupils who have fear daily or weekly. The chance to get true negative is approximately 93% and true positive approximately only 1%.
### The average number of wrong predictions is approximately 0.07.

# Conclusions and discussion

### As we have seen earlier it is quite hard to predict mental symptoms which occur daily or weekly with questions about relationships with teachers and parents and the support they will provide. There some some variables which have more connection to these symptoms than others. The most important one is gender. It seems that overall boys have less or more rarely mental symptoms daily or weekly than girls.
### For tension and nervousness Likert-scale questions q11_2 = "At school I´m regarded as a person who has a meaning." and q10_3 "My parents help me with my homework if necessary." were the most important.
### For irritability or outbursts of anger the same questions as for tension and nervousness and also the question q7_10 "It is easy to get along with the teachers." were the most important.
### For sleep problems and also for tiredness and weakness the most important questions were q10_1 "My parents appreciate my schoolwork." and q10_3 "My parents help me with my homework if necessary."
### With depression the question q11_2 "At school I´m regarded as a person who has a meaning." had the greatest connection and also questions q10_1 "My parents appreciate my schoolwork."and q7_9 "The teachers treat us with justice." had small impact on the model. 
### Feeling fear was most connected to question q11_2 "At school I´m regarded as a person who has a meaning." and also to question q11_1 "My work is appreciated at school."
### So if we look at these results we can see that 