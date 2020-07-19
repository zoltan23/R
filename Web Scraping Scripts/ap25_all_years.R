library(xml2)
library(rvest)
library(stringr)
library(selectr)
library(magrittr)

working_dir <- getwd()

year <- seq(2006, 2019, by = 1)



for (i in year) {
  url <- paste("https://en.wikipedia.org/wiki/", i, "_NCAA_Division_I_FBS_football_rankings", sep = "")
  
  webpage <- read_html(url)
  rank_html <- html_nodes(webpage, 'tbody')
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[3:6] %>%
    html_table(header = FALSE, fill = TRUE)
  
  ap25 <- data.frame(tbls_ls[1])  
  ap25 <- ap25[-c(1,27,28), ]
  ap25 <- data.frame(ap25$X1, ap25$X17)
  ap25 <- ap25[with(ap25, order(ap25.X17)), ]
  
  col_name1 <- paste0('rank', i)
  col_name2 <- paste0('team', i)
  df_temp <- data.frame(ap = ap25)  #the new column you want to add
  names(df_temp) <- c(col_name1, col_name2)
  #colnames(df_temp) <- col_name       #change the column name 
  if (i == 2006){
    df_final <- df_temp
  } else{
    df_final <- cbind(df_final,df_temp)
  }
 df_final[2] <- str_replace(df_final$team2019, "\\(.+", "")
  
}

# df_final$team2019 <- str_replace(df_final$team2019, "\\(.+", "")
# trimws(df_final$team2019)


#write.table(rankings_data, paste("E:/USB/Web Scraped Datasets/Rankings/Rankings by Team by Year/rankings_teamtxt",sep=""), sep=" ", row.names = FALSE, append = FALSE)
