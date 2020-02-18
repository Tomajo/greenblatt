library(ggplot2)

sim_rentabilitat <- function(numero_sim,anys,capital_inicial,rentabilitat_mitja,desviacio_std){
    df_renta <- data.frame()
    for(i in 1:numero_sim){
        c_rentabilitat <- rnorm(n = anys,mean = rentabilitat_mitja, sd = desviacio_std)
        
        capital <- capital_inicial
        for(i_renta in 1:length(c_rentabilitat)){
            capital <- capital*c_rentabilitat[i_renta]
        }
        df_renta <- rbind(df_renta,c(i,capital))
    }
    colnames(df_renta) <- c("sim","capital")
    return(df_renta)
}

df_cobas <- sim_rentabilitat(10000,30,30000,1.16,0.20)
df_SP <- sim_rentabilitat(10000,30,30000,1.12,0.15)
df_PP <- sim_rentabilitat(10000,30,30000,1.09,0.06)

df_cobas$nom <- "cobas"
df_SP$nom <- "StandarPoors"
df_PP$nom <- "PermanentPorfolio"

df_compara <- rbind(df_cobas,df_SP,df_PP)

ggplot(data = df_compara,aes(x = capital, fill = nom)) + geom_density(alpha=0.25) + xlim(c(0,4*10^6))
