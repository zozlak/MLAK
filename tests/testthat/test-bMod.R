context('bMod')

test_that('bMod', {
  MLAK:::.onLoad()
  
  w = bMod(1:10, FALSE)
  expect_equal(w, 0.9)
  w = bMod(1:10, FALSE, dokl = 0)
  expect_equal(w, 1)
  w = bMod(1:2, FALSE)
  expect_equal(w, NA_integer_)
  
  w = bMod(1:10)
  expect_equal(w, '         0.90')
  w = bMod(1:10, dokl = 0)
  expect_equal(w, '                      1')
  w = bMod(1:2)
  expect_equal(w, '          NA')
})