#Put recruiting rankings for all years into one file
packagesList <- c("xml2", "rvest", "stringr", "selectr")
install.packages(packagesList)
lapply(packagesList, require, character.only = TRUE)

working_dir <- paste(getwd(), "/datasets", sep = "")
dir.create(file.path(working_dir, "/recruiting"), showWarnings = FALSE)
setwd(paste(working_dir, "/Recruiting", sep = ""))

years <- seq(2001, 2019, by = 1)

#Create an empty list to be filled with the dataframes
dfList = list()

for (i in years) {
  url <- paste("https://247sports.com/Season/", i, "-Football/CompositeTeamRankings/", sep = "")
  webpage <-read_html(url)
  rank_html <- html_nodes(webpage, '.primary')
  rank <- as.numeric(html_text(rank_html))
  
  team_html <- html_nodes(webpage, '.rankings-page__name-link')
  team <- html_text(team_html)
 
  year = i
  year = as.character(year)
  
  df <- data.frame(rank, team)
 
  names(df)[1] <- paste("rank", year, sep = "")
  
  dfList <- append(dfList, list(df))
}

combined <- Reduce(function(d1, d2) merge(d1, d2, by = "team", all.x = TRUE, all.y = FALSE),  dfList)

#write.table(recruiting_data, paste0("recruiting_rankings", i, ".csv"), sep = ", ", row.names = FALSE, append = FALSE)
