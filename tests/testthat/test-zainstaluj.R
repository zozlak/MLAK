context('zainstaluj')

test_that('zainstaluj dziala', {
  katalog = getwd()
  setwd(sub('MLAK.Rcheck$', 'MLAK', sub('/tests/testthat$', '', katalog)))
  expect_equal(zainstaluj(), TRUE)
  setwd(katalog)
})
