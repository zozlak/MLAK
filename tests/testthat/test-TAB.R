context('TAB')

test_that('TAB radzi sobie z NA', {
  dane = data.frame(a = 1:3, b = c(1, 2, NA))
  names(dane) = c(NA, 'b')
  expect_is(TAB(dane), 'NULL')
})