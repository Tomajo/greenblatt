library(rvest)
library(stringr)
library(tidyverse)



url_1<- "http://www.stockpup.com/data"
url_2<- "http://www.stockpup.com"
planaHtml<-url_1 %>% read_html()
noms_Stock<-planaHtml %>% html_nodes("div.col-md-4.col-md-offset-1") %>% html_nodes("p")%>% html_nodes("b") %>% html_text()

urls_Stock<-planaHtml %>% html_nodes("div.col-md-4.col-md-offset-1") %>% html_nodes("p")%>%html_nodes("a")%>%html_attr("href")

urls_Stock<-urls_Stock[grep(x = urls_Stock,pattern = ".csv")]
urls_nom_Stock<-str_extract(pattern = "(?<=/data/)[:alnum:]+(?=_)",urls_Stock)

stocks<-data.frame(noms_Stock,urls_nom_Stock,urls_Stock) 
#trec alguns valors que no em quadra el nom amb la url.
#Trec els NAs, i trec els duplicats.
#Faltaria fer test d'aquest casos i control de qualitat dels altres.
stocks<-stocks[as.character(stocks$noms_Stock)==as.character(stocks$urls_nom_Stock),]
stocks<-stocks[!is.na(stocks$noms_Stock),]
stocks<-stocks[!duplicated(stocks$noms_Stock),]
dades_Quatrimestrals_Stocks<-data.frame()
for(valor in stocks$noms_Stock){
    dades_stock<-read.csv(url(paste0(url_2,stocks[stocks$noms_Stock==valor,]$urls_Stock)))
    dades_stock<-merge(valor,dades_stock)
    dades_Quatrimestrals_Stocks<-rbind(dades_Quatrimestrals_Stocks,dades_stock)
}
# Save an object to a file
saveRDS(dades_Quatrimestrals_Stocks, file = "data/dadesStocks")
