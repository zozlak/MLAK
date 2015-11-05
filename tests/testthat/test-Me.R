context('Me')

test_that('Me dziala', {
  MLAK:::.onLoad()
  
  w = Me(1:7, FALSE)
  expect_equal(w, 4)
  w = Me(1:8, FALSE)
  expect_equal(w, 4.5)
  w = Me(1:8, FALSE, dokl = 0)
  expect_equal(w, 4)
  
  w = Me(1:7, dokl = 1)
  expect_equal(w, '                  4.0')
  w = Me(1:8)
  expect_equal(w, '       4.50')
  
  w = Me(1:2)
  expect_equal(w, '          -')
  w = Me(1:2, TRUE, 2)
  expect_equal(w, '                   -')
  w = Me(1:2, FALSE)
  expect_equal(w, NA_integer_)
  w = Me(1:2, FALSE, 2)
  expect_equal(w, NA_integer_)
  
  w = Me('a')
  expect_equal(w, '          -')
})
