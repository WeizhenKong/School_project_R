# Assignment 4 answers

#********************Part A********************************
# Using ggplot, plot the logistic models for his performance in matches as well as in practice in a single plot 
# Make sure that the plot has a title, labels for X and Y axes, and a legend

# Read data
library(ggplot2)
df <- read.csv('https://s3.amazonaws.com/programmingforanalytics/footballkicks.csv')
dfm <- df[df$practiceormatch == 'M',]
dfp <- df[df$practiceormatch == 'P',]
mylogitm <- glm(goal~yards, data = dfm, family = 'binomial')
summary(mylogitm)
mylogitp <- glm(goal~yards, data = dfp, family = 'binomial')
summary(mylogitp)
dfp$predicted <- predict(mylogitp, list(yards=dfp$yards), type = 'response')
dfm$predicted <- predict(mylogitm, list(yards=dfm$yards), type = 'response')
dfoverall <- rbind.data.frame(dfm,dfp)

g <- ggplot(data = dfoverall,aes(x = yards, y = predicted, color = practiceormatch)) + 
  geom_point() + xlab('Distance to goal in yards') +
  ylab('Probability of scoring a goal') + ggtitle("Probability of scoring a goal")
g

#*******************Part B******************
#Import data: train.csv
#Part a. Check for outlier for X and Y and explain the output in short and
#simple English (Don't forget to use #) (5 marks)
train <- read.csv("train.csv")
str(train)
par(mfrow = c(1, 2))
# Boxplot for X
boxplot(train$x, main='X', sub=paste('Outliers: ', boxplot.stats(train$x)$out))
# Boxplot for Y
boxplot(train$y, main='Y', sub=paste('Outliers: ', boxplot.stats(train$y)$out))

#Remove the outliers
numberOfNA = length(which(is.na(train)==T))
if(numberOfNA > 0) {
  cat('Number of missing values found: ', numberOfNA)
  cat('\nRemoving missing values...')
  train = train[complete.cases(train), ]
}

#Plot without outlier
par(mfrow = c(1, 2))
# Boxplot for X
boxplot(train$x, main='X', sub=paste('Outliers: ', boxplot.stats(train$x)$out))
# Boxplot for Y
boxplot(train$y, main='Y', sub=paste('Outliers: ', boxplot.stats(train$y)$out))

#Part b.Finding correlation between x and y
cor(train$x, train$y)

#Part c. Use the data to perform a simple regression analysis and interpret
#as well as visualized 
MyReg = lm(formula = y ~.,data = train)
summary(MyReg)
ggplot() + geom_point(aes(x = train$x, y = train$y),
             colour = 'green') +
geom_line(aes(x = train$x, y = predict(MyReg, newdata = train)),
            colour = 'orange') + ggtitle('X vs Y (Training set)') +
  xlab('X') + ylab('Y')

#**************************Part C***************************
#Import dataset: test.csv
test <-read.csv("test.csv")
reg = lm(formula = y ~.,data = test)
summary(reg)

#Part a. Check for residual mean and distribution.
plot(test$y, resid(reg), 
     ylab="Residuals", xlab="Price", 
     main="Residual plot") 
mean(reg$residuals)

#Part b. Visualizing the test set results.
ggplot() + geom_point(aes(x = test$x, y = test$y),
                      colour = 'yellow') +
  geom_line(aes(x = test$x, y = predict(MyReg, newdata = test)),
            colour = 'blue') + ggtitle('X vs Y (Test set)') +
  xlab('X') + ylab('Y')

#**************************Part D***************************
#Use the data (mtcars) to perform a regression modelling and investigate the
#relationship between miles per gallon (numerical class variable, mpg) and
#a set of independent variables (Hint: cyl, disp, hp etc)
data("mtcars")
str(mtcars)
#Converting the 5 numeric variables to the factor variables
mtcars$cyl <- factor(mtcars$cyl)
mtcars$vs <- factor(mtcars$vs)
mtcars$am <- factor(mtcars$am, levels = c(0,1), labels= c("automatic", "manual"))
mtcars$gear <- factor(mtcars$gear)
mtcars$carb <- factor(mtcars$carb)

#Model Building
#Let's build a model that predicts mpg only using am(transmission type)
M1 <- lm(mpg ~ am, data = mtcars)
summary(M1)
#Let's build a model by using variables disp, wt, hp, drat, cyl.
M2 <- lm(mpg ~ disp+wt+hp+drat+cyl, data = mtcars)
summary(M2)
#This model explains 86% of variability of data and also the adjusted R squared is 83%.
#This is a much beter model than the first one which only used am as predictor.
#Lets create a final model(#3) using only statistically significant variables as given in this model(#2) i.e wt, hp and cyl.

M3 <- lm(mpg ~ wt+hp+cyl, data = mtcars)
summary(M3)

#Output
#We have determined that there is a difference in mpg in relation to transmission
#type and have quantified that difference.
#However, transmission type does not appear to be a very good explanatory
#variable for mpg; weight, horsepower, and number of cylinders
#are all more significant variables.