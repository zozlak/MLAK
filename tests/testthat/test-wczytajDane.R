context('wczytajDane')

test_that('wczytajDane czyta csv', {
  wzor = data.frame(a = c(1:9, NA), b = c(letters[1:9], 'ą'), stringsAsFactors = F)
  write.csv2(wzor, 'dane/test.csv', na = '', row.names = F, fileEncoding = 'windows-1250')
  expect_equal(wczytajDane('dane/test.csv'), wzor)
  unlink('dane/test.csv')
})

test_that('wczytajDane czyta xslx', {
  dane = wczytajDane('dane/R3-odbiorcy.xlsx')
  expect_equal(dim(dane), c(5, 17))
})

test_that('wczytajDane czyta RData', {
  a = 1:10
  wzor1 = data.frame(a = c(1:9, NA), b = c(letters[1:9], 'ą'), stringsAsFactors = F)
  wzor2 = data.frame(a = 1:10, b = letters[1:10], stringsAsFactors = F)
  
  save(a, wzor1, wzor2, file = 'dane/test.RData')
  dane = wczytajDane('dane/test.RData')
  expect_equal(dane, list(wzor1 = wzor1, wzor2 = wzor2))

  save(a, wzor1, file = 'dane/test.RData')
  dane = wczytajDane('dane/test.RData')
  expect_equal(dane, wzor1)

  save(wzor1, file = 'dane/test.RData')
  dane = wczytajDane('dane/test.RData')
  expect_equal(dane, wzor1)

  save(a, file = 'dane/test.RData')
  dane = wczytajDane('dane/test.RData')
  expect_equal(dane, data.frame())

  suppressWarnings(save(file = 'dane/test.RData'))
  dane = wczytajDane('dane/test.RData')
  expect_equal(dane, data.frame())
  
  unlink('dane/test.RData')
})
