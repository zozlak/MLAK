context('')

test_that('', {
  expect_equal(W(1), '       1')
  expect_equal(W(1:2), c('         1', '         2'))
})
