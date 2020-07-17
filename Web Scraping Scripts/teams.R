packagesList <- c("rvest", "stringr", "selectr", "magrittr")
install.packages(packagesList)

library(xml2)
library(rvest)
library(stringr)
library(selectr)
library(magrittr)

working_dir <- getwd()

url<- 'https://en.wikipedia.org/wiki/List_of_NCAA_Division_I_FBS_football_programs'
  
webpage <-read_html(url)
teams_html <- html_nodes(webpage, 'tbody')
tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[1] %>%
    html_table(header=FALSE, fill = TRUE)
  
teams<-data.frame(tbls_ls[1])  
teams<-teams[-1,]
teams<-data.frame(teams$X1, teams$X5)

dir.create(file.path(working_dir, "datasets"), showWarnings = FALSE)
  
write.table(teams, paste(working_dir, "/teams.txt", sep = ""), sep = " ", row.names = FALSE ,append = FALSE)

