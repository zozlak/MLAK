context('raport')

test_that('generuje sie R2', {
  unlink(paste0('dane/', dir('dane', '^R2-.*[.]pdf$')))
  generujRaporty(
    plikSzablonu   = 'dane/R2.Rmd', 
    dane           = 'dane/R2-dane.RData',
    grupyOdbiorcow = 'dane/R2-odbiorcy.RData',
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
    dane           = wczytajDane('dane/R3-dane.csv'),
    grupyOdbiorcow = wczytajDane('dane/R3-odbiorcy.csv'),
    katalogWy      = '', 
    prefiksPlikow  = 'R3-',
    ramkiTablic    = TRUE,
    kontynuujPoBledzie = TRUE
  )
  expect_equal(length(dir('dane', '^R3-.*[.]pdf$')), 5)
  unlink(paste0('dane/', dir('dane', '^R3-.*[.]pdf$')))
})
