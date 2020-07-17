library(xml2)
library(rvest)
library(stringr)
library(selectr)
library(magrittr)

year <- seq(2005, 2019, by = 1)

for (i in year) {
  url <- paste("https://en.wikipedia.org/wiki/", i, "_NCAA_Division_I_FBS_football_rankings", sep = "")
  
  webpage <- read_html(url)
  rank_html <- html_nodes(webpage, 'tbody')
  tbls_ls <- webpage %>%
    html_nodes("table") %>%
    .[3:6] %>%
    html_table(header = FALSE, fill = TRUE)

   ap25 <- data.frame(tbls_ls[1])  
   ap25 <- ap25[-c(1,27,28),]
   ap25 <- data.frame(ap25$X1, ap25$X17)
   ap25 <- ap25[with(ap25, order(ap25.X17)), ]
   
   coaches25 <- data.frame(tbls_ls[2])  
   coaches25 <- coaches25[-c(1,27,28),]
   coaches25 <- data.frame(coaches25$X1, coaches25$X17)
   coaches25 <- coaches25[with(coaches25, order(coaches25.X17)), ]
   
   harris25 <- data.frame(tbls_ls[3])  
   harris25 <- harris25[-c(1,27,28),]
   harris25 <- data.frame(harris25$X1, harris25$X12)
   
   bcs25 <- data.frame(tbls_ls[4])
   bcs25 <- bcs25[-c(1,27,28),]
   bcs25 <- data.frame(bcs25$X1, bcs25$X9)
   
   rankings_data <- cbind(ap25, coaches25, harris25, bcs25)
   
   write.table(rankings_data, paste(working_dir, "/datasets/rankings", i, ".txt", sep = ""), sep = " ")
  }  


  
