context('bMod')

test_that('bMod', {
  expect_equal(bMod(1:10, FALSE), 0.9)
  expect_equal(bMod(1:10, FALSE, dokl = 0), 1)
  expect_equal(bMod(1:2, FALSE), NA_integer_)
  
  expect_equal(bMod(1:10, TRUE), '               0.90')
  expect_equal(bMod(1:10, TRUE, dokl = 0), '                            1')
  expect_equal(bMod(1:2, TRUE), '                NA')
})