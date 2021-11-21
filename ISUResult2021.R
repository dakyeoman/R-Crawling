library(stringr)
isu_olympic <- NULL

#url <- c("https://live.isuresults.eu/events/2014_RUS_0001/schedule", "https://live.isuresults.eu/events/2018_KOR_0001/schedule","https://live.isuresults.eu/events/2010_CAN_0002/schedule")
for (i in 1:12){
  url_2010 <- paste0("https://live.isuresults.eu/events/2010_CAN_0002/competition/", i, "/results")
  url_2014 <- paste0("https://live.isuresults.eu/events/2014_RUS_0001/competition/", i, "/results")
  #url_2018 <- paste0("https://live.isuresults.eu/events/2018_KOR_0001/competition/", i, "/results")
  
  b <- readLines(url, encoding = "UTF-8")
  
  data <- cbind(url_2010) #->one matrix
  isu_olympic <- rbind(isu_olympic, data) #각 행렬이 가진 열의 개수가 일치하지 않음(Data에서 에러)
}

head(url_2010)
url_2010
head(isu_olympic)
dim(isu_olympic)
