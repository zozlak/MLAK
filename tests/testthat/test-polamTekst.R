context('polamTekst')

test_that('polamTekst', {
  expect_equal(polamTekst('Ala ma kota a kot ma Alę'), '\nAla ma kota a\nkot ma Alę\n')
  expect_equal(polamTekst('Ala ma kota a kot ma Alę', 100), '\nAla ma kota a kot ma Alę\n')
  expect_equal(polamTekst('Ala ma kota a kot ma Alę', 100, TRUE), '\nAla ma kota a kot ma Alę\n')
  
  expect_equal(polamTekst('Ala ma kota a kot\nma Alę'), '\nAla ma kota a kot\nma Alę\n')
  expect_equal(polamTekst('Ala ma kota a kot\nma Alę', 15, TRUE), '\nAla ma kota a\nkot ma Alę\n')
})