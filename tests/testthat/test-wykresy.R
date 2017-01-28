context('wykresy')
# TODO dopisać testy dla pustych danych

test_that('wykresSlupkowy', {
  expect_is(wykresSlupkowy(c('a' = 1, 'b' = 2)), 'gg')
  expect_is(wykresSlupkowy(c('a' = '1', 'b' = '2')), 'gg')
  expect_is(wykresSlupkowy(c('a' = ' 1', 'b' = '  2')), 'gg')
  expect_is(wykresSlupkowy(c('a' = '  1%', 'b' = '2')), 'gg')
  expect_is(wykresSlupkowy(c('a' = 'a 1%', 'b' = '2')), 'gg') # TODO przerobić na sprawdzanie wygenerowania pustego wykresu
  expect_is(wykresSlupkowy(rep(TRUE, 10)), 'gg') # TODO przerobić na sprawdzanie wygenerowania pustego wykresu
  
  wektor = rep(1:10, 10)
  expect_is(wykresSlupkowy(c('a' = N(wektor, 1), 'b' = N(wektor, 2))), 'gg')
  expect_is(wykresSlupkowy(c('a' = P(wektor, 1), 'b' = P(wektor, 2))), 'gg')
  expect_is(wykresSlupkowy(c('a' = E(wektor))), 'gg')
  expect_is(wykresSlupkowy(c('a' = E(wektor), 'b' = N(wektor, 2))), 'gg')
})

test_that('wykresKolowy', {
  expect_is(wykresKolowy(c(1, 2)), 'gg')
  expect_is(wykresKolowy(c('a' = 1, 'b' = 2)), 'gg')
  expect_is(wykresKolowy(c('a' = '1', 'b' = '2')), 'gg')
  expect_is(wykresKolowy(c('a' = ' 1', 'b' = '  2')), 'gg')
  expect_is(wykresKolowy(c('a' = '  1%', 'b' = '2')), 'gg')
  expect_is(wykresKolowy(c('a' = 'a 1%', 'b' = '2')), 'gg') # TODO przerobić na sprawdzanie wygenerowania pustego wykresu

  expect_is(wykresKolowyNorm(c('a' = 1, 'b' = 2)), 'gg')
  expect_is(wykresKolowyNorm(c('a' = '1', 'b' = '2')), 'gg')
  expect_is(wykresKolowyNorm(c('a' = ' 1', 'b' = '  2')), 'gg')
  expect_is(wykresKolowyNorm(c('a' = '  1%', 'b' = '2')), 'gg')
  expect_is(wykresKolowyNorm(c('a' = 'a 1%', 'b' = '2')), 'gg') # TODO przerobić na sprawdzanie wygenerowania pustego wykresu

  expect_is(wykresKolowyZlicz(c('a' = 1, 'b' = 2)), 'gg')
  expect_is(wykresKolowyZlicz(c('a' = T, 'b' = F)), 'gg') 
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
  expect_is(wykresHistogram(rnorm(100), rownePrzedzialy = TRUE), 'gg')
  expect_is(wykresHistogram(c(rep(1, 100), 2:9)), 'gg')
  expect_is(wykresHistogram(letters), 'gg')
  expect_is(wykresHistogram(letters[rep(1:10, 10)]), 'gg')
  expect_is(wykresHistogram(factor(letters[round(runif(100, 0, 24))])), 'gg')
  
  expect_is(wykresHistogram(rep(NA_integer_, 10)), 'gg') # wykresPusty() w linii 34
  expect_is(wykresHistogram(rep(1, 10)), 'gg') # wykresPusty() w linii 55
  
  expect_is(wykresHistogram(c(1:100, rep(50, 100)), rozmiarTekstu = 1), 'gg') # else w linii 115
  expect_is(wykresHistogram(c(1:100, rep(50, 100)), rozmiarTekstu = 1000), 'gg') # if w linii 113
})

test_that('wykresRozrzutu', {
  expect_is(wykresRozrzutu(rnorm(100), rnorm(100)), 'gg')
  expect_is(wykresRozrzutu(rnorm(24), rnorm(24), letters[1:24]), 'gg')
  expect_is(wykresRozrzutu(rnorm(24), rnorm(24), factor(letters[1:24])), 'gg')
  expect_is(wykresRozrzutu(rnorm(24), rnorm(24), letters[1:24], 1:24), 'gg')
  expect_is(wykresRozrzutu(rnorm(24), rnorm(24), rozmiar = 1:24), 'gg')
  expect_is(wykresRozrzutu(numeric(), numeric()), 'gg')
  expect_is(wykresRozrzutu(rnorm(100), rnorm(100), opcjeWykresu = ggplot2::theme_bw()), 'gg')
})

test_that('wykresRozrzutuIloraz', {
  expect_is(wykresRozrzutuIloraz(rnorm(100), rnorm(100)), 'gg')
  expect_is(wykresRozrzutuIloraz(rnorm(24), rnorm(24), letters[1:24]), 'gg')
  expect_is(wykresRozrzutuIloraz(rnorm(24), rnorm(24), letters[1:24], 1:24), 'gg')
  expect_is(wykresRozrzutuIloraz(rnorm(24), rnorm(24), rozmiar = 1:24), 'gg')
})

test_that('wykresLiniowy', {
  dane = data.frame(
    seria = rep(c('a', 'b'), each = 5),
    n = rep(c(30, 50, 70, 50, 20), 2),
    x = rep(1:5, 2),
    y = runif(10, 0, 3)
  )
  expect_is(wykresLiniowy(dane), 'gg')
  expect_is(wykresMiesieczny(dane), 'gg')
  expect_is(wykresLiniowy(dane, nMin = 10), 'gg')
  expect_is(wykresLiniowy(dane, nMin = 1000), 'gg')
  expect_is(wykresLiniowy(dane, opcjeWykresu = ggplot2::theme_bw()), 'gg')
  
  dane$x = factor(dane$x)
  expect_is(wykresLiniowy(dane), 'gg')
  expect_is(wykresMiesieczny(dane), 'gg')
  
  dane$x = rep(letters[1:5], 2)
  expect_is(wykresLiniowy(dane), 'gg')
  expect_is(wykresMiesieczny(dane), 'gg')
  
  # puste dane
  dane = data.frame(n = numeric(), x = numeric(), y = numeric())
  expect_is(wykresLiniowy(dane), 'gg')
})

test_that('opcjeWykresu', {
  library(ggplot2)
  expect_is(wykresSlupkowy(c('a' = 1, 'b' = 2), opcjeWykresu = theme_grey()), 'gg')

  expect_is(wykresKolowy(c('a' = 1, 'b' = 2), opcjeWykresu = theme_grey()), 'gg')
  expect_is(wykresKolowyNorm(c('a' = 1, 'b' = 2), opcjeWykresu = theme_grey()), 'gg')
  expect_is(wykresKolowyZlicz(c('a' = 1, 'b' = 2), opcjeWykresu = theme_grey()), 'gg')

  expect_is(wykresHistogram(rnorm(100), opcjeWykresu = theme_grey()), 'gg')
})
  
test_that('polamTekst', {
  expect_is(wykresKolowy(c('bardzo długie etykiety danych' = 1, 'oj, jakie długie etykiety danych' = 2)), 'gg')
  expect_is(wykresKolowy(c('bardzo długie etykiety danych\n' = 1, 'oj, jakie długie etykiety danych\n' = 2)), 'gg')
  expect_is(wykresSlupkowy(c('bardzo długie etykiety danych' = 1, 'oj, jakie długie etykiety danych' = 2)), 'gg')
  expect_is(wykresSlupkowy(c('bardzo długie etykiety danych\n' = 1, 'oj, jakie długie etykiety danych\n' = 2)), 'gg')
})