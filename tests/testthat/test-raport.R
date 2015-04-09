context('raport')

test_that('generuje sie R2', {
  generujRaporty(
    plikSzablonu   = 'dane/R2.Rmd', 
    dane           = 'dane/R2-dane.csv',
    grupyOdbiorcow = 'dane/R2-odbiorcy.csv',
    katalogWy      = '', 
    prefiksPlikow  = 'R2-'
  )
  expect_equal(length(dir('dane', '[.]pdf$')), 8)
  unlink(paste0('dane/', dir('dane', '[.]pdf$')))
})

test_that('generuje sie R3', {
  generujRaporty(
    plikSzablonu   = 'dane/R3.Rmd', 
    dane           = wczytajDane('dane/R3-dane.csv'),
    grupyOdbiorcow = wczytajDane('dane/R3-odbiorcy.csv'),
    katalogWy      = '', 
    prefiksPlikow  = 'R3-'
  )
  expect_equal(length(dir('dane', '[.]pdf$')), 5)
  unlink(paste0('dane/', dir('dane', '[.]pdf$')))
})