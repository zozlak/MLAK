context('Q')

test_that('Q dziala', {
  MLAK:::.onLoad()
  
  w = Q(1:7, 2, 4, FALSE)
  expect_equal(w, c('50%' = 4))
  w = Q(1:8, 2, 4, FALSE)
  expect_equal(w, c('50%' = 4.5))
  w = Q(1:8, 2, 4, FALSE, dokl = 0)
  expect_equal(w, c('50%' = 4))
  
  w = Q(1:7, 2, 4, dokl = 1)
  expect_equal(w, c('50%' = '                       4.0'))
  w = Q(1:8, 2, 4)
  expect_equal(w, c('50%' = '            4.50'))
  
  w = Q(1:2, 1, 4)
  expect_equal(w, '               -')
  w = Q(1:2, 1:2, 5)
  expect_equal(w, '                 -')

  expect_error(Q('a', 1, 2))
  expect_error(Q(1:7, 'a', 2))
  expect_error(Q(1:7, 1, 'a'))
  
  expect_equal(names(Q(1:7, 2, 4)), '50%')
  expect_equal(names(Q(1:7, 2, 4, FALSE)), '50%')
  expect_equal(names(Q(1:7, 1:5, 5)), c('20%', '40%', '60%', '80%', '100%'))
  expect_equal(names(Q(1:7, 1:5, 5, FALSE)), c('20%', '40%', '60%', '80%', '100%'))
  
  w = Q(1:7, 1:2, 4, FALSE)
  expect_equal(w, c('25%' = 2.5, '50%' = 4))
  w = Q(1:8, 1:4, 4, FALSE)
  expect_equal(w, c('25%' = 2.75, '50%' = 4.5, '75%' = 6.25, '100%' = 8))
  w = Q(1:8, 1:4, 4, FALSE, dokl = 0)
  expect_equal(w, c('25%' = 3, '50%' = 4, '75%' = 6, '100%' = 8))

  w = Q(1:8, 1:4, 4)
  expect_equal(w, c('25%' = '              2.75', '50%' = '              4.50', '75%' = '              6.25', '100%' = '              8.00'))
})
