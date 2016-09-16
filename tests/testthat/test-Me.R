context('Me')

test_that('Me dziala', {
  expect_equal(Me(1:7, FALSE), 4)
  expect_equal(Me(1:8, FALSE), 4.5)
  expect_equal(Me(1:8, FALSE, dokl = 0), 4)
  
  expect_equal(Me(1:7, TRUE, dokl = 1), '                        4.0')
  expect_equal(Me(1:8, TRUE), '             4.50')
  
  expect_equal(Me(1:2, TRUE), '                -')
  expect_equal(Me(1:2, TRUE, 2), '                   -')
  expect_equal(Me(1:2, FALSE), NA_integer_)
  expect_equal(Me(1:2, FALSE, 2), NA_integer_)
  
  expect_equal(Me('a', TRUE), '                -')
})
