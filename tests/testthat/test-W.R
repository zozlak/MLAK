context('W')

test_that('W dziala', {
  expect_equal(W(1), '       1')
  expect_equal(W(1:2), c('         1', '         2'))
})
