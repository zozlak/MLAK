context('korelacje')

test_that('R', {
  expect_equal(R(1:10, 1:10, FALSE), 1)
  expect_equal(R(-(1:10), 1:10, FALSE), -1)
  expect_less_than(R(runif(10000), runif(10000), FALSE, 3), 0.05)

  expect_equal(R(1:2, 1:2, FALSE), '-')
  expect_equal(R(c(1, rep(NA, 4)), c(1, rep(NA, 4)), FALSE), '-')
  
  expect_error(R(letters[1:3], 1:3, FALSE))
  expect_error(R(factor(1:3), 1:3, FALSE))
  expect_error(R(1:3, letters[1:3], FALSE))
  expect_error(R(1:3, factor(1:3), FALSE))
  expect_error(R(c(F, F, T, T), 1:4, FALSE))
  expect_error(R(1:2, 1:3, FALSE))

  expect_equal(R(1:10, 1:10, TRUE), '                   1.00')
})

test_that('R2', {
  expect_equal(R2(1:10, 1:10, FALSE), 1)
  expect_equal(R2(-(1:10), 1:10, FALSE), 1)
  expect_less_than(R(runif(10000), runif(10000), FALSE, 3), 0.03)

  expect_equal(R2(1:2, 1:2, FALSE), '-')
  
  expect_error(R2(letters[1:3], 1:3, FALSE))
  expect_error(R2(factor(1:3), 1:3, FALSE))
  expect_error(R2(c(F, F, T, T), 1:4, FALSE))
  expect_error(R2(1:2, 1:3, FALSE))
  
  expect_equal(R2(1:10, 1:10, TRUE), '                    1.00')
})

test_that('Tau', {
  expect_equal(Tau(1:10, 1:10, FALSE), 1)
  expect_equal(Tau(-(1:10), 1:10, FALSE), -1)
  expect_less_than(R(runif(10000), runif(10000), FALSE, 3), 0.05)
  expect_equal(Tau(letters[1:5], 1:5, FALSE), 1)
  expect_equal(Tau(factor(1:5), 1:5, FALSE), 1)
  expect_equal(Tau(1:5, factor(1:5), FALSE), 1)
  expect_equal(Tau(c(F, F, F, T, T, T), 1:6, FALSE), 0.77)

  expect_equal(Tau(1:2, 1:2, FALSE), '-')
  
  expect_error(Tau(1:2, 1:3, FALSE))
  
  expect_equal(Tau(1:10, 1:10, TRUE), '                     1.00')
})