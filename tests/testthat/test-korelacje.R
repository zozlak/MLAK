context('korelacje')

test_that('R', {
  MLAK:::.onLoad()
  
  w = R(1:10, 1:10, FALSE)
  expect_equal(w, 1)
  w = R(-(1:10), 1:10, FALSE)
  expect_equal(w, -1)
  w = R(runif(10000), runif(10000), FALSE, 3)
  expect_less_than(w, 0.05)

  w = R(1:2, 1:2, FALSE)
  expect_equal(w, NA_integer_)
  w = R(c(1, rep(NA, 4)), c(1, rep(NA, 4)), FALSE)
  expect_equal(w, NA_integer_)
  
  expect_error(R(letters[1:3], 1:3, FALSE))
  expect_error(R(factor(1:3), 1:3, FALSE))
  expect_error(R(1:3, letters[1:3], FALSE))
  expect_error(R(1:3, factor(1:3), FALSE))
  expect_error(R(c(F, F, T, T), 1:4, FALSE))
  expect_error(R(1:2, 1:3, FALSE))

  w = R(1:10, 1:10, TRUE)
  expect_equal(w, '                   1.00')
})

test_that('R2', {
  MLAK:::.onLoad()

  w = R2(1:10, 1:10, FALSE)
  expect_equal(w, 1)
  w = R2(-(1:10), 1:10, FALSE)
  expect_equal(w, 1)
  w = R(runif(10000), runif(10000), FALSE, 3)
  expect_less_than(w, 0.03)

  w = R2(1:2, 1:2, FALSE)
  expect_equal(w, NA_integer_)
  
  expect_error(R2(letters[1:3], 1:3, FALSE))
  expect_error(R2(factor(1:3), 1:3, FALSE))
  expect_error(R2(c(F, F, T, T), 1:4, FALSE))
  expect_error(R2(1:2, 1:3, FALSE))
  
  w = R2(1:10, 1:10, TRUE)
  expect_equal(w, '                    1.00')
})

test_that('Tau', {
  MLAK:::.onLoad()
  
  w = Tau(1:10, 1:10, FALSE)
  expect_equal(w, 1)
  w = Tau(-(1:10), 1:10, FALSE)
  expect_equal(w, -1)
  w = R(runif(10000), runif(10000), FALSE, 3)
  expect_less_than(w, 0.05)
  w = Tau(letters[1:5], 1:5, FALSE)
  expect_equal(w, 1)
  w = Tau(factor(1:5), 1:5, FALSE)
  expect_equal(w, 1)
  w = Tau(1:5, factor(1:5), FALSE)
  expect_equal(w, 1)
  w = Tau(c(F, F, F, T, T, T), 1:6, FALSE)
  expect_equal(w, 0.77)

  w = Tau(1:2, 1:2, FALSE)
  expect_equal(w, NA_integer_)
  w = Tau(1:2, 1:2)
  expect_equal(w, '                -')
  
  expect_error(Tau(1:2, 1:3, FALSE))
  
  w = Tau(1:10, 1:10, TRUE)
  expect_equal(w, '                     1.00')
})