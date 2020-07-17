packagesList <- c("rvest", "stringr", "selectr", "magrittr")

lapply(packagesList, require, character.only = TRUE)

working_dir <- getwd()

year <- seq(1999,2019, by = 1)

for (i in year) {
  url <- paste("https://247sports.com/Season/", i, "-Football/CompositeTeamRankings/", sep="")
  webpage <- read_html(url)
  rank_html <- html_nodes(webpage, '.primary')
  rank <- as.numeric(html_text(rank_html))
  head(rank)
  
  team_html <- html_nodes(webpage, '.rankings-page__name-link')
  team <- html_text(team_html)
  head(team)
  
  stars543_html <- html_nodes(webpage, '.star-commits-list')
  stars543 <- html_text(stars543_html)
  head(stars543)
  
  avg_html <- html_nodes(webpage, '.avg')
  avg <- html_text(avg_html)
  avg <- as.numeric(avg[2:length(avg)])
  head(avg)
  
  stars <- str_squish(gsub("5-Star|4-Star|3-Star|", "", stars543))
  stars5 <- as.numeric(str_sub(stars, 1, 1))
  stars4 <- as.numeric(str_sub(stars, 3, 4))
  stars3 <- as.numeric(str_sub(stars, start = -2))
  
  recruiting_data <- data.frame(rank, team, stars5, stars4, stars3, avg)
  #write.table(recruiting_data, paste(working_dir , "/datasets/college", i, ".txt", sep = ""), row.names = FALSE, sep = " ")
}

