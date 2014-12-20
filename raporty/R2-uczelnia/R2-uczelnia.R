library(PEJK)

generujRaporty(
  plikSzablonu   = 'raporty/R2-uczelnia/R2-uczelnia.Rmd', 
  dane           = 'raporty/R2-uczelnia/dane.csv',
  grupyOdbiorcow = 'raporty/R2-uczelnia/grupy_odbiorców.csv',
  katalogWy      = 'raporty', 
  prefiksPlikow  = 'R2-'
)
