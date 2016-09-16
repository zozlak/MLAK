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
})

test_that('zgadywanie parametru wyrownaj dziala', {
  #TODO dopisać testy używające knitr-a
})