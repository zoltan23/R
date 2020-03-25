#Put rankings for all years into one file
library(xml2)
library(rvest)
library(stringr)
library(selectr)

year<-seq(2000,2019, by=1)

for (i in year) {
  url<-paste("https://247sports.com/Season/", i, "-Football/CompositeTeamRankings/", sep="")
  webpage <-read_html(url)
  rank_html <- html_nodes(webpage, '.primary')
  rank <- as.numeric(html_text(rank_html))
 
  
  team_html <- html_nodes(webpage, '.rankings-page__name-link')
  team <- html_text(team_html)
 
  
  
  year2=i
  year2=as.character(year2)
  
  recruiting_data <- data.frame(rank, team, year2)
  #write.table(recruiting_data, paste("E:/USB/Web Scraped Datasets/rankings.txt",sep=""), sep=" ", append=TRUE)

}
