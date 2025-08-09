#Load **Tidyverse**
library(tidyverse)


#More Packages - "palmerpenguins", "ggthemes"
library(palmerpenguins)
library(ggthemes)


#Show data
palmerpenguins::penguins
View(penguins)#-----------------------------------------------------------------Shows data in different tab
glimpse(penguins)#--------------------------------------------------------------Shows data in console_(Column based)



#Plot data
#Creating canvas
ggplot(data = penguins, mapping = aes(x=flipper_length_mm, y=body_mass_g))
#Creating plot
ggplot(data = penguins, mapping = aes(x=flipper_length_mm, y=body_mass_g)) + geom_point()
#Creating category
ggplot(data = penguins, mapping = aes(x=flipper_length_mm, y=body_mass_g, color=species)) + geom_point()
#Adding multiple "Geometric Object(geom)"
##Method - Linear model 
ggplot(data = penguins, mapping = aes(x=flipper_length_mm, y=body_mass_g, 
                                      color=species)) + geom_point() + geom_smooth(method = "lm")
#Local aesthetics
ggplot(data = penguins, mapping = aes(x=flipper_length_mm, y=body_mass_g)) + geom_point(
  mapping = aes(color=species)) + geom_smooth(method = "lm")
#Shape
ggplot(data = penguins, mapping = aes(x=flipper_length_mm, y=body_mass_g)) + geom_point(
  mapping = aes(color=species, shape=species)) + geom_smooth(method = "lm")
#Label with labs()
ggplot(data = penguins, mapping = aes(x=flipper_length_mm, y=body_mass_g)) + geom_point(
  mapping = aes(color=species, shape=species)) + geom_smooth(method = "lm") + labs(
    title = "Body mass and Flipper length",
    subtitle = "Dimension for Adelie, Chinstrap and Gentoo Penguins",
    x = "Flipper length(mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) + scale_color_colorblind()



#Exercise --- P-14
##Ques - 1
glimpse(penguins)  #Rows - 344;  Columns - 8;
##Ques - 2
?penguins #A number denoting bill depth (millimeters)
##Ques - 3
ggplot(data = penguins, mapping = aes(x=bill_length_mm, y=bill_depth_mm)) + geom_point()
###Better ans of ques_3
ggplot(data = penguins, mapping = aes(x=bill_length_mm, y=bill_depth_mm,
                                      col=species)) + geom_point() + geom_smooth(
                                        method = "lm") # The variable has an almost linear relationship with them
##Ques - 4
ggplot(data = penguins, mapping = aes(x=species, y=bill_depth_mm)) + geom_point() + geom_smooth(
                                        method = "lm") #Gives a vertical line only
ggplot(data = penguins, mapping = aes(x=species, y=bill_depth_mm)) + geom_boxplot() + geom_smooth(
                                        method = "lm") #Gives more understanding of each species
##Ques - 5
ggplot(data = penguins) + geom_point() #There is no mapping of the variables of the X and Y axes
ggplot(data = penguins, 
       mapping = aes(x=bill_length_mm, y=bill_depth_mm,
                     colour = species)) + geom_point() #Added mapping of variables of the X and Y axes
##Ques - 6
ggplot(data = penguins, 
       mapping = aes(x=bill_length_mm, y=bill_depth_mm,
                     shape = species, colour = species)) + geom_point(
                       na.rm = TRUE
                     ) #"na.rm = TRUE" ignores any warnings for missing values
##Ques - 7
ggplot(data = penguins, 
       mapping = aes(x=bill_length_mm, y=bill_depth_mm,
                     shape = species, colour = species)) + geom_point(
                       na.rm = TRUE
                     ) + labs(
                       caption = "Data comes from palmerpenguins package" #Caption is in down bottom NOT in the TOP
                     )
##Ques - 8
ggplot(data = penguins, 
       mapping = aes(x=flipper_length_mm, y=body_mass_g)) + geom_point(
         mapping = aes(colour = bill_length_mm)
       ) + geom_smooth()
##Ques - 9
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g, 
                     color = island)) + geom_point() + geom_smooth(se = FALSE) #categorized by island, smooth+point plot
##Ques - 10
###Plot_1
ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)) + geom_point() + geom_smooth()
###Plot_2
ggplot() + geom_point(data = penguins,
                      mapping = aes(x=flipper_length_mm, y=body_mass_g
                                    )) + geom_smooth(data = penguins,
                                                     mapping = aes(x=flipper_length_mm, y=body_mass_g
                                                                   )) # They are identical in all means.



#Categorical Variable
ggplot(data = penguins, aes(x=species)) + geom_bar() #Gives how many observations do X values has

#Reorder with frequencies
ggplot(data = penguins, aes(x=fct_infreq(species))) + geom_bar() + labs(x="Frequency",y="Species")



#Numerical Variable
##Continuous
ggplot(penguins, aes(x=body_mass_g)) + geom_histogram(binwidth = 200)
###Too many bin bars
ggplot(penguins, aes(x=body_mass_g)) + geom_histogram(binwidth = 20)
###Too few bin bar
ggplot(penguins, aes(x=body_mass_g)) + geom_histogram(binwidth = 2000)
###Using "density" geometric object - #Smooth Curve only
ggplot(penguins, aes(x=body_mass_g)) + geom_density()



#Exercise --- P-21
##Ques - 1
###Vertical
ggplot(penguins, aes(x=species)) + geom_bar()  #Graph is Vertically aligned
###Horizontal
ggplot(penguins, aes(y=species)) + geom_bar()  #Graph is now Horizontally aligned
##Ques - 2
###Plot_1
ggplot(penguins, aes(x=species)) + geom_bar(color="red")  #Turns border of the bar into "Red"
###Plot_2
ggplot(penguins, aes(x=species)) + geom_bar(fill="red")  #Turns fill of the bar into "Red"
##Ques - 3
ggplot(penguins, aes(x=body_mass_g)) + geom_histogram(binwidth = 200)  #"binwidth" determines width of each bar in the "Numerical" values
##Ques - 4
### Too many bin bars
ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth = 0.01)
### Too few bin bar
ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth = 1)
###Just enough bin bar
ggplot(diamonds, aes(x=carat)) + geom_histogram(binwidth = 0.15)



#Visualizing Relationship
##Box plot of Numerical and Categorical Variables
ggplot(penguins, aes(x=species, y=body_mass_g)) + geom_boxplot()
##Density plot_1 of Numerical and Categorical Variables
ggplot(penguins, aes(x=body_mass_g, color=species)) + geom_density(linewidth=1)  #"linewidth" thickens the density line
##Density plot_2 of Numerical and Categorical Variables
ggplot(penguins, aes(x=body_mass_g, color=species,
                     fill = species)) + geom_density(linewidth=1,
                                                     alpha=0.5)  #"alpha" creates shades to the density fill
##Two Categorical Variables
###Plot_1
ggplot(penguins, aes(x=island, fill = species)) + geom_bar()
###Plot_2
ggplot(penguins, aes(x=island, fill = species)) + geom_bar(position = "fill")  #Standardizes across the plot
##Two Numerical Variables
ggplot(penguins, aes(x=flipper_length_mm, y=body_mass_g)) + geom_point()
##Three or more Variables
ggplot(penguins, aes(x=flipper_length_mm, y=body_mass_g
                     )) + geom_point(aes(colour = species, shape = island)) 
##"Facet" -- Subplot
ggplot(penguins, aes(x=flipper_length_mm, y=body_mass_g
                     )) + geom_point(aes(colour = species, shape = island)) + facet_wrap(~island) 



#Exercise --- P-29
##Ques - 1
glimpse(mpg)
view(mpg)
?mpg
mpg  #Columns that have "chr" or characters as observations are generally the "Categorical Variables"
##Ques - 2
###Plot_1
ggplot(mpg, aes(x=hwy, y=displ, colour = cty)) + geom_point()
###Plot_2
ggplot(mpg, aes(x=hwy, y=displ)) + geom_point(aes(size = cyl))
###Plot_3
ggplot(mpg, aes(x=hwy, y=displ
                )) + geom_point(aes(colour = drv, size = cyl, 
                                    shape = drv))  #"Color" and "Size" can be mapped as "Numerical Variable", but "Shape" can not be mapped as "Numerical Variable"
##Ques - 3
ggplot(mpg, aes(x=hwy, y=displ, linewidth = year)) + geom_point()  #Nothing happens since there is no lines
##Ques - 4
ggplot(mpg, aes(x=hwy, y=hwy))  #Plots nothing. Since no relation between the same variables 
##Ques - 5








