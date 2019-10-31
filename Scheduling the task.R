## Setting the working dictationary.
setwd("C:/Users/square/Desktop/R_Project")
## Taskscheduler
library(taskscheduleR)

taskscheduler_create(taskname = "r_web_scrapping",
                     rscript = "C:\\Users\\square\\Desktop\\R_Projects\\web_auto_script\\web_scrapping_automating.R",
                     schedule = "MINUTE",
                     starttime = format(Sys.time() + 62, "%H:%M"),
                     startdate = format(Sys.Date(), "%d/%m/%Y"),
                     Rexe = file.path(Sys.getenv("R_HOME"), "bin", "Rscript.exe")
                     )