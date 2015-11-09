context('E')

test_that('E dziala', {
  expect_equal(E(1:7, FALSE), 4)
  expect_equal(E(1:8, FALSE), 4.5)
  expect_equal(E(1:8, FALSE, dokl = 0), 4)

  expect_equal(E(1:7, TRUE, dokl = 1), '                       4.0')
  expect_equal(E(1:8, TRUE), '            4.50')
  
  expect_equal(E(1:2, TRUE), '               -')
  expect_equal(E(1:2, TRUE, 2), '                  -')
  expect_equal(E(1:2, FALSE), NA_integer_)
  expect_equal(E(1:2, TRUE), '               -')
  
  expect_equal(E('a', TRUE), '               -')
})
