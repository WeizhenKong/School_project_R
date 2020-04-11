# Assignment 3 answers

# Read data
df <- read.csv('https://s3.amazonaws.com/programmingforanalytics/footballkicks.csv')

# Part A
table(df$goal,df$practiceormatch)

# Part B
dfm <- df[df$practiceormatch == 'M',]
dfp <- df[df$practiceormatch == 'P',]
dfm$goal <- ifelse(dfm$goal == 'Y',1,0)
dfp$goal <- ifelse(dfp$goal == 'Y',1,0)

# a) (i) Write out the logistic function for matches
mylogitm <- glm(goal~yards, data = dfm, family = 'binomial')
summary(mylogitm)

# a) (ii) Write out the logistic function for practice
mylogitp <- glm(goal~yards, data = dfp, family = 'binomial')
summary(mylogitp)

# b) What is the probability of Melvin scoring a goal 
# when he kicks from 20, 40 and 60 yards in practice?
predict(mylogitp, list(yards=c(20,40,60)), type = 'response')

# c) What is the probability of Melvin scoring a goal 
# when he kicks from 20, 40 and 60 yards in matches?
predict(mylogitm, list(yards=c(20,40,60)), type = 'response')

