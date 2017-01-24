context('raport')

test_that('generuje sie R2', {
  unlink(paste0('dane/', dir('dane', '^R2-.*[.]pdf$')))
  generujRaporty(
    plikSzablonu   = 'dane/R2.Rmd', 
    grupyOdbiorcow = 'dane/R2-odbiorcy.RData',
    dane           = c('dane/R2-dane.RData', 'dane/daneMies.RData'),
    katalogWy      = '', 
    prefiksPlikow  = 'R2-',
    ramkiTablic    = FALSE,
    kontynuujPoBledzie = FALSE
  )
  expect_equal(length(dir('dane', '^R2-.*[.]pdf$')), 8)
  unlink(paste0('dane/', dir('dane', '^R2-.*[.]pdf$')))
})

test_that('generuje sie R3', {
  unlink(paste0('dane/', dir('dane', '^R3-.*[.]pdf$')))
  generujRaporty(
    plikSzablonu   = 'dane/R3.Rmd', 
    grupyOdbiorcow = wczytajDane('dane/R3-odbiorcy.csv'),
    dane           = list(wczytajDane('dane/R3-dane.csv'), wczytajDane('dane/daneMies.RData')),
    katalogWy      = '', 
    prefiksPlikow  = 'R3-',
    ramkiTablic    = TRUE,
    kontynuujPoBledzie = TRUE
  )
  expect_equal(length(dir('dane', '^R3-.*[.]pdf$')), 5)
  unlink(paste0('dane/', dir('dane', '^R3-.*[.]pdf$')))
})

test_that('przerywa po bledzie', {
  unlink(paste0('dane/', dir('dane', '^blad-.*[.]pdf$')))
  expect_error(
    generujRaporty(
      plikSzablonu   = 'dane/szablonZBledem.Rmd', 
      grupyOdbiorcow = wczytajDane('dane/R3-odbiorcy.csv'),
      dane           = data.frame(),
      katalogWy      = '', 
      prefiksPlikow  = 'blad-',
      kontynuujPoBledzie = FALSE
    )
  )
  unlink(paste0('dane/', dir('dane', '^blad-.*[.]pdf$')))
})
