## start.R | ds4psy
## hn | uni.kn | 2019 08 08
## ---------------------------

## Open pkg guide: ----------

#' Opens user guide of the ds4psy package. 
#'
#' @import utils
#'
#' @export

ds4psy.guide <- function() {
  
  # utils::vignette(topic = "User Guide", package = "ds4psy")
  utils::browseVignettes(package = "ds4psy")
  
}

## Initialize pkg: ---------- 

.onAttach <- function(libname, pkgname) {
  
  ## Welcome message: ------
  
  pkg_version <- utils::packageVersion("ds4psy", lib.loc = NULL)
  
  # welcome_message <- paste0("Welcome to ds4psy!")
  welcome_message <- paste0("Welcome to ds4psy (v", pkg_version, ")!")
  
  packageStartupMessage(welcome_message)
  
  ## User guidance: ------
  
  ## Roll dice: ------
  dice <- sample(1:6, 1)
  
  if (dice == -77) {
    pkg_version <- utils::packageVersion("ds4psy", lib.loc = NULL)
    pkg_message <- paste0("Running ds4psy (v", pkg_version, ")...")
    
    packageStartupMessage(" ")
    packageStartupMessage(pkg_message)
    packageStartupMessage(" ")
  }
  
  if (dice == -99) {
    packageStartupMessage(" ")
    packageStartupMessage("citation('ds4psy') provides citation info.")
    packageStartupMessage(" ")
  }
  
  ## all cases:
  # packageStartupMessage("ds4psy.guide() opens user guides.")
  
}

## ToDo: ------
## - ...

## eof. ----------
