library(ggplot2)

sim_rentabilitat <- function(numero_sim,anys,capital_inicial,rentabilitat_mitja,rentabilitat_desviacio_std, aportacio_mes, inflacio_mitja, inflacio_std, comisio_fons){
    df_renta <- data.frame()
    for(i in 1:numero_sim){
        c_rentabilitat <- rnorm(n = anys,mean = rentabilitat_mitja, sd = rentabilitat_desviacio_std)
        c_inflacio <- rnorm(n = anys,mean = inflacio_mitja, sd = inflacio_std)
        capital <- capital_inicial
        for(i_renta in 1:length(c_rentabilitat)){
            coef_inflacio <- (100 - c_inflacio[i_renta])/100
            coef_comisio <- (100 - comisio_fons)/100
            #print(coef_inflacio)
            capital <- (capital*c_rentabilitat[i_renta]*coef_inflacio) + (12*aportacio_mes)*((1+mean(c_inflacio[1:length(c_rentabilitat)])/100)^i_renta)
            #print(paste0("Factor perdua poder adquisitiu: ",coef_inflacio))
            #print(paste0("Factor estavi: ",(1+mean(c_inflacio[1:i_renta])/100)^i_renta))
        }
        df_renta <- rbind(df_renta,c(i,capital))
    }
    colnames(df_renta) <- c("sim","capital")
    return(df_renta)
}

df_cobas <- sim_rentabilitat(numero_sim = 15000,anys = 20,
                             capital_inicial = 30000,
                             rentabilitat_mitja = 1.16,
                             rentabilitat_desviacio_std = 0.20,
                             aportacio_mes = 700,
                             inflacio_mitja = 2,
                             inflacio_std = 1,
                             comisio_fons = 1.75)
df_SP <- sim_rentabilitat(numero_sim = 15000,anys = 20,
                          capital_inicial = 30000,
                          rentabilitat_mitja = 1.12,
                          rentabilitat_desviacio_std = 0.17,
                          aportacio_mes = 700,
                          inflacio_mitja = 2,
                          inflacio_std = 1,
                          comisio_fons = 0.35)
df_PP <- sim_rentabilitat(numero_sim = 15000,anys = 20,
                          capital_inicial = 30000,
                          rentabilitat_mitja = 1.09,
                          rentabilitat_desviacio_std = 0.07,
                          aportacio_mes = 700,
                          inflacio_mitja = 2,
                          inflacio_std = 1,
                          comisio_fons = 0.35)

df_cobas$nom <- "cobas"
df_SP$nom <- "StandarPoors"
df_PP$nom <- "PermanentPorfolio"

summary(df_cobas)
summary(df_SP)
summary(df_PP)

df_compara <- rbind(df_cobas,df_SP,df_PP)

ggplot(data = df_compara,aes(x = capital, fill = nom)) + geom_density(alpha=0.25) + xlim(c(0,2*10^6))







