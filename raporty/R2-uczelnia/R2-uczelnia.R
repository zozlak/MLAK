devtools::load_all()

dane = read.csv2('raporty/R2-uczelnia/dane.csv', stringsAsFactors = F)
katalog = 'raporty'
szablon = 'raporty/R2-uczelnia/R2-uczelnia.Rmd'
prefiks = 'R2-'

# grupy odbiorców
grupy = list(
  '1_etap' = list(
    'grupaGl' = dane$STOPIEN %in% 1 & dane$ROKSTART %in% 2007,
    'stStopienN' = 1,
    'stStopienS' = '1 stopnia',
    'stRok' = 2007
  ),
  '2_etap' = list(
    'grupaGl' = dane$STOPIEN %in% 2 & dane$ROKSTART %in% 2010,
    'stStopienN' = 2,
    'stStopienS' = '2 stopnia',
    'stRok' = 2010
  )
)

generujRaporty(szablon, dane, grupy, katalog, prefiks)

