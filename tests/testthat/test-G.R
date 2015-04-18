context('')

test_that('G bez filtru i NA', {
  dane = rnorm(100)
  dane = dane[order(dane)]
  kwantyle = Q(dane, 1:3, 4, FALSE)
  expect_equal(E(dane[dane < kwantyle[1]], FALSE), E(dane[G(dane, 1, 4)], FALSE))
  expect_equal(E(dane[dane >= kwantyle[1] & dane < kwantyle[2]], FALSE), E(dane[G(dane, 2, 4)], FALSE))
  expect_equal(E(dane[dane >= kwantyle[2] & dane < kwantyle[3]], FALSE), E(dane[G(dane, 3, 4)], FALSE))
  expect_equal(E(dane[dane >= kwantyle[3]], FALSE), E(dane[G(dane, 4, 4)], FALSE))
})

test_that('G z filtrem bez NA', {
  dane = rnorm(100)
  dane = dane[order(dane)]
  filtr = rep(c(F, T), 50)
  kwantyle = Q(dane[filtr], 1:3, 4, FALSE)
  expect_equal(E(dane[filtr & dane < kwantyle[1]], FALSE), E(dane[G(dane, 1, 4, filtr)], FALSE))
  expect_equal(E(dane[filtr & dane >= kwantyle[1] & dane < kwantyle[2]], FALSE), E(dane[G(dane, 2, 4, filtr)], FALSE))
  expect_equal(E(dane[filtr & dane >= kwantyle[2] & dane < kwantyle[3]], FALSE), E(dane[G(dane, 3, 4, filtr)], FALSE))
  expect_equal(E(dane[filtr & dane >= kwantyle[3]], FALSE), E(dane[G(dane, 4, 4, filtr)], FALSE))
})

test_that('G z filtrem i NA', {
  dane = append(dane, rep(NA, 50))
  filtr = append(filtr, rep(TRUE, 50))
  kwantyle = Q(dane[filtr], 1:3, 4, FALSE)
  expect_equal(E(dane[filtr & dane < kwantyle[1]], FALSE), E(dane[G(dane, 1, 4, filtr)], FALSE))
  expect_equal(E(dane[filtr & dane >= kwantyle[1] & dane < kwantyle[2]], FALSE), E(dane[G(dane, 2, 4, filtr)], FALSE))
  expect_equal(E(dane[filtr & dane >= kwantyle[2] & dane < kwantyle[3]], FALSE), E(dane[G(dane, 3, 4, filtr)], FALSE))
  expect_equal(E(dane[filtr & dane >= kwantyle[3]], FALSE), E(dane[G(dane, 4, 4, filtr)], FALSE))
})
