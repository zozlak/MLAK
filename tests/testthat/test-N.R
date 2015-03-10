context('N')

test_that('N zlicza NA', {
  expect_equal(N(1:10, NA, FALSE), 0)
  expect_equal(N(rep(NA, 10), NA, FALSE), 10)
  expect_equal(N(c(1:10, NA), NA, FALSE), 1)
  expect_equal(N(c(1:10, NA), c(1, NA), FALSE), 2)
  expect_equal(N(c(1:10, NA), c(-1, NA), FALSE), 1)
})

test_that('N zlicza nie NA', {
  expect_equal(N(1:10, 1, FALSE), 1)
  expect_equal(N(rep(1, 5), 1, FALSE), 5)
  expect_equal(N(rep(1:2, 5), 1, FALSE), 5)
  expect_equal(N(rep(1:2, 5), 1:2, FALSE), 10)
  expect_equal(N(rep(1:2, 5), 0:2, FALSE), 10)
  expect_equal(N(rep(1:2, 5), 0:1, FALSE), 5)
})

test_that('N anonimizuje', {
  expect_equal(N(1, 1, FALSE), '-')
  expect_equal(N(1, 1:2, FALSE), '-')
  expect_equal(N(NA, NA, FALSE), '-')
  expect_equal(N(NA, c(1, NA), FALSE), '-')
})