

install.packages("httr")
library(htmltab)
library(dplyr)

#일별 시세; 아래 url에서 code=036570가 NC소프트의 종목 코드(참고)
url <- "https://finance.naver.com/item/sise_day.naver?code=036570&page=1"

url<-"http://finance.naver.com/item/sise_day.nhn?code=005380&page=1" # 종목 A

url<-"http://finance.naver.com/item/sise_day.nhn?code=005930&page=1" # 종목B

library(httr)

referer <- add_headers(Referer = "http://finance.naver.com/item/sise_day.nhn?code=005380&page=11") #검색해서 들어간 것처럼 위장하기위해 header를 붙여준다

tmp <- GET(url, referer) # GET함수를 통해 해당 서버에 통신을 함 뒤에 referer인자가 위장술

ta<-read_html(tmp) %>% html_nodes(xpath = '/html/body/table[1]') %>% html_table()

ta2<-(ta[[1]]) 

ta2[-c(1,7,8,9,15),]

htmltab(url, encoding = "UTF-8")
