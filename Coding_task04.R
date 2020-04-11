# Assignment 5: Solutions

# Read data
mydf <- read.csv('SalesPerformance.csv')
mydf

# Convert Commis variable to a factor
str(mydf)
mydf$Commis <- as.factor(mydf$Commis)

# Part A
lm1 <- lm(Profit ~ Outlets + Area + Popn + Commis, data = mydf)
summary(lm1)
# Interpretation: 
# We can see that Commis is significant and positive in this regression.
# This is a first indication that representatives on commission are more effective than others.
# However, let us also include an interaction between Commis and Outlets and see if that effect is significant.

lm2 <- lm(Profit ~ Outlets + Area + Popn + Commis + Outlets*Commis, data = mydf)
summary(lm2)
# Interpretation: 
# The interaction term of Outlets and Commis is not significant. 
# Moreover, Commis by itself is not significant anymore either.
# Is this model a better fit to the data than the first model? Not really, since the adjusted R-squared is basically the same (0.6285 vs. 0.6215)

# Next, let us use Profit per Outlet as the dependent variable
mydf$ProfitperOutlet <- mydf$Profit / mydf$Outlets
lm3 <- lm(ProfitperOutlet ~ Outlets + Area + Popn + Commis + Outlets*Commis, data = mydf)
summary(lm3)
# Interpretation: 
# As some managers hypothesized, the more Outlets a representative has in his district, the less profit per outlet.
# The effect is the same for representatives on commission and for those not on commission, since the interaction term is not significant.
# The fit of the model in terms of adjusted R-squared is now 0.6374.

# Bonus: here is a plot of Outlets on Profit
library(ggplot2)
g <- ggplot(data = mydf, aes(x=Outlets, y = Profit, color = Commis)) + geom_point() +geom_smooth(method = 'lm')
g # note that there are several outliers that might distort our results

# Part B
# We will use the regression of Profit on all independent variables for this part
lm2 <- lm(Profit ~ Outlets + Area + Popn + Commis + Outlets*Commis, data = mydf)
summary(lm2)
# Interpretation: The interaction between Outlets and Commis, Commis, and Outlets are not significant.
# The adjusted R-squared is 0.6285
# Let us first remove the interaction between Outlets and Commis

lm1 <- lm(Profit ~ Outlets + Area + Popn + Commis, data = mydf)
summary(lm1)
# Interpretation:
# Area and Commis1 are significant. Outlets and Popn are not. 
# Let us remove Outlets

lm3 <- lm(Profit ~ Area + Popn + Commis, data = mydf)
summary(lm3)
# Now, all the coefficients are significant. 
# Moreover, the adjusted R-squared is 0.6272, which is almost as high as in the model with all the variables included.

# Part C
# We will use lm3 for this part, with Profit as DV and Area, Popn, Commis as IVs
# To check the assumptions, we can look at the different plots provided by plot(lm3)
plot(lm3)

# Interpretation:
# On the Residuals vs Fitted plot and Q-Q plot, we can see that the errors are not homoskedastic and are not normally distributed
# On the Scale-Location and Residuals vs Leverage plots, we can see that observations 19, 32, 47 seem to be outliers and heavily influence our results
# Based on our findings, we can remove observations 19, 32, and 47 and see if a regression without these observations satisfies the assumptions better.
# However, let us first visualize observations 19, 32, and 47 in a plot
mydf$Outliers <- ifelse(mydf$Dist %in% c(19,32,47), 1, 0)
mydf$Outliers <- as.factor(mydf$Outliers)
g <- ggplot(data = mydf, aes(x=Outlets, y = Profit, color = Commis, size = Outliers)) + geom_point() 
g
# As we can clearly see, observations 19,32, and 47 are clear outliers withing their Commission status

# Now, let us remove observations 19, 32, and 47 and see if a regression without these observations satisfies the assumptions better.
mydf2 <- mydf[-c(19,32,47),]

lm4 <- lm(Profit ~ Area + Popn + Commis, data = mydf2)
summary(lm4)
plot(lm4)
# Interpretation: 
# The Q-Q plot, Scale-Location plot, and Residuals vs Leverage plots all look better.
# On the Residuals vs Fitted plot however, errors still do not look homoskedastic.
# Overall though, the model fits the assumptions better.

# Bonus: Let us include the interaction between Outlets and Commis and see if this new model fits the assumptions better.
lm5 <- lm(Profit ~ Area + Popn + Commis + Outlets*Commis, data = mydf2)
summary(lm5)
plot(lm5)
# Interpretation: 
# This new model fits the assumptions better, as can be seen on the plots.
# Moreover, the adjusted R-squared is now really high with 0.85.

# Here a plot of the new model
g <- ggplot(data = mydf2, aes(x=Outlets, y = Profit, color = Commis)) + geom_point() + geom_smooth(method = 'lm')
g

