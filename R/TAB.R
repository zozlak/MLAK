#' @title rysuje tablicę na podstawie ramki danych
#' @description W wypadku, gdy liczba wierszy w tablicy jest nieprzewidywalna,
#' nie da się opisać tablicy w szablonie raportu za pomocą kodu markdown.
#' Funkcja \code{TAB} pozwala obejść to ograniczenie rysując tablicę na
#' podstawie dowolnej ramki danych.
#'
#' Tablica rysowana jest w składni multiline tables, a więc z zapewnieniem
#' łamania wierszy w komórkach.
#'
#' Kolumny zawierające wartości liczbowe są wyrównane do prawej, zaś kolumny
#' tekstowe do lewej (być może w przyszłości pojawi się możliwość ręcznego
#' określania wyrównania).
#'
#' Jeśli w parametrze \code{kolN} wskazana zostanie nazwa kolumny przechowującej
#' liczbę obserwacji, funkcja dokona anonimizacji (zamiany na '-') kolumn
#' liczbowych, dla których liczba obserwacji jest mniejsza niż wartość parametru
#' \code{nMin}, przy czym przy anonimizacji pominięte zostaną kolumny pasujące
#' do wyrażenia regularnego przekazanego w argumencie \code{pomin}.
#' @param dane ramka danych do narysowania w postaci tablicy
#' @param dodajLp czy dodać kolumnę z liczbą porządkową
#' @param kolN nazwa kolumny z liczbą obserwacji (lub NA, jeśli dane nie mają
#'   być anonimizowane)
#' @param nMin wartość w kolumnie liczby obserwacji, poniżej której ma nastąpić
#'   anonimizacja kolumn liczbowych
#' @param pomin wyrażenie regularne dopasowujące nazwy kolumn, które mają nie
#'   być anonimizowane
#' @param szMin minimalna szerokość pojedynczej kolumny (gdy NA, ustawiana na
#'   \code{0.75 / liczba kolumn})
#' @param backend backend używany do wygenerowania tabeli: \code{MLAK}
#'   (oryginalny), \code{DT} (funkcja \code{DT::datatable()}) , \code{knitr}
#'   (funkcja \code{knitr::kable})
#' @param ... pozostałe parametry, które zostaną przekazane do funkcji backendu
#' @return character vector
#' @export
TAB = function(dane, dodajLp = TRUE, kolN = NA_character_, nMin = 10, pomin = '^[lL][.]?[pP][.]?$', szMin = NA_real_, backend = 'MLAK', ...){
  stopifnot(
    is.data.frame(dane),
    is.vector(dodajLp), is.logical(dodajLp), length(dodajLp) == 1, all(!is.na(dodajLp)),
    is.vector(kolN), is.character(kolN), length(kolN) == 1,
    is.vector(nMin), is.numeric(nMin), length(nMin) == 1, all(!is.na(nMin)),
    is.vector(pomin), is.character(pomin), length(pomin) == 1, all(!is.na(pomin)),
    is.vector(szMin), is.numeric(szMin), length(szMin) == 1,
    is.vector(backend), is.character(backend), length(backend) == 1, all(backend %in% c('MLAK', 'DT', 'knitr'))
  )
  if (ncol(dane) == 0 | nrow(dane) == 0) {
    return()
  }

  if (is.na(szMin)) {
    szMin = 0.75 / ncol(dane)
  }
  
  # Pozbycie się ew. data_frame i factorów, zaradzenie NA w nazwach kolumn
  dane = as.data.frame(dane, stringsAsFactors = FALSE)
  colnames(dane) = paste0(colnames(dane))
  for (k in colnames(dane)) {
    if (is.factor(dane[, k])) {
      dane[, k] = levels(dane[, k])[dane[, k]]
    }
  }
  
  # Anonimizacja
  if (!is.na(kolN)) {
    stopifnot(sum(colnames(dane) %in% kolN) == 1)
    filtr = suppressWarnings(as.numeric(dane[, kolN])) < nMin | is.na(dane[, kolN])
    for (kol in setdiff(colnames(dane)[!grepl(pomin, colnames(dane))], kolN)) {
      tmp = dane[, kol]
      # czy kolumna liczbowa
      tmp2 = suppressWarnings(as.numeric(sub('%$', '', tmp)))
      if (sum(is.na(tmp)) == sum(is.na(tmp2))) {
        dane[filtr, kol] = '-'
      }
    }
    dane[is.na(dane[, kolN]), kolN] = '-'
  }
  
  # Kolumna LP
  if (dodajLp) {
    dane = cbind(data.frame('lp' = 1:nrow(dane)), dane)
  }
  
  # Właściwa funkcja
  if (backend == 'DT') {
    DT::datatable(dane, ...)
  } else if (backend == 'knitr') {
    knitr::kable(dane, ...)
  } else {
    kolumny = data.frame(stringsAsFactors = FALSE, row.names = NULL,
      naglowek = names(dane), 
      dlNagl = sapply(names(dane), stringi::stri_length), 
      dlWart = sapply(dane, function(x){
        x = as.character(x)
        return(suppressWarnings(max(stringi::stri_length(x), na.rm = TRUE)))
      }),
      czyChar = sapply(dane, function(x){
        xx = suppressWarnings(as.numeric(sub('-$', 0, sub('%$', '', x))))
        return(sum(is.na(x)) != sum(is.na(xx)))
      })
    )
    kolumny$dlNagl[is.na(kolumny$dlNagl)] = 0
    kolumny$dlWart[is.infinite(kolumny$dlWart)] = 0
    kolumny$dlMax = apply(kolumny[, c('dlNagl', 'dlWart')], 1, function(x){
      return(max(x['dlNagl'] + 2, x['dlWart']))
    })
    # ograniczenie
    kolumny$dlMax = sapply(kolumny$dlMax, function(x){
      return(round(max(c(x, sum(kolumny$dlMax) * szMin))))
    })
  
    for (i in seq_along(names(dane))) {
      dane[, i] = as.character(dane[, i])
    }
    poczKon = paste0(rep('-', sum(kolumny$dlMax) + ncol(dane) - 1), collapse = '')
    
    # Początek
    cat('\n', poczKon, '\n', sep = '')
    # Nagłówek
    for (i in seq_along(names(dane))) {
      komorka = ifelse(
        kolumny$czyChar[i],
        paste0(c(names(dane)[i], rep(' ', kolumny$dlMax[i] - kolumny$dlNagl[i])), collapse = ''),
        paste0(c(rep(' ', kolumny$dlMax[i] - kolumny$dlNagl[i]), names(dane)[i]), collapse = '')
      )
      cat(komorka, ' ', sep = '')
    }
    cat('\n')
    # Separator nagłówka
    for (i in seq_along(names(dane))) {
      cat(rep('-', kolumny$dlMax[i]), ' ', sep = '')
    }
    cat('\n')
    # Wiersze
    for (i in seq_along(dane[, 1])) {
      for (j in seq_along(names(dane))) {
        w = ifelse(is.na(dane[i, j]), '', dane[i, j])
        cat(w, rep(' ', kolumny$dlMax[j] - stringi::stri_length(w)), ' ', sep = '')
      }
      cat('\n')
      if (i < nrow(dane)) {
        cat('\n')
      }
    }
    # Koniec
    cat(poczKon, '\n\n', sep = '')
  }
}