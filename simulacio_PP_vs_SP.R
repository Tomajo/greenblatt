library(ggplot2)
library(dplyr)

df_capital_sp <- data.frame()
df_capital_pp <- data.frame()
for(j in 1:10000){
    capital_sp <- 40000
    capital_pp <- 40000
    c_cagr_sp <- rnorm(n = 20,mean = 1.093,sd = 0.167)
    i <- 1L
    for(i in 1:length(c_cagr_sp)){
        capital_sp <- capital_sp*c_cagr_sp[i] +  5000*(1.002)^i
    }
    df_capital_sp <- rbind(df_capital_sp,c(j,capital_sp))
    colnames(df_capital_sp) <- c("sim","capital_final")
    
    c_cagr_pp <- rnorm(n = 20,mean = 1.089,sd = 0.078)
    i <- 1
    for(i in 1:length(c_cagr_pp)){
        capital_pp <- capital_pp*c_cagr_pp[i] + 5000*(1.002)^i
    }
    df_capital_pp <- rbind(df_capital_pp,c(j,capital_pp))
    colnames(df_capital_pp) <- c("sim","capital_final")
    

}
summary(df_capital_sp)
summary(df_capital_pp)

df_capital_sp$cartera <- "SP500"
df_capital_pp$cartera <- "PermanentPortfolio" 
df_compara <- rbind(df_capital_pp,df_capital_sp)



ggplot(df_compara,aes(x = capital_final, fill = cartera)) + geom_density(alpha=0.25)
# ggplot(df_capital_sp,aes(x=capital_final)) + geom_density(alpha=0.25)

