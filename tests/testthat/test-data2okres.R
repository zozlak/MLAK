context('data2okres')

test_that('data2okres działa', {
  expect_equal(data2okres('2015-01'), 24181)
  expect_equal(data2okres('2015-01-03'), 24181)
})
