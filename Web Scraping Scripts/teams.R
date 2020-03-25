library(xml2)
library(rvest)
library(stringr)
library(selectr)
library(magrittr)


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
  
  write.table(teams, paste("E:/USB/Web Scraped Datasets/Teams/teams.txt",sep=""), sep=" ")