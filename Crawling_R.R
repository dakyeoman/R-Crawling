a <- c(1, 2, 3)
a[1]
a[-3]
a[2:3]
a[c(T, F, T)]
a[c(T, T, T)]
a[c(F, F, F)]

m <- matrix(c(1, 2, 3, 4, 5, 6), nrow=2, byrow=F);m
m2 <- data.frame(m);m2
m2[1, ]
m2[, 1]
m2[1, c(2, 3)]
m2[c(T, F), c(F, T, T)]
m2$X1

colnames(m2) <- paste0("v", 1:3)
#  v1 v2 v3
#1  1  3  5
#2  2  4  6

#cbind/rbind (행/열 묶음)
cbind(m2, m2)
m3<-rbind(m2, m2, m2, m2) #크롤링에 활용도 높음
m3[m3$v1 ==1, ] #첫번째 행의 값이 1인 열만 출력 
m3[m3[,1] ==1, ] ;m3
m3$v4 <- 1:8 ;m3
m3$v5 <- 2:(nrow(m3)+1) ;m3

ncol(m3)
m3$v6 <- ifelse(m3$v1 %% 2 == 0, "even", "odd");m3

str(m3) #structure
#data의 상위/하위 6개
head(m3)
tail(m3)

m2
m4
 m4 <- NULL
for(i in 1:10){
  m4 <- rbind(m4, m2) 
  cat("\n", i) #"\n" = enter
}

m4
dim(m4)

#install.packages("stringr")
library(stringr)

m3[1, 6] <- "odd123";m3
m3[str_detect(m3$v6, "odd"),]

m3[m3$v6 %in% "odd", ]

setwd("/Users/adrua/Desktop/Crawling_R")
getwd()  

write.csv(m3, "m3.csv", row.names=F) #row.names=F: 행 이름 저장X
m4 <- read.csv("m3.csv")
m4

setwd("/Users/adrua/Desktop/Crawling_R")
file_list <- list.files()

library(stringr)
folder_index <-str_detect(file_list, "R") | str_detect(file_list, "csv") #R or csv 가 들어간 파일명
folder_list <- file_list[!folder_index] #(위) 가 아닌 것 

folder_list
i <- 1
final_data <- NULL

for(i in 1:length(folder_list)){
  
  folder_list[i]
  setwd(paste0("/Users/adrua/Desktop/Crawling_R/",folder_list[i]))
  getwd()
  file_list <- list.files()
  
  j <- 2
  for(j in 1:length(file_list)){
    data <- read.csv(file_list[j])
    final_data <- rbind(final_data, data)
    cat("\n", i, "-", j)
  }
}

head(final_data)
dim(final_data)
str(final_data)



#roof2
setwd("/Users/adrua/Desktop/R-Crawling/")

data <- read.csv("m3.csv")
head(data)
data$v7 <- 1:nrow(data)
write.csv(data, "data.csv", row.names = F)

getwd()
file_list <- list.files()
file_list[-c(1,2)]

folder_index <-str_detect(file_list, "R") | str_detect(file_list, "csv") #R or csv 가 들어간 파일명
folder_list <- file_list[!folder_index] #(위) 가 아닌 것 
folder_list

i <- 1
final_data1 <- NULL
final_data2 <- NULL

for(i in 1:length(folder_list)){
 
  folder_list[i]
  setwd(paste0("/Users/adrua/Desktop/R-Crawling/",folder_list[i]))
  getwd()
  file_list <- list.files()
  
  j <- 2
  for(j in 1:length(file_list)){
   
     data <- read.csv(file_list[j])
    if(ncol(data)==6){
      final_data1 <- rbind(final_data1, data)
      #col수가 6개면 final data로 rbind 시킴. 
    }else{
      final_data2 <- rbind(final_data2, data)
    }
    cat("\n", i, "-", j)  
  }
}

dim(final_data1)
dim(final_data2)


#list------------------
juso<-c("서울시 강북구 변1동", "전라남도 순천시 석현동", "경기도 평택시 지산동");juso

library(stringr)

#리스트 벡터에 접근해보자
aa <- str_split(juso, " ")
seoul <- aa[[1]] #aa 첫번째 큰 방의 벡터 접근
length(seoul)
aa[[2]]
seoul[2]
seoul[-2]
aa[[1]][2]

names(aa) <- c("서울", "전남", "경기")
aa$서울

#리스트 해체 
aa_unlist <- unlist(aa);aa_unlist
length(aa_unlist)

#APPLYL 계열 함수 : apply, sapply, lapply, tapply
apply(data[,-6], 1, sum) # = 행(1)별로 함수(sum)를 적용하겠다
apply(data[,-6], 1, mean)
apply(data[,-6], 2, sum) # = 열(2)별로 함수를 적용하겠다
apply(data[,-6], 2, sum)

data

#각 요소에 대해 함수 적용 
#tapply(적용하려는 칼럼(numeric), 구분하고 싶은 facter값이 있는 칼럼, 적용할 함수)
#v6가even/odd인 것들에 대해 v3의 합계
tapply(data$v3, data$v6, sum) 


#sapply:각각의 큰 방의 벡터에 대해 함수 적용
aa
sapply(aa, length)
first <- function(x){
  x[1] #first(x)에서 데이터 x의 첫번째 작은 방 출력
}

first(aa[[3]]) 
sapply(aa, first)



#lapply: sapply에서 리스트 형태 그대로 출력
lapply(aa, first)

index <- function(x, i) { 
  x[i] #i번째 방 출력 
  }
index(aa[[1]], 2)
sapply(aa, index, 3)

#apply없이 반복문으로 코딩하면 (시간이 굉장히 오래 걸림)
dd <- c() #빈 벡터 선언

for(i in 1: length(aa)){ 
  dd <- c(aa[[i]][1])
  cat("\n", i)
  }


library(stringr)
##클리앙 크롤링
i <- 1
for(i in 1:10){
url <- paste0("https://www.clien.net/service/board/park?&od=T31&category=0&po=0", i= -1)
b <- readLines(url, encoding = "UTF-8") ##or EUC-KR
length(b)
head(b, 30)
tail(b)

#str_extract(b2, "(?<=abc").*(?=ijk)")##abc와 ijk 사이에 있는 텍스트 추출 
#str_extract(data, "(?<=abc).*(?=)")##앞에 abc가 있는 것 추출
#str_extract(data, "(?<=).*(?=i)")##뒤에 i가 있는 것 추출

#제목 추출
b2<- b[str_detect(b, "subject_fixed")]
title <- str_extract(b2, "(?<=title=\").*(?=\">)")


#조회수 추출 
b3<- b[str_detect(b, "<span class=\"hit\">")];b3
b4 <- str_split(b3, "hit\">");b4
##way1

for(i in 1:10){
hit <- str_extract(b3, "(?<=\">).*(?=</span>)")[-1]
#sapply(b4, function(x){x[1]}) #함수 바로 작성 가능 

##way2
#ff<- function(x) {
#   x[2]
# }
# sapply(b4, ff)
# str_sub(sapply(b4, ff), end= -8) #end= -8: 뒤에서 글자 8개를 삭제 *변동 


##url 추출
b5 <- b[which(str_detect(b, "subject_fixed")) -2] 
#which: TRUE값이 있는 index만 추출
#-2 : 소스코드에서 제목 두 줄 앞 

b6 <- str_sub(str_extract(b5, "(?<=href=\").*(?=data-role)"), end = -4)
url <- paste0("https://www.clien.net", b6)

data <- cbind(title, hit, url) 

}

head(data)

