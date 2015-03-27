context('wykresy')

test_that('wykresSlupkowy', {
  expect_is(wykresSlupkowy(c('a' = 1, 'b' = 2)), 'gg')
  expect_is(wykresSlupkowy(c('a' = '1', 'b' = '2')), 'gg')
  expect_is(wykresSlupkowy(c('a' = ' 1', 'b' = '  2')), 'gg')
  expect_is(wykresSlupkowy(c('a' = '  1%', 'b' = '2')), 'gg')
  expect_error(wykresSlupkowy(c('a' = 'a 1%', 'b' = '2')))
  
  wektor = rep(1:10, 10)
  expect_is(wykresSlupkowy(c('a' = N(wektor, 1), 'b' = N(wektor, 2))), 'gg')
  expect_is(wykresSlupkowy(c('a' = P(wektor, 1), 'b' = P(wektor, 2))), 'gg')
  expect_is(wykresSlupkowy(c('a' = E(wektor))), 'gg')
  expect_is(wykresSlupkowy(c('a' = E(wektor), 'b' = N(wektor, 2))), 'gg')
})

test_that('wykresKolowy', {
  expect_is(wykresKolowy(c('a' = 1, 'b' = 2)), 'gg')
  expect_is(wykresKolowy(c('a' = '1', 'b' = '2')), 'gg')
  expect_is(wykresKolowy(c('a' = ' 1', 'b' = '  2')), 'gg')
  expect_is(wykresKolowy(c('a' = '  1%', 'b' = '2')), 'gg')
  expect_error(wykresKolowy(c('a' = 'a 1%', 'b' = '2')))

  expect_is(wykresKolowyNorm(c('a' = 1, 'b' = 2)), 'gg')
  expect_is(wykresKolowyNorm(c('a' = '1', 'b' = '2')), 'gg')
  expect_is(wykresKolowyNorm(c('a' = ' 1', 'b' = '  2')), 'gg')
  expect_is(wykresKolowyNorm(c('a' = '  1%', 'b' = '2')), 'gg')
  expect_error(wykresKolowyNorm(c('a' = 'a 1%', 'b' = '2')))

  expect_is(wykresKolowyZlicz(c('a' = 1, 'b' = 2)), 'gg')
  expect_is(wykresKolowyZlicz(c('a' = '1', 'b' = '2')), 'gg')
  expect_is(wykresKolowyZlicz(c('a' = ' 1', 'b' = '  2')), 'gg')
  expect_is(wykresKolowyZlicz(c('a' = '  1%', 'b' = '2')), 'gg')
  expect_is(wykresKolowyZlicz(c('a' = 'a 1%', 'b' = '2')), 'gg')
  
  wektor = rep(1:10, 10)
  expect_is(wykresKolowy(c('a' = N(wektor, 1), 'b' = N(wektor, 2))), 'gg')
  expect_is(wykresKolowy(c('a' = P(wektor, 1), 'b' = P(wektor, 2))), 'gg')
  expect_is(wykresKolowyNorm(c('a' = P(wektor, 1), 'b' = P(wektor, 2))), 'gg')
  expect_is(wykresKolowyZlicz(wektor), 'gg')
  expect_is(wykresKolowyZlicz(wektor, c('a', 'b', 'c')), 'gg')
})

test_that('wykresHistogram', {
  expect_is(wykresHistogram(rnorm(100)), 'gg')
})

test_that('polamTekst', {
  expect_is(wykresKolowy(c('bardzo długie etykiety danych' = 1, 'oj, jakie długie etykiety danych' = 2)), 'gg')
  expect_is(wykresKolowy(c('bardzo długie etykiety danych\n' = 1, 'oj, jakie długie etykiety danych\n' = 2)), 'gg')
  expect_is(wykresSlupkowy(c('bardzo długie etykiety danych' = 1, 'oj, jakie długie etykiety danych' = 2)), 'gg')
  expect_is(wykresSlupkowy(c('bardzo długie etykiety danych\n' = 1, 'oj, jakie długie etykiety danych\n' = 2)), 'gg')
})