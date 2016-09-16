context('statWektor')

test_that('statWektor obsluguje nietypowe wyniki', {
  expect_equal(statWektor(1:10, function(x){return('x')}, NULL, FALSE), NA_character_)
  expect_equal(statWektor(1:10, function(x){return('x')}, as.call(list('x')), TRUE), '        -')

  expect_equal(statWektor(1:10, function(x){return(c('x', NA))}, NULL, FALSE), c(NA_character_, NA_character_))
  expect_equal(statWektor(1:10, function(x){return(c('x', NA))}, as.call(list('x')), TRUE), c('        -', '        -'))
  
  expect_equal(statWektor(1:10, function(x){return(c(Inf, NA, NaN, 1))}, NULL, FALSE), c(NA_integer_, NA_integer_, NA_integer_, 1))
  expect_equal(statWektor(1:10, function(x){return(c(Inf, NA, NaN, 1))}, as.call(list('x')), TRUE), c('        -', '        -', '        -', '        1'))
})
  