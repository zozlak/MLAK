context('P')

test_that('P', {
  expect_equal(P(c(1:8, NA, NA), 1, FALSE), 10)
  expect_equal(P(c(1:8, NA, NA), 1:3, FALSE), 30)
  expect_equal(P(c(1:8, NA, NA), 1, FALSE, znakProcent = TRUE), '10%')
  expect_equal(P(c(1:8, NA, NA), 1, TRUE), '                         10.0%')
  expect_equal(P(c(1:8, NA, NA), 1:3, TRUE, dokl = 0), '                                       30%')
  
  expect_equal(P(c(1:7, NA, NA), 1:3, FALSE, 2), 33.33)
  expect_equal(P(c(1:7, NA, NA), 1:3, FALSE, 1, FALSE), 33.3)
  expect_equal(P((1:10)[rep(F, 10)], 1:3, FALSE), NA_real_)
  expect_equal(P((1:10)[rep(F, 10)], 1:3, TRUE), '                                  -%')
})

test_that('Pw', {
  expect_equal(Pw(c(1:8, NA, NA), 1, FALSE), 12.5)
  expect_equal(Pw(c(1:8, NA, NA), 1, FALSE, znakProcent = TRUE), '12.5%')
  expect_equal(Pw(c(1:8, NA, NA), 1:3, FALSE), 37.5)
  expect_equal(Pw(c(1:8, NA, NA), 1:3, FALSE, 0), 38)
  expect_equal(Pw(c(1:8, NA, NA), 1:3, FALSE, 0, znakProcent = TRUE), '38%')
  expect_equal(Pw(c(1:8, NA, NA), 1:3, FALSE, 2, FALSE), 37.5)
  expect_equal(Pw((1:10)[rep(F, 10)], 1:3, FALSE), NA_real_)
  expect_equal(Pw((1:10)[rep(F, 10)], 1:3, FALSE, znakProcent = TRUE), '-%')
})
