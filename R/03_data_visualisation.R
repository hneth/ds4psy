## r4ds: Chapter 3: Data visualisation 
## Code for http://r4ds.had.co.nz/data-visualisation.html
## hn spds uni.kn
## 2018 11 12 ------


## Quotes: ------

## “The simple graph has brought more information to the data analyst’s mind than any other device.” 
## John Tukey

## “The greatest value of a picture is when it forces us to notice what we never expected to see.” 
## John Tukey



## Note some keyboard shortcuts: ------

## Create some objects:
name <- "Hans"
v <- 1:10

## - Cmd/Ctrl + Shift + F10: restart R session (cleaning environment)
## - Cmd/Ctrl + Shift + S:   rerun the current script



## 3.1 Introduction ------

## Goal: Visualize data using ggplot2
## Reading: “The Layered Grammar of Graphics”, http://vita.had.co.nz/papers/layered-grammar.pdf 
## See ggplot cheatsheet at https://www.rstudio.com/resources/cheatsheets/ : 
##     https://github.com/rstudio/cheatsheets/raw/master/data-visualization-2.1.pdf 

## Prerequisites:
# install.packages("tidyverse")  # once
library(tidyverse)               # always

## Note: Use "::", e.g., 
## pack::func() 
## to explicilty use a function "func()" from package "pack".


## 3.2 First steps ------

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

# Beware of shorter and alternative versions:
ggplot(mpg) +
  geom_point(aes(x = displ, y = hwy)) 

ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() 


## 3.2.4 Exercises ------

## Exploring the mpg data set and ggplot essentials: 

# 1. Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)

# 2. How many rows are in mpg? How many columns?
mpg
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

# 5. What happens if you make a scatterplot of class vs drv? 
#    Why is the plot not useful?

ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = class, y = drv))

# Why is the plot not useful?
# Overplotting (as both variables are categorical and have multiple instances): 

table(mpg$class, mpg$drv)

# Advanced solution: 
# Count frequency and use size to show it in graph:

mpg %>%
  group_by(class, drv) %>%
  count %>%
  ggplot() +                            
  geom_point(mapping = aes(x = class, y = drv, size = n), color = "steelblue") + 
  theme_light()


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
## See Warning: size not advised for discrete variables.

ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))  # map class on alpha (transparency)

ggplot(data = mpg) +                            
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))  # map class on shape
## see Warning: 7 discrete categories, but only 6 shapes in palette... 

## Notes on aesthetics and aes(): 

# - The aes() function gathers together each of the aesthetic mappings used by a layer 
#   and passes them to the layer’s mapping argument. 

# - x and y are aesthetics: visual properties that are mapped to variables to display information about the data.

# - For x and y aesthetics, ggplot2 does not create a legend, but creates an axis line with tick marks and a label. 
#   The axis line acts as a legend; it explains the mapping between locations and values.

## Manually setting the aesthetic properties of a geom: No longer maps, but changes appearance.

## To set an aesthetic manually, set the aesthetic by name as an argument of the geom function  
## [i.e., outside of aes().] 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), 
             shape = 21, color = "black", fill = "steelblue4", alpha = 1/4, size = 4, stroke = 1) + 
  theme_light()


## 3.3.1 Exercises ------

# 1. What’s gone wrong with this code? Why are the points not blue?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# Answer: The color = "blue" argument needs to be outside of aes():

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
?geom_point

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), 
             shape = 21, color = "black", fill = "steelblue4", alpha = 1/4, size = 1, stroke = 7) + 
  theme_light()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), 
             shape = 16, color = "black", fill = "steelblue4", alpha = 1/4, size = 1, stroke = 8) + 
  theme_light()

# Note: fill for shape = 21 corresponds to color of shape = 16, etc.

# 6. What happens if you map an aesthetic to something other than a variable name, 
#    like aes(colour = displ < 5)?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = (displ < 5), shape = (displ > 3)), size = 3) + 
  theme_light()

# Something very interesting happens: 
# Classification into 2 truth values (according to definition).
# This allows grouping continuous variables into (visual) categories.


## 3.4 Common problems ------

# One common problem when creating ggplot2 graphics is to put the + in the wrong place: 
# it has to come at the end of the line, not the start. 

ggplot(data = mpg)   # won't work:
  + geom_point(mapping = aes(x = displ, y = hwy))

## Hints:
# - read error messages
# - try out and play with variants
# - consult help (via ?function) and manuals
# - Google error messages 



## 3.5 Facets ------ 

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


## 3.5.1 Exercises ------

# 1. What happens if you facet on a continuous variable?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ cty, nrow = 2)

# => interpreted as categorical variable (creating as many facets als levels)
# Hint: Use Boolean expression to create groups and corresponding binary facets: 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = (cty > 18))) + 
  facet_grid(. ~ (cty > 18))
  

# 2a. What do the empty cells in plot with facet_grid(drv ~ cyl) mean? 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl) + 
  theme_light()

# 2b. How do they relate to this plot?
  
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = drv, y = cyl))  


# 3. What plots does the following code make? What does . do?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ .)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl)


# 4. Take the first faceted plot in this section:

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

# - What are the advantages to using faceting instead of the colour aesthetic? 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

# - What are the disadvantages? 
# - How might the balance change if you had a larger dataset?

# 5. Read ?facet_wrap.

?facet_wrap

# - What does nrow do? What does ncol do? 
# - What other options control the layout of the individual panels? 
# - Why doesn’t facet_grid() have nrow and ncol argument?

# 6. When using facet_grid() you should usually put the variable 
#    with more unique levels in the columns. Why?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl) +   # (3 rows ~ 4 cols)
  theme_light()

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(cyl ~ drv) +   # (4 rows ~ 3 cols)
  theme_light()



## 3.6 Geometric objects (geoms) ------

## Same plot with different geoms:

# (1) Scatterplots using point geom:
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# (2) Fitted line plot using smooth geom:
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# (3) Combining both:
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(x = displ, y = hwy))   

# Note: Order determines which geoms are plotted above/below which others.

## Grouping variable levels with group vs. aesthetics:

## Grouping by group: 
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv)) # => 3 lines, but no corresponding legend.

# Grouping smooth lines (by linetype and color):
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv)) # => 3 more distinct lines + legend.

# Combining multiple geoms:
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv)) + 
  geom_point(mapping = aes(x = displ, y = hwy, linetype = drv, color = drv))


## Geoms:

# - ggplot2 provides over 30 geoms, and extension packages provide even more 
#   (see https://www.ggplot2-exts.org for a sampling). 
# - The best way to get a comprehensive overview is the ggplot2 cheatsheet, 
#   which you can find at http://rstudio.com/cheatsheets. 
# - To learn more about any single geom, use help: 

?geom_smooth

?geom_path

# Check out example: 
c <- ggplot(economics, aes(x = date, y = pop))
c + geom_line(arrow = arrow())
c + geom_line(
  arrow = arrow(angle = 15, ends = "both", type = "closed")
  )


## Grouping with group vs. aesthetics: 

# Many geoms, like geom_smooth(), use a single geometric object to display multiple rows of data. 
# For these geoms, you can set the group aesthetic to a categorical variable to draw multiple objects. 
# ggplot2 will draw a separate object for each unique value of the grouping variable: 

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv))

# In practice, ggplot2 will automatically group the data for these geoms 
# whenever you map an aesthetic to a discrete variable (as in the linetype example). 
# It is convenient to rely on this feature because the group aesthetic by itself 
# does not add a legend or distinguishing features to the geoms: 

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, color = drv), show.legend = FALSE)

## Note: Setting `show.legend = FALSE` creates (almost) the same plot as above (with group = drv).


## Multiple geoms in 1 plot: Local vs. global mappings

## To display multiple geoms in the same plot, add multiple geom functions to ggplot():

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

## This, however, introduces some duplication in our code. 
## Imagine if you wanted to change the y-axis to display cty instead of hwy. 
## You’d need to change the variable in two places, and you might forget to update one. 
## You can avoid this type of repetition by passing a set of mappings to ggplot(). 
## ggplot2 will treat these mappings as global mappings that apply to each geom in the graph. 
## In other words, this code will produce the same plot as the previous code:

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() +
  geom_smooth()

## If you place mappings in a geom function, ggplot2 will treat them as local mappings for the layer. 
## It will use these mappings to extend or overwrite the global mappings for that layer only. 
## This makes it possible to display different aesthetics in different layers: 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth()

## You can use the same idea to specify different data for each layer. 
## Here, our smooth line displays just a subset of the mpg dataset, the subcompact cars. 
## The local data argument in geom_smooth() overrides the global data argument in ggplot() 
## for that layer only:

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point(mapping = aes(color = class)) + 
  geom_smooth(data = filter(mpg, class == "subcompact"), se = FALSE) # + 
  # geom_smooth(data = filter(mpg, class == "suv"), se = FALSE, color = "pink")


## 3.6.1 Exercises: ------

## 1. What geom would you use to draw a line chart? 
##    A boxplot? A histogram? An area chart?

?geom_path # redirected from ?geom_line
?geom_boxplot
?geom_histogram # see also geom_freqpoly
?geom_area

## Try out some plots:

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot(mapping = aes(color = class))

ggplot(data = mpg) + 
  geom_histogram(aes(x = cty))

ggplot(data = mpg) + 
  geom_freqpoly(aes(x = cty))

ggplot(data = mpg) + 
  geom_area(aes(x = class, y = hwy))

## Try example of ?geom_area: 

# Generate data
huron <- data.frame(year = 1875:1972, level = as.vector(LakeHuron))
h <- ggplot(huron, aes(year))

h + geom_ribbon(aes(ymin = 0, ymax = level))
h + geom_area(aes(y = level))

# Add aesthetic mappings
h +
  geom_ribbon(aes(ymin = level - 1, ymax = level + 1), fill = "grey70") +
  geom_line(aes(y = level))


## 2. Run this code in your head and predict what the output will look like. 
##    Then, run the code in R and check your predictions: 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

## 3. What does show.legend = FALSE do? What happens if you remove it?
##    Why do you think I used it earlier in the chapter?

## `show.legend = FALSE` hides/removes legend. 
## Removing the legend creates (almost) the same plot as before (with group = drv).
## Removing the command automatically adds a legend. 

## 4. What does the se argument to geom_smooth() do?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = TRUE)

## 5. Will these two graphs look different? Why/why not?
## They should look the same, as the 1st is an 
## abbreviated/generalized version of the 2nd. 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

## 6. Recreate the R code necessary to generate the following graphs.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() + 
  geom_smooth(se = FALSE) 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() + 
  geom_smooth(mapping = aes(group = drv), se = FALSE) 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_point() + 
  geom_smooth(mapping = aes(group = drv), se = FALSE) 

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_smooth(mapping = aes(x = displ, y = hwy), se = FALSE) 

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv), se = FALSE) 

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, fill = drv), shape = 21, size = 3, color = "white", stroke = 1.5)



## 3.7 Statistical transformations ------ 

## The diamonds data set: 
head(diamonds)
dim(diamonds)
?diamonds 

## Bar graph: 
?geom_bar

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

## Note: count variable is being calculated.

## The algorithm used to calculate new values for a graph 
## is called a stat, short for statistical transformation.

## You can learn which stat a geom uses by inspecting the default value 
## for the stat argument. For example, ?geom_bar shows that the default 
## value for stat is “count”, which means that geom_bar() uses stat_count(). 
## stat_count() is documented on the same page as geom_bar(), and 
## if you scroll down you can find a section called “Computed variables”. 
## That describes how it computes 2 new variables: count and prop.

?geom_bar

## You can generally use geoms and stats interchangeably. 
## For example, you can recreate the previous plot using 
## stat_count() instead of geom_bar():

ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut, y = ..prop.., group = 1))

## This works because every geom has a default stat; 
## and every stat has a default geom. 
## This means that you can typically use geoms without worrying about 
## the underlying statistical transformation. 


## There are 3 reasons you might need to use a stat explicitly:
  
## 1. You might want to override the default stat. 
##    In the code below, I change the stat of geom_bar() from count 
##    (the default) to identity. This lets me map the height of the 
##    bars to the raw values of a y variable.

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)
demo
ggplot(data = demo) +
  geom_bar(mapping = aes(x = cut, y = freq), 
           stat = "identity")


## 2. You might want to override the default mapping from 
##    transformed variables to aesthetics. 
## For example, you might want to display a bar chart of proportion, 
## rather than count:

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, group = 1)) # default: y = ..count..

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group = 1))


## 3. You might want to draw greater attention to the statistical 
## transformation in your code. 
## For example, you might use stat_summary(), which summarises 
## the y values for each unique x value, to draw attention to the 
## summary that you’re computing:

ggplot(data = diamonds) + 
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

## ggplot2 provides over 20 stats for you to use. 
## Each stat is a function, so you can get help in the usual way, 
## (e.g., ?stat_bin). 
## To see a complete list of stats, try the ggplot2 cheatsheet.

## 3.7.1 Exercises ------ 

## 1. What is the default geom associated with stat_summary()? 
##    How could you rewrite the previous plot to use that geom function 
##    instead of the stat function?
  
?stat_summary # => geom = "pointrange"

ggplot(data = diamonds) + 
    geom_pointrange(mapping = aes(x = cut, y = depth, ymin = depth, ymax = depth))


## Solution from 
# https://jrnold.github.io/r4ds-exercise-solutions/visualize.html#exercise-1-3 

# The default geom for stat_summary is geom_pointrange (see the stat) argument.

# But, the default stat for geom_pointrange is identity, so use
# geom_pointrange(stat = "summary"):

ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary")

# The default message says that stat_summary uses the mean and sd to calculate
# the point, and range of the line. So lets use the previous values of fun.ymin,
# fun.ymax, and fun.y:

ggplot(data = diamonds) +
  geom_pointrange(
    mapping = aes(x = cut, y = depth),
    stat = "summary",
    fun.ymin = min,
    fun.ymax = max,
    fun.y = median
  )

## 2. What does geom_col() do? How is it different to geom_bar()?

?geom_col

## From help: 
# There are two types of bar charts: 
# 1. geom_bar makes the height of the bar proportional to the number of cases in each group 
#    (or if the weight aethetic is supplied, the sum of the weights). 
# 2. If you want the heights of the bars to represent values in the data, use 
#    geom_col instead. 
# 
# Difference: 
# - geom_bar uses stat_count by default: it counts the number of cases at each x position. 
# - geom_col uses stat_identity: it leaves the data as is.

## Example using demo (defined above):
## demo

ggplot(data = demo) +
  geom_col(mapping = aes(x = cut, y = freq))

## 3. Most geoms and stats come in pairs that are almost always used in concert. 
##    Read through the documentation and make a list of all the pairs. What do they have in common?

## ... [Check some examples.]


## 4. What variables does stat_smooth() compute? What parameters control its behaviour?

?stat_smooth

## Computed variables: 
# y    ... predicted value
# ymin ... lower pointwise confidence interval around the mean
# ymax ... upper pointwise confidence interval around the mean
# se   ... standard error 

# Aesthetics

# geom_smooth understands the following aesthetics (required aesthetics are marked with *):
# x*
# y*
# alpha
# colour
# fill
# group
# linetype
# size
# weight

ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price)) + 
  geom_smooth(mapping = aes(x = carat, y = price))



## 3.8 Position adjustments ------ 

## There’s one more piece of magic associated with bar charts. 
## You can colour a bar chart using either the colour aesthetic, 
## or, more usefully, fill:

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

## Note what happens if you map the fill aesthetic to another variable, 
## like clarity: the bars are automatically stacked. 
## Each colored rectangle represents a combination of cut and clarity: 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

## The stacking is performed automatically by the position adjustment 
## specified by the position argument. If you don’t want a stacked bar chart, 
## you can use one of three other options: "identity", "dodge" or "fill".

## 1. position = "identity" will place each object exactly where it falls 
## in the context of the graph. This is not very useful for bars, because 
## it overlaps them. To see that overlapping we either need to make the bars 
## slightly transparent by setting alpha to a small value, 
## or completely transparent by setting fill = NA.

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

## The identity position adjustment is more useful for 2d geoms, 
## like points, where it is the default. 

## 2. position = "dodge" places overlapping objects directly 
## beside one another. This makes it easier to compare individual values: 

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")

## There’s one other type of adjustment that’s not useful for bar charts, 
## but it can be very useful for scatterplots. Recall our first scatterplot. 
## Did you notice that the plot displays only 126 points, even though there 
## are 234 observations in the dataset?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "identity")

## The values of hwy and displ are rounded so the points appear on a grid 
## and many points overlap each other. This problem is known as overplotting. 
## This arrangement makes it hard to see where the mass of the data is. 
## Are the data points spread equally throughout the graph, or is there 
## one special combination of hwy and displ that contains 109 values?

## You can avoid this gridding by setting the position adjustment to “jitter”. 
## position = "jitter" adds a small amount of random noise to each point. 
## This spreads the points out because no two points are likely to receive 
## the same amount of random noise: 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

## Adding randomness seems like a strange way to improve your plot, 
## but while it makes your graph less accurate at small scales, it makes 
## your graph more revealing at large scales. 

## Because this is such a useful operation, ggplot2 comes with a 
## shorthand for geom_point(position = "jitter"): geom_jitter().

ggplot(data = mpg) + 
  geom_jitter(mapping = aes(x = displ, y = hwy))

## To learn more about a position adjustment, look up the help page 
## associated with each adjustment: 

?position_dodge
?position_fill 
?position_identity 
?position_jitter 
?position_stack


## 3.8.1 Exercises ------

# 1. What is the problem with this plot? How could you improve it?

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()

## Problem: overplotting.
## Solution 1) jittering: 

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter")

## Solution 2) transparency:

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(color = "steelblue4", alpha = 2/5, size = 4) + 
  theme_light()

## Combining 1) and 2):

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = "jitter", color = "steelblue4", alpha = 2/5, size = 2) + 
  theme_light()

## Solution 3) Using geom_count to map frequency to point size:

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count(color = "steelblue4") + 
  theme_light()

## 2. What parameters to geom_jitter() control the amount of jittering?

?geom_jitter

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_jitter(color = "steelblue4", alpha = 2/5, size = 2, width = .2, height = .4) + 
  theme_light()


## 3. Compare and contrast geom_jitter() with geom_count(). 

?geom_count

## geom_count is a variant geom_point that counts the number of observations 
## at each location, then maps the count to point area. 
## It useful when you have discrete data and overplotting: 

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_count(color = "steelblue4") + 
  theme_light()


## 4. What’s the default position adjustment for geom_boxplot()? 
##    Create a visualisation of the mpg dataset that demonstrates it.

?geom_boxplot

mpg

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = manufacturer, y = hwy, color = manufacturer), position = "dodge", outlier.colour = "firebrick") +
  geom_jitter(mapping = aes(x = manufacturer, y = hwy), width = .2, alpha = 2/5) + 
  theme_bw()




## 3.9 Coordinate systems ------ 

# Coordinate systems are probably the most complicated part of ggplot2. 
# The default coordinate system is the Cartesian coordinate system [test.quest]
# where the x and y positions act independently to determine 
# the location of each point. 

# There are a number of other coordinate systems that are occasionally helpful: 

## A. coord_flip() ---- 
# switches the x and y axes. 
# This is useful (for example), if we want horizontal boxplots. 
# It’s also useful when labels are long: it’s hard to get them to fit 
# without overlapping on the x-axis: 

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  coord_cartesian() + # = default
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = manufacturer, y = hwy, color = manufacturer), position = "dodge", outlier.colour = "firebrick") +
  geom_jitter(mapping = aes(x = manufacturer, y = hwy), width = .2, alpha = 2/5) + 
  theme_bw() + 
  coord_flip()  # no longer: coord_cartesian() [default]

## B. coord_quickmap() ----
# sets the aspect ratio correctly for maps: 

install.packages("maps")
library(maps)
?maps

nz <- map_data("nz")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black")

ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", colour = "black") +
  coord_quickmap()

## C. coord_polar() ----
# uses polar (circular) coordinates. 
# Polar coordinates reveal an interesting connection 
# between a bar chart and a Coxcomb chart.

bar <- ggplot(data = diamonds) + 
  geom_bar(
    mapping = aes(x = cut, fill = cut), 
    show.legend = FALSE,
    width = 1
  ) + 
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)

bar  # bar chart (with 1:1 aspect ratio)
bar + coord_flip()  # Coxcomb chart
bar + coord_polar() # polar chart


## 3.9.1 Exercises ------ 

## 1. Turn a stacked bar chart into a pie chart using coord_polar():

## Note: geom_pie does not exist [test.quest].

mpg

stack.bar <- ggplot(data = mpg, mapping = aes(x = "", y = hwy, fill = drv)) +
  geom_bar(stat = "identity") +
  theme_light()

stack.bar

stack.bar +
  coord_polar("y", start = 0)

## See solutions in help of 
?coord_polar

#' # A pie chart = stacked bar chart + polar coordinates
pie <- ggplot(mtcars, aes(x = factor(1), fill = factor(cyl))) +
  geom_bar(width = 1)

pie + coord_polar(theta = "y")

# A coxcomb plot = bar chart + polar coordinates
cxc <- ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar(width = 1, colour = "black")
cxc + coord_polar()

# A new type of plot?
cxc + coord_polar(theta = "y")

# The bullseye chart
pie + coord_polar()

## Pac man pie:  
## (based on Hadley's favourite pie chart): 
df <- data.frame(
  variable = c("ghost", "pac man"),
  value = c(20, 80)
)

ggplot(df, aes(x = "", y = value, fill = variable)) +
  geom_col(width = 1) +
  scale_fill_manual(values = c("black", "yellow")) +
  coord_polar("y", start = 2.2) +
  labs(title = "Pac man", x = NULL, y = NULL) +
  theme_minimal()

## [test.quest]: German election results
{
  ## (a) Create a data frame or tibble:
  
  df <- data.frame(
    party = c("CDU", "SPD", "others"),
    share = c(.33, .20, (1 - .33 - .20))
  )
  df$party <- factor(df$party, levels = c("CDU", "SPD", "others"))
  head(df)
  
  ## (b) Create a stacked bar chart:
  
  bp <- ggplot(data = df, mapping = aes(x = "", y = share, fill = party)) +
    geom_bar(stat = "identity") + 
    scale_fill_manual(values = c("black", "red3", "gold")) + 
    theme_bw()
  bp
  
  ## (c) Create a pie chart:
  
  pie <- bp + coord_polar("y", start = 0)
  pie
  }

## Note: 
## See section customized pie charts in 
## http://www.sthda.com/english/wiki/ggplot2-pie-chart-quick-start-guide-r-software-and-data-visualization
## - creating blank theme
## - adding text to pie


## 2. What does labs() do? Read the documentation.

?labs()

## Modify axis, legend, and plot labels

## Good labels are critical for making your plots accessible to a wider audience. 
## Ensure the axis and legend labels display the full variable name. 
## Use the plot title and subtitle to explain the main findings. 
## It's common to use the caption to provide information about the data source.

mtcars

p <- ggplot(data = mtcars, aes(x = mpg, y = wt, colour = cyl)) + geom_point()
p + labs(colour = "Cylinders")
p + labs(x = "Miles per gallon")

# The plot title appears at the top-left, with the subtitle
# display in smaller text underneath it
p + labs(title = "New plot title")
p + labs(title = "New plot title", subtitle = "A subtitle")

# The caption appears in the bottom-right, and is often used for
# sources, notes or copyright
p + labs(caption = "(based on data from ...)")


## 3. What’s the difference between coord_quickmap() and coord_map()?

?coord_quickmap

# coord_map projects a portion of the earth, which is approximately spherical, 
# onto a flat 2D plane using any projection defined by the mapproj package. 
# Map projections do not, in general, preserve straight lines, so this requires 
# considerable computation. 
# coord_quickmap is a quick approximation that does preserve straight lines. 
# It works best for smaller areas closer to the equator.


## 4. What does the plot below tell you about the relationship between 
##    city and highway mpg? 
##    Why is coord_fixed() important? What does geom_abline() do?

?mpg

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() + 
  geom_abline() +
  coord_fixed()

## Interpretation: miles per gallon on hwy > miles per gallon in city (for ALL cars)

?geom_abline # adds reference line to plot
?coord_fixed # fixes aspect ratio (to 1 by default) ==> angle of reference line is 45 degrees to both x- and y-axes

## make clearer plot:

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count(color = "steelblue4") + 
  geom_abline(color = "firebrick") +
  coord_fixed() +
  theme_light()


## 3.10 The layered grammar of graphics ------ 

## General template:

# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>, 
#     position = <POSITION>
#   ) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>

# +++ here now +++ -----

## Appendix: Additional resources on ggplot ------

## Chapter 28 of r4ds: 

# Chapter 28: of current book <http://r4ds.had.co.nz>:
# Graphics for communication: http://r4ds.had.co.nz/graphics-for-communication.html 

## Online:

# - See ggplot2 cheatsheet at https://www.rstudio.com/resources/cheatsheets/

# - R graph catalog: A shiny app showing 100+ ggplot graphs + code: 
#   http://shiny.stat.ubc.ca/r-graph-catalog/ 
#   A complement to “Creating More Effective Graphs” by Naomi Robbins.

# - ggplot2 extensions: https://www.ggplot2-exts.org
#   Notable extenstions include: cowplot, ggmosaic. 

## Books: 

# 1. ggplot2 book by Hadley Wickham:  
#    ggplot2: Elegant Graphics for Data Analysis (Use R!) 2nd ed. 2016 Edition 
#    https://amzn.com/331924275X. 

# 2. R Graphics Cookbook by Winston Chang: 
#    Parts are available at http://www.cookbook-r.com/Graphs/ 

# 3. Graphical Data Analysis with R, by Antony Unwin
#    https://www.amazon.com/dp/1498715230/ref=cm_sw_su_dp 


## ------
## eof.