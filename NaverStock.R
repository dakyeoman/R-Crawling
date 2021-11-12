

#install.packages("htmltab")
library(htmltab)

url <- "https://finance.naver.com/item/sise_day.naver?code=036570&page=1"
htmltab(url, encoding = "UTF-8")
b
