context('zainstaluj')

test_that('zainstaluj dziala', {
  katalog = getwd()
  #/home/travis/build/zozlak/MLAK/MLAK.Rcheck/tests/testthat
  #/home/travis/build/zozlak/MLAK/
  setwd(sub('MLAK.Rcheck$', '', sub('/tests/testthat$', '', katalog)))
#  expect_equal(zainstaluj(), TRUE)
  setwd(katalog)
})
