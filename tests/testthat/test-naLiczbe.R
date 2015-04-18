context('naLiczbe')

test_that('naLiczbe dziala', {
  expect_error(naLiczbe(data.frame()))
  expect_error(naLiczbe(NULL))
  
  expect_equal(naLiczbe(c(a = 1, b = 2)), c(a = 1, b = 2))
  expect_equal(naLiczbe(c(a = '1', b = '2')), c(a = 1, b = 2))
  expect_equal(naLiczbe(c(a = '1%', b = '2%')), c(a = 1, b = 2))
  expect_equal(naLiczbe(c(a = 'a', b = 2)), c(a = NA, b = 2))
})
