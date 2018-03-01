## Code for http://r4ds.had.co.nz/data-visualisation.html
## 2018 03 01 ------

## Quote:
## “The simple graph has brought more information to the data analyst’s mind than any other device.” 
## John Tukey

## 3.1 Introduction ------

## Goal: Visualize data using ggplot2
## Reading: “The Layered Grammar of Graphics”, http://vita.had.co.nz/papers/layered-grammar.pdf 

## Prerequisites:
# install.packages("tidyverse")  # once
library(tidyverse)               # always

## Note: Use "::", e.g., 
## package::function() 
## to explicilty use function() from package "package".


## 3.2 First steps: ------

# Questions:
# - Do cars with big engines use more fuel than cars with small engines?
# - Shape of the relationship?

## Data set: 
ggplot2::mpg

## Examine data: 
head(mpg)
dim(mpg)
summary(mpg)
str(mpg)
?mpg

## IV: displ
## DV: hwy

## Plot a scatterplot: 
ggplot(data = mpg) +                             # specify data set to use
  geom_point(mapping = aes(x = displ, y = hwy))  # specify geom + mapping 

## Abstract template:
## ggplot(data = <DATA>) + 
##  <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


## 3.2.4 Exercises: ------

# 1. Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)

# 2. How many rows are in mpg? How many columns?
dim(mpg)

# 3. What does the drv variable describe? Read the help for ?mpg to find out.
head(mpg$drv)
table(mpg$drv)
?mpg

# 4. Make a scatterplot of hwy vs cyl.
ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = cyl, y = hwy))

ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = hwy, y = cyl))

# 5. What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
table(mpg$class)

ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = class, y = drv))


## 3.3 Aesthetic mappings ------

## Quote: 
## “The greatest value of a picture is when it forces us to notice what we never expected to see.” 
## John Tukey

## Start from scatterplot above: 
ggplot(data = mpg) +                             # specify data set to use
  geom_point(mapping = aes(x = displ, y = hwy))  # specify geom + mapping 

## and add various mappings to variable "class":

ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = displ, y = hwy, color = class))  # map class on color

ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = displ, y = hwy, size = class))   # map class on size
## see Warning: size not advised for discrete variables.

ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))  # map class on alpha (transparency)

ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))  # map class on shape
## see Warning: 7 discrete categories, but only 6 shapes in palette... 

## Notes: 
# - The aes() function gathers together each of the aesthetic mappings used by a layer 
#   and passes them to the layer’s mapping argument. 
# - x and y are aesthetics: visual properties that are mapped to variables to display information about the data.
# - For x and y aesthetics, ggplot2 does not create a legend, but creates an axis line with tick marks and a label. 
#   The axis line acts as a legend; it explains the mapping between locations and values.

## Manually setting the aesthetic properties of a geom: No longer maps, but changes appearance.
## To set an aesthetic manually, set the aesthetic by name as an argument of the geom function  
## [i.e. it goes outside of aes().] 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), shape = 21, color = "black", fill = "steelblue4", alpha = 1/3, size = 3, stroke = 1) + 
  theme_light()


## 3.3.1 Exercises: ------

# 1. What’s gone wrong with this code? Why are the points not blue?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# the color = "blue" argument needs to be outside of aes():

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

# 2. Which variables in mpg are categorical? Which variables are continuous? 
#   (Hint: type ?mpg to read the documentation for the dataset). 
#   How can you see this information when you run mpg?

?mpg
mpg

# 3. Map a continuous variable to color, size, and shape. 
# How do these aesthetics behave differently for categorical vs. continuous variables?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ, size = hwy))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ, shape = hwy)) 
# => yields Error: A continuous variable can not be mapped to shape


# 4. What happens if you map the same variable to multiple aesthetics?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = displ, size = displ))


# 5. What does the stroke aesthetic do? What shapes does it work with? 
#    (Hint: use ?geom_point)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), shape = 21, color = "black", fill = "steelblue4", alpha = 1/3, size = 2, stroke = 2) + 
  theme_light()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), shape = 16, color = "black", fill = "steelblue4", alpha = 1/3, size = 2, stroke = 2) + 
  theme_light()


# 6. What happens if you map an aesthetic to something other than a variable name, 
#    like aes(colour = displ < 5)?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = (displ < 5), shape = (displ > 3)), size = 3) + 
  theme_light()

# Something interesting happens: Classification into 2 truth values.


## 3.4 Common problems: ------

# One common problem when creating ggplot2 graphics is to put the + in the wrong place: 
# it has to come at the end of the line, not the start. 

ggplot(data = mpg)   # won't work:
+ geom_point(mapping = aes(x = displ, y = hwy))

## Hints:
# - read error messages
# - try out and play with variants
# - consult help (via ?function) and manuals
# - Google error messages 


## 3.5 Facets: ------ 

## Facets are 
## := subplots that display different subsets of the data.
## - particularly useful for categorical variables
## - a main reason for using ggplot 

## (1) facet_wrap() wraps a plot into facets by a single variable:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ manufacturer, nrow = 2)

## (2) facet_grid() facets a plot by a combination of 2 variables:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl) + 
  theme_light()

## Remove facet in 1 dimension by using "." instead of variable name:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl) + 
  theme_light()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ .) + 
  theme_light()

## What does the following yield? 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  # facet_grid(. ~ .) + 
  theme_light()


## 3.5.1 Exercises: ------

# 1. What happens if you facet on a continuous variable?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty, nrow = 2)

# => interpreted as categorical variable (creating as many facets als levels)
# Hint: Use Boolean expression to create groups and corresponding binary facets: 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = (cty > 18))) + 
  facet_grid(. ~ (cty > 18))
  
  
  
## +++ here now +++



## ------
## eof.