context('obliczDaneMiesieczne')

daneAbs1 = data.frame(
  ID_ZDAU = 1:12,
  DOSW_ES = rep(1:3, 4),
  DATA_ZAK = rep(c('2015-09', '2015-11'), 6),
  stringsAsFactors = FALSE
)
daneAbs2 = daneAbs1
daneAbs2$DATA_ZAK = rep(c(24189, 24191), 6)

daneMies1 = data.frame(
  ID_ZDAU = rep(1:12, 10),
  OKRES = rep(c("2015-05", "2015-06", "2015-07", "2015-08", "2015-09", "2015-10", "2015-11", "2015-12", "2016-01", "2016-02", "2016-03", "2016-04"), each = 10),
  STUD = rep(c(1,1,1,1,1,1,0,0,0,0,0,0), 10),
  BILOD = runif(12*10, 0.5, 1.5),
  ZILO = runif(12*10, 0.5, 1.5),
  stringsAsFactors = FALSE
)
daneMies2 = daneMies1
daneMies2$OKRES = rep(24185:24196, each = 10)

test_that('obliczDaneMiesieczne basic', {
  dane1 = obliczDaneMiesieczne(daneAbs1, daneMies1, 'BILOD', 'DOSW_ES')
  expect_is(dane1, 'data.frame')
  expect_equal(nrow(dane1), 12*3) # 12 miesięcy x 3 wartości DOSW_ES
  expect_equal(min(dane1$x), min(daneMies1$OKRES))
  expect_equal(max(dane1$x), max(daneMies1$OKRES))
  expect_equal(levels(dane1$seria), c('1', '2', '3'))
  
  dane2 = obliczDaneMiesieczne(daneAbs2, daneMies2, 'BILOD', 'DOSW_ES')
  expect_is(dane2, 'data.frame')
  expect_equal(nrow(dane2), 12*3) # 12 miesięcy x 3 wartości DOSW_ES
  expect_equal(min(dane2$x), min(daneMies2$OKRES))
  expect_equal(max(dane2$x), max(daneMies2$OKRES))
  expect_equal(levels(dane2$seria), c('1', '2', '3'))
  
  expect_equal(dane1$y, dane2$y)
})
  
test_that('obliczDaneMiesieczne data relatywna', {
  # dane1 = obliczDaneMiesieczne(daneAbs1, daneMies1, 'BILOD', 'DOSW_ES', 'DATA_ZAK')
  # expect_is(dane1, 'data.frame')
  # expect_equal(nrow(dane1), 42)
  # expect_equal(min(dane1$x), -6)
  # expect_equal(max(dane1$x), 7)
  # expect_equal(levels(dane1$seria), c('1', '2', '3'))
  
  dane2 = obliczDaneMiesieczne(daneAbs2, daneMies2, 'BILOD', 'DOSW_ES', 'DATA_ZAK')
  expect_is(dane2, 'data.frame')
  expect_equal(nrow(dane2), 42)
  expect_equal(min(dane2$x), -6)
  expect_equal(max(dane2$x), 7)
  expect_equal(levels(dane2$seria), c('1', '2', '3'))

  # expect_equal(dane1$y, dane2$y)
})

test_that('obliczDaneMiesieczne data filtry', {
  dane1 = obliczDaneMiesieczne(daneAbs1, daneMies1, 'BILOD', 'DOSW_ES', od = '2015-08', do = '2016-01')
  expect_is(dane1, 'data.frame')
  expect_equal(nrow(dane1), 18)
  expect_equal(min(dane1$x), '2015-08')
  expect_equal(max(dane1$x), '2016-01')
  expect_equal(levels(dane1$seria), c('1', '2', '3'))
  
  dane2 = obliczDaneMiesieczne(daneAbs2, daneMies2, 'BILOD', 'DOSW_ES', 'DATA_ZAK', 24189, 24192, -1, 1)
  expect_is(dane2, 'data.frame')
  expect_equal(nrow(dane2), 9)
  expect_equal(min(dane2$x), -1)
  expect_equal(max(dane2$x), 1)
  expect_equal(levels(dane2$seria), c('1', '2', '3'))
})

test_that('obliczDaneMiesieczne wiele grup', {
  dane1 = obliczDaneMiesieczne(daneAbs1, daneMies1, 'BILOD', c('DOSW_ES', 'STUD'))
  expect_is(dane1, 'data.frame')
  expect_equal(nrow(dane1), 12*3*2) # 12 miesięcy x 3 wartości DOSW_ES x 2 wartości STUD
  expect_equal(min(dane1$x), min(daneMies1$OKRES))
  expect_equal(max(dane1$x), max(daneMies1$OKRES))
  expect_equal(levels(dane1$seria), c('1 0', '1 1', '2 0', '2 1', '3 0', '3 1'))
})

test_that('obliczDaneMiesieczne wiele zmiennych', {
  dane2 = obliczDaneMiesieczne(daneAbs2, daneMies2, c('BILOD', 'ZILO'), 'DOSW_ES')
  expect_is(dane2, 'data.frame')
  expect_equal(nrow(dane2), 12*3*2) # 12 miesięcy x 3 wartości DOSW_ES x ZILO/BILOD
  expect_equal(min(dane2$x), min(daneMies2$OKRES))
  expect_equal(max(dane2$x), max(daneMies2$OKRES))
  expect_equal(levels(dane2$seria), c('BILOD 1', 'BILOD 2', 'BILOD 3', 'ZILO 1', 'ZILO 2', 'ZILO 3'))
})

test_that('obliczDaneMiesieczne pełen wypas', {
  dane2 = obliczDaneMiesieczne(daneAbs2, daneMies2, c('BILOD', 'ZILO'), c('DOSW_ES', 'STUD'), 'DATA_ZAK', 24189, 24192, -1, 1)
  expect_is(dane2, 'data.frame')
  expect_equal(nrow(dane2), 34)
  expect_equal(min(dane2$x), -1)
  expect_equal(max(dane2$x), 1)
  expect_equal(levels(dane2$seria), c(
    "BILOD 1 0", "BILOD 1 1", "BILOD 2 0", "BILOD 2 1", "BILOD 3 0", "BILOD 3 1",
    "ZILO 1 0",  "ZILO 1 1",  "ZILO 2 0",  "ZILO 2 1",  "ZILO 3 0",  "ZILO 3 1" 
  ))
})
