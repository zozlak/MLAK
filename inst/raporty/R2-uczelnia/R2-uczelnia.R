library(MLAK)

generujRaporty(
  plikSzablonu   = 'inst/raporty/R2-uczelnia/R2-uczelnia.Rmd', 
  dane           = 'inst/raporty/R2-uczelnia/dane.csv',
  grupyOdbiorcow = 'inst/raporty/R2-uczelnia/odbiorcy.csv',
  katalogWy      = 'raporty', 
  prefiksPlikow  = 'R2-'
)
