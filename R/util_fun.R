## util_fun.R | ds4psy
## hn | uni.kn | 2019 07 28
## ---------------------------

## Utility functions. 

# kill_all: Kill all objects in current environment (without warning): ------

kill_all <- function(){
  
  rm(list = ls())
  
}

# Check: ----
# kill_all()


## ToDo: ----------

## eof. ----------------------