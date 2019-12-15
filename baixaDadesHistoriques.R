library(rvest)
library(stringr)


url_1<- "http://www.stockpup.com/data"
url_2<- "http://www.stockpup.com"
planaHtml<-url_1 %>% read_html()
noms_Stock<-planaHtml %>% html_nodes("div.col-md-4.col-md-offset-1") %>% html_nodes("p")%>% html_nodes("b") %>% html_text()

urls_Stock<-nomStock<-planaHtml %>% html_nodes("div.col-md-4.col-md-offset-1") %>% html_nodes("p")%>%html_nodes("a")%>%html_attr("href")

urls_Stock<-urls_Stock[grep(x = urls_Stock,pattern = ".csv")]

dades_stock<-read.csv(url(paste0(url_2,urls_Stock[1])))
