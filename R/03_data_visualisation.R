## Code for http://r4ds.had.co.nz/data-visualisation.html
## 2018 03 01 ------

## Quote:
## “The simple graph has brought more information to the data analyst’s mind than any other device.” 
## John Tukey

## 3.1 Introduction ------

## Goal: Visualize data using ggplot2
## Reading: “The Layered Grammar of Graphics”, http://vita.had.co.nz/papers/layered-grammar.pdf 

## Prerequisites:
install.packages("tidyverse") # once
library(tidyverse)            # always

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



## +++ here now +++



## ------
## eof.