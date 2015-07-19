#' @title rysuje tablicę na podstawie ramki danych
#' @description
#' W wypadku, gdy liczba wierszy w tablicy jest nieprzewidywalna, nie da się opisać tablicy w szablonie raportu za pomocą kodu markdown.
#' Funkcja \code{TAB} pozwala obejść to ograniczenie rysując tablicę na podstawie dowolnej ramki danych.
#' 
#' Tablica rysowana jest w składni multiline tables, a więc z zapewnieniem łamania wierszy w komórkach.
#' 
#' Kolumny zawierające wartości liczbowe są wyrównane do prawej, zaś kolumny tekstowe do lewej (być może w przyszłości pojawi się możliwość ręcznego określania wyrównania).
#' @param dane ramka danych do narysowania w postaci tablicy
#' @return character vector
#' @export
TAB = function(dane){
  stopifnot(
    is.data.frame(dane)
  )
  if(ncol(dane) == 0 | nrow(dane) == 0){
    return()
  }
  
  kolumny = data.frame(stringsAsFactors = FALSE, row.names = NULL,
    naglowek = names(dane), 
    dlNagl = sapply(names(dane), stringi::stri_length), 
    dlWart = sapply(dane, function(x){
      x = as.character(x)
      return(max(stringi::stri_length(x)))
    }),
    czyChar = sapply(dane, function(x){
      return(is.character(x) | is.factor(x))
    })
  )
  kolumny$dlMax = apply(kolumny[, c('dlNagl', 'dlWart')], 1, function(x){
    return(max(x['dlNagl'] + 2, x['dlWart']))
  })

  for(i in seq_along(names(dane))){
    dane[, i] = as.character(dane[, i])
  }
  poczKon = paste0(rep('-', sum(kolumny$dlMax) + ncol(dane) - 1), collapse = '')
  
  # Początek
  cat('\n', poczKon, '\n', sep = '')
  # Nagłówek
  for(i in seq_along(names(dane))){
    komorka = ifelse(
      kolumny$czyChar[i],
      paste0(c(names(dane)[i], rep(' ', kolumny$dlMax[i] - kolumny$dlNagl[i])), collapse = ''),
      paste0(c(rep(' ', kolumny$dlMax[i] - kolumny$dlNagl[i]), names(dane)[i]), collapse = '')
    )
    cat(komorka, ' ', sep = '')
  }
  cat('\n')
  # Separator nagłówka
  for(i in seq_along(names(dane))){
    cat(rep('-', kolumny$dlMax[i]), ' ', sep ='')
  }
  cat('\n')
  # Wiersze
  for(i in seq_along(dane[, 1])){
    for(j in seq_along(names(dane))){
      w = dane[i, j]
      cat(w, rep(' ', kolumny$dlMax[j] - stringi::stri_length(w)), ' ', sep = '')
    }
    cat('\n')
    if(i < nrow(dane)){
      cat('\n')
    }
  }
  # Koniec
  cat(poczKon, '\n\n', sep = '')
}