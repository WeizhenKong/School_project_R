# Part A

# a. Indicate the type of data (categorical or continuous) for each of the variables included in
# the dataset.

names(mtcars)
?mtcars
# [, 1]	 mpg	 Miles/(US) gallon
# [, 2]	 cyl	 Number of cylinders
# [, 3]	 disp	 Displacement (cu.in.)
# [, 4]	 hp	 Gross horsepower
# [, 5]	 drat	 Rear axle ratio
# [, 6]	 wt	 Weight (1000 lbs)
# [, 7]	 qsec	 1/4 mile time
# [, 8]	 vs	 V/S
# [, 9]	 am	 Transmission (0 = automatic, 1 = manual)
# [,10]	 gear	 Number of forward gears
# [,11]	 carb	 Number of carburetors
#

head(mtcars)

# Based on the above I'd say that
# [, 2]	 cyl	 Number of cylinders
# [, 8]	 vs	 V/S
# [, 9]	 am	 Transmission (0 = automatic, 1 = manual)
# [,10]	 gear	 Number of forward gears
# [,11]	 carb	 Number of carburetors
# are the categorical variables

# b. For each of the categorical variables in the survey, indicate whether you believe the
# variable is nominal or ordinal.

# The nominal variables are
# [, 8]	 vs	 V/S
# [, 9]	 am	 Transmission (0 = automatic, 1 = manual)
# The ordinal variables are
# [, 2]	 cyl	 Number of cylinders
# [,10]	 gear	 Number of forward gears
# [,11]	 carb	 Number of carburetors


# c. Create a histogram for each of the continuous variables.
hist(mtcars$mpg)
hist(mtcars$disp)
hist(mtcars$hp)
hist(mtcars$drat)
hist(mtcars$wt)

# d. Find the maximum and minimum of each column using apply().
apply(mtcars,2,max)
apply(mtcars,2,min)

# e. Report the 25th, 50th, and 75th percentiles of all columns using apply().
apply(mtcars,2,quantile,c(0.25,0.5,0.75))

# f. Report and interpret the interquartile range for the mpg
# 50% of all the values of mpg fall between 15.425 and 22.80

## Part B (40 marks)

# a. Draw a scatterplot with mpg on the y axis and displacement on the x axis. 
# What does the graph # tell you (one or two sentences)?
plot(mtcars$mpg ~ mtcars$disp)
# As displacement increases mpg decreases; and the relationship is non-linear.

# b. Draw two histograms for mpg by am. One for am values of 0 and one for am values of 1. 
# What do the graphs tell you (one or two sentences)?
mtcarsam0 <- subset(mtcars, am==0)
mtcarsam1 <- subset(mtcars, am==1)
hist(mtcarsam0$mpg)
hist(mtcarsam1$mpg)
# Cars with am equal to zero tend to have lower values than cars with am equal to one.

