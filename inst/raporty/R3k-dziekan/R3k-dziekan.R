library(MLAK)

generujRaporty(
  plikSzablonu   = 'raporty/R3k-dziekan/R3k-dziekan.Rmd', 
  dane           = 'raporty/R3k-dziekan/dane.csv',
  grupyOdbiorcow = 'raporty/R3k-dziekan/odbiorcy.csv',
  katalogWy      = 'raporty', 
  prefiksPlikow  = 'R3k-'
)
