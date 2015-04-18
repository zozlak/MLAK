context('statWektor')

test_that('statWektor obsluguje nietypowe wyniki', {
  expect_equal(statWektor(1:10, function(x){return('x')}, NULL, FALSE), '-')
  expect_equal(statWektor(1:10, function(x){return('x')}, as.call(list('x'))), '        -')

  expect_equal(statWektor(1:10, function(x){return(c('x', NA))}, NULL, FALSE), c('-', '-'))
  expect_equal(statWektor(1:10, function(x){return(c('x', NA))}, as.call(list('x'))), c('        -', '        -'))
  
  expect_equal(statWektor(1:10, function(x){return(c(Inf, NA, NaN, 1))}, NULL, FALSE), c('-', '-', '-', 1))
  expect_equal(statWektor(1:10, function(x){return(c(Inf, NA, NaN, 1))}, as.call(list('x'))), c('        -', '        -', '        -', '        1'))
})
  