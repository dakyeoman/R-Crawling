library(stringr)
dc_data <- NULL
for(i in 1:10){ 
  url <- paste0("https://gall.dcinside.com/board/lists/?id=superidea&page=", i)
  Sys.sleep(runif(1)*2)
  b <- readLines(url, encoding = "UTF-8")
  
  
  #제목/url
  index <- which(str_detect(b, "gall_tit ub-word"))[-1]
  b2 <- b[index+1]
  title <- str_trim(str_extract(b2, ("(?<=</strong>).*(?=</a>)")))
  con_url <- str_sub(str_extract(b2, ("(?<=a href=).*(?=em class)")), 3, end = -17)
  con_url2 <- paste0("https://gall.dcinside.com/", con_url) 
  
  
  #조회수
  hit_index <- which(str_detect(b, "gall_count"))[-1]
  hit <- as.numeric(str_sub(str_extract(b[hit_index], ("(?<=gall_count).*(?=</td>)")), 3))
  hit
  
  #추천수
  rec_index <- which(str_detect(b, "gall_recommend"))[-1]
  rec <- as.numeric(str_extract(b[rec_index], ("(?<=gall_recommend\">).*(?=</td>)")))
  data <- cbind(title, con_url2, hit, rec) #->one matrix
  dc_data <- rbind(dc_data, data)
  cat("\n", i)
}
url
head(dc_data)
dim(dc_data)
setwd("/Users/adrua/Desktop/R-Crawling_new/R-Crawling/")
write.csv(dc_data, "dc_data.csv", row.names = F)








#(2)
#gallview_contents<!--  본문 우측 광고 -->

data <- read.csv("dc_data.csv")
head(data)
dim(data)

url <- as.character(data$con_url2);url
length(url)
i <- 1
contents <- c()
for(i in 1:length(url)){
  b <- readLines(url[i], encoding = "UTF-8")
  
  #Sys.sleep(runif(1)*2)
  
  b2 <- b[which(str_detect(b, "gallview_contents")):which(str_detect(b, " 본문 우측 광고 "))]
  b3 <- paste(b2, collapse = " ");b3
  b4 <- gsub("<.*?>", "", b3);b4
  b5 <- gsub("\t|&nbsp;", "", b4) ; b5
  con <- str_trim(b5);con
  contents <- c(contents, con)
  cat("\n", i)
}
head(contents)
dim(data)
dim(contents)

data2 <- cbind(data, contents) ##에러
write.csv(data2, "dc.csv", row.names = F) ##이거 아닌 것 같은데. 

