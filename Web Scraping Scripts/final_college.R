library(xml2)
library(rvest)
library(stringr)
library(selectr)
library(magrittr)

#Get all college FBS teams and conferences

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

#Get recruiting rankings for years 2000-2019
year<-seq(2000,2019, by=1)

for (i in year) {
  url<-paste("https://247sports.com/Season/", i, "-Football/CompositeTeamRankings/", sep="")
  webpage <-read_html(url)
  rank_html <- html_nodes(webpage, '.primary')
  rank <- as.numeric(html_text(rank_html))
  head(rank)
  
  team_html <- html_nodes(webpage, '.rankings-page__name-link')
  team <- html_text(team_html)
  head(team)
  
  recruiting_data <- data.frame(rank, team)
}
