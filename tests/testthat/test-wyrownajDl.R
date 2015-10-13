context('wyrownajDl')

test_that('wyrownajDl dziala', {
  call = as.call(list('f'))
  
  expect_equal(wyrownajDl(5, call, 2), '     5.00')
  expect_equal(wyrownajDl(5, call, 0), '        5')
  expect_equal(wyrownajDl(5, call, 0, delta = 0), '    5')

  expect_equal(wyrownajDl('-', call), '        -')
  expect_equal(wyrownajDl('-', call, 2), '        -')
  expect_equal(wyrownajDl('-', call, 2, 0), '    -')
  expect_equal(wyrownajDl('', call), '         ')
  
  expect_warning(wyrownajDl('bardzo dluga wartosc do wyrownania', call, 0), 'Wyrównanie długości nie było możliwe')
  
  # test na bardzo długi kod wywołania, gdzie deparse() zwraca wynik połamany na wiele linii
  call = call('E', c(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1))
  expect_equal(wyrownajDl(5, call, 0), '                                                                                              5')
  
  # test na zachowanie wewnątrz dplyr-owego summarize
  library(dplyr)
  wynik = data.frame(x = c(1, rep(2, 49)), y = rep(1, 50)) %>%
    group_by(x) %>%
    summarize(n = N(y))
  expect_is(wynik$n, 'character')
  expect_equal(wynik$n[1], '-')
  expect_equal(wynik$n[2], ' 49')
})
