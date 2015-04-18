context('wczytajOdbiorce')

test_that('wczytajOdbiorce dziala z csv', {
  expect_equal(
    wczytajOdbiorce('dane/R3-odbiorcy.csv'),
    list(
      VNKIER = 1, VNSPEC = 1, VTYP = 1, CZYSPEC = 0, VROKSPEC = 0, DATABAZY = '2012-08-10', VILELAT = 3, VROK = 2010, 
      VMIAN = 'Instytut', VDOP = 'Instytutu', VCEL = 'Instytutowi', VBIER = 'Instytut', VNARZ = 'Instytutem', VMIEJSC = 'Instytucie',
      VKIERSPC = 'Socjologii UW, studia dzienne 1 stopnia', V_PRAW = '1 0', V_MUN = '1 1'
    )
  )

  expect_equal(
    wczytajOdbiorce('dane/R3-odbiorcy.csv', n = 2),
    list(
      VNKIER = 2, VNSPEC = 1, VTYP = 4, CZYSPEC = 1, VROKSPEC = 1, DATABAZY = '2012-08-10', VILELAT = 3, VROK = 2010, 
      VMIAN = 'Wydział', VDOP = 'Wydziału', VCEL = 'Wydziałowi', VBIER = 'Wydział', VNARZ = 'Wydziałem', VMIEJSC = 'Wydziale',
      VKIERSPC = 'Nauk Ekonomicznych UW, studia dzienne 1 stopnia, Finanse i Rachunkowość', V_PRAW = '1 0', V_MUN = '1 0'
    )
  )
})

test_that('wczytajOdbiorce dziala z rdata', {
  dane = wczytajOdbiorce('dane/R2-odbiorcy.RData', 'dane/R2-dane.RData')
  expect_is(dane, 'list')
  expect_equal(sapply(dane, length), setNames(c(1, 12505, rep(1, 5), rep(12505, 67)), names(dane)))
  expect_equal(dane[c(1, 3:7)], list(grupa = '1_etap_2007', stStopienN = 1, stStopienS = '1 stopnia', stRok = 2007, stKierunek = 'Wydziału Dziennikarstwa i Nauk Politycznych', stUczelnia = 'UW'))

  dane = wczytajDane('dane/R2-dane.RData')
  dane = wczytajOdbiorce('dane/R2-odbiorcy.RData', dane, 2)
  expect_is(dane, 'list')
  expect_equal(sapply(dane, length), setNames(c(1, 12505, rep(1, 5), rep(12505, 67)), names(dane)))
  expect_equal(dane[c(1, 3:7)], list(grupa = '1_etap_2008', stStopienN = 1, stStopienS = '1 stopnia', stRok = 2008, stKierunek = 'Wydziału Dziennikarstwa i Nauk Politycznych', stUczelnia = 'UW'))
})

test_that('wczytajOdbiorce zglasza bledy', {
  expect_error(wczytajOdbiorce('dane/R2-odbiorcy.RData')) # brak potrzebnych danych kontekstowych
  expect_error(wczytajOdbiorce('dane/nie ma takiego pliku'))
})
