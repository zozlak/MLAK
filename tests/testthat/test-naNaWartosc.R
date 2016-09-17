context('naNaWartosc')

test_that('pusty wektor', {
  expect_true(is.na(naNaWartosc(vector())))
})