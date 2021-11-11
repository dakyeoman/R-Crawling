
#csv로 저장하고 불러오기
setwd("/Users/adrua/Desktop/R-Crawling_new/R-Crawling")
data <- read.csv("base_data.csv")
head(data)

##R파일로 저장하고 불러오기(리스트)
#save(data, file="base_data.RData")
#load("base_data.RData")

url_list <- data[,3] ;url_list
#url_list[10] , 소스코드에서 post_content / post_ccls에 원문이 있음 
length(url_list)
b <- readLines(as.character(url_list[1]), encoding = "UTF-8")
b

