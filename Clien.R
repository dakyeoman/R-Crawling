
#csv로 저장하고 불러오기
setwd("/Users/adrua/Desktop/R-Crawling_new/R-Crawling")
data <- read.csv("base_data.csv")
head(data)

##R파일로 저장하고 불러오기(리스트)
#save(data, file="base_data.RData")
#load("base_data.RData")
library(stringr)
url_list <- data[,3]

length(url_list)
content <- c()
for(i in 1:length(url_list)){
  if(class(try(b <- readLines(as.character(url_list[i]), encoding = "UTF-8"))) == "try-error"){
    b6 <- "."
    content <- c(content, b6)
  }else{
    b2 <- b[which(str_detect(b, "post_content")):which(str_detect(b, "post_ccls"))]
    b3 <- paste(b2, collapse = "")
    b4 <- gsub("<.*?>", "", b3)
    b5 <- gsub("\t|&nbsp", "", b4)
    b6 <- str_trim(b5)
    content <- c(content, b6)
    cat("\n", i)
  }
}
head(content)
final_data <- cbind(data, content)
write.csv(final_data, "final_data.csv", row.names = F)

dim(content)



#주석 포함된 코드----------------------------------------------
url_list <- data[,3] 
head(url_list)

#url_list[10] , 소스코드에서 post_content / post_ccls사이에 원문이 있음
length(url_list) #300 출력됨
content <- c()
#for(i in 1:length(url_list)){
  
  ##에러 발생 시 try-error 사용(예외처리)
  
  if(class(try(b <- readLines(as.character(url_list[i]), encoding = "UTF-8"))) =="try-error"){
    b6 <- ""
    content <- c(content, b6)
    #next; 
  }else{
  b2 <- b[which(str_detect(b, "post_content")):which(str_detect(b, "post_ccls"))]
  #출력된 21개 벡터 하나로 합치기 paste(데이터, collapse = 구분자)
  b3 <- paste(b2, collapse = "")
  
  #태그 삭제
  b4 <- gsub("<.*?>", "", b3) #<.*?>: <>사이 모든 것 삭제
  b5 <- gsub("\t|&nbsp;", "", b4)
  
  #앞 뒤 공백 삭제 
  b6 <- str_trim(b5) 
  content <- c(content, b6)
  cat("\n", i)
}
}

head(content)
final_data <- cbind(data, content)
colnames(final_data)









