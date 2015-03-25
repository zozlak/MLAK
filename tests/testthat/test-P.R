context('P')

test_that('P', {
  expect_equal(P(c(1:8, NA, NA), 1, FALSE), '10%')
  expect_equal(P(c(1:8, NA, NA), 1:3, FALSE), '30%')
  expect_equal(P(c(1:7, NA, NA), 1:3, FALSE, 2), '33.33%')
  expect_equal(P(c(1:7, NA, NA), 1:3, FALSE, 1, FALSE), 33.3)
})

test_that('Pw', {
  expect_equal(Pw(c(1:8, NA, NA), 1, FALSE), '12.5%')
  expect_equal(Pw(c(1:8, NA, NA), 1:3, FALSE), '37.5%')
  expect_equal(Pw(c(1:8, NA, NA), 1:3, FALSE, 0), '38%')
  expect_equal(Pw(c(1:8, NA, NA), 1:3, FALSE, 2, FALSE), 37.5)
})
