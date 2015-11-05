context('N')

test_that('N zlicza NA', {
  MLAK:::.onLoad()
  
  w = N(1:10, NA, FALSE)
  expect_equal(w, 0)
  w = N(rep(NA, 10), NA, FALSE)
  expect_equal(w, 10)
  w = N(c(1:10, NA), NA, FALSE)
  expect_equal(w, 1)
  w = N(c(1:10, NA), c(1, NA), FALSE)
  expect_equal(w, 2)
  w = N(c(1:10, NA), c(-1, NA), FALSE)
  expect_equal(w, 1)

  w = N(c(letters[1:10], NA), c('a', NA), FALSE)
  expect_equal(w, 2)
})

test_that('N zlicza nie NA', {
  MLAK:::.onLoad()
  
  w = N(1:10, 1, FALSE)
  expect_equal(w, 1)
  w = N(rep(1, 5), 1, FALSE)
  expect_equal(w, 5)
  w = N(rep(1:2, 5), 1, FALSE)
  expect_equal(w, 5)
  w = N(rep(1:2, 5), 1:2, FALSE)
  expect_equal(w, 10)
  w = N(rep(1:2, 5), 0:2, FALSE)
  expect_equal(w, 10)
  w = N(rep(1:2, 5), 0:1, FALSE)
  expect_equal(w, 5)
})

test_that('N anonimizuje', {
  MLAK:::.onLoad()
  
  w = N(1, 1, FALSE)
  expect_equal(w, NA_integer_)
  w = N(1, 1:2, FALSE)
  expect_equal(w, NA_integer_)
  w = N(NA, NA, FALSE)
  expect_equal(w, NA_integer_)
  w = N(NA, c(1, NA), FALSE)
  expect_equal(w, NA_integer_)
})