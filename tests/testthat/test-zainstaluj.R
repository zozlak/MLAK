context('zainstaluj')

test_that('zainstaluj dziala', {
  katalog = getwd()
  expect_equal(katalog, 'aaa')
  setwd(sub('MLAK.Rcheck$', '', sub('/tests/testthat$', '', katalog)))
  expect_equal(zainstaluj(), TRUE)
  setwd(katalog)
})
