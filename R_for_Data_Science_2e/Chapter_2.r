#Load **Tidyverse**
library(tidyverse)


#More Packages - "palmerpenguins", "ggthemes"
library(palmerpenguins)
library(ggthemes)



#Coding Basics
##Assignments
x <- 3*4
x
###Assignment operator can be written as ( "Alt" + '-' )

##Vectors - c()
primes <- c(2, 3, 5, 7, 11, 13)
primes*2

#Comments
##Self explanatory - using '#' for single line comment



#Names
this_is_a_really_long_name <- 2.5
##Press "tab" to auto complete object(Maybe there is more) names 
this_is_a_really_long_name
##Using the console can edit the values by going into the previous command (up-arrow)
##Ctrl + up-arrow shows all the previous command to select one and maybe edit.
r_rock <- 2^3
##object name is case-sensitive 



#Functions
##Functions are written as
##function_name(argument1=value1, argument2-value2, ...)



#Exercise --- P-37
##Ques - 1
Spelling mistake. As stated previously. Object name is case-sensitive

\##Ques - 2
Given wrong command
  library(todyverse)
####  ggplot(dTA = mpg) + geom_point(maping = aes(x=displ, y = hwy)) + geom_smooth(method = "lm)
Correct command
library(tidyverse)
ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + geom_point() + geom_smooth(method = "lm")

##Ques - 3
Opens shortcut menu

##Ques - 4
my_bar_plot <- ggplot(mpg, aes(x=class)) + geom_bar()
my_scatter_plot  <- ggplot(mpg, aes(x=cty, y=hwy)) +geom_point()
ggsave(filename = "mpg-plot.png", plot = my_bar_plot)
###Saves the first plot because it is explicitly given as an argument to ggsave.







