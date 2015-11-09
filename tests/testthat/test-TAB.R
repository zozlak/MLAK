context('TAB')

test_that('TAB radzi sobie z NA', {
  dane = data.frame(a = 1:3, b = c(1, 2, NA))
  names(dane) = c(NA, 'b')
  expect_is(TAB(dane), 'NULL')

  dane = data.frame(n = c(7:11, NA), x = 7:12, y = paste0(7:12, '%'), z = letters[7:12])
  expect_is(TAB(dane), 'NULL')
})