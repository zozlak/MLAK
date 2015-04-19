#' @title oblicza dowolną z udostępnianych przez pakiet korelacji
#' @description 
#' Wewnętrzna funkcja, która dba o jednakowy algorytm obliczania wszystkich
#' korelacji: 
#' \itemize{
#'   \item sprawdza czy x i y są odpowiednimi wektorami (jeśli to możliwe, 
#'     dokonuje potrzebnej konwersji)
#'   \item wywołuje na x i y funkcję giodo()
#'   \item usuwa z {x, y} wiersze z brakami danych
#'   \item jeśli {x, y} nie zawiera wierszy przyjmuje '-' jako wynik
#'   \item jeśli {x, y} zawiera wiersze, to liczy stosowną korelację i zaokrągla
#'     wynik zgodnie z parametrem dokl
#'   \item ew. wyrównuje długość wyniku do długości wywołania call
#' }
#' @param x wektor wartości pierwszej zmiennej
#' @param y wektor wartości drugiej zmiennej
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @param metoda sposób liczenia korelacji - argument method funkcji cor()
#' @param kwadrat czy podnieść wynik do kwadratu?
#' @param call wywołanie funkcji (np. z sys.call()), do którego wyrównywany jest wynik
#' @return NULL
#' @export
statKorelacja = function(x, y, wyrownaj, dokl, metoda, kwadrat, call){
  suppressWarnings(stopifnot(
    is.vector(x) | is.factor(x), is.numeric(x) | is.character(x) | is.logical(x) | is.factor(x),
    is.vector(y) | is.factor(y), is.numeric(y) | is.character(y) | is.logical(y) | is.factor(y),
    length(x) == length(y),
    any(!is.na(x) & !is.na(y)),
    is.vector(wyrownaj), is.logical(wyrownaj), length(wyrownaj) == 1, all(!is.na(wyrownaj)),
    is.vector(dokl), is.numeric(dokl), length(dokl) == 1, all(!is.na(dokl)),
    is.vector(metoda), is.character(metoda), length(metoda) == 1, all(metoda %in% c('pearson', 'spearman', 'kendall')),
    is.vector(kwadrat), is.logical(kwadrat), length(kwadrat) == 1, all(!is.na(kwadrat)),
    is.call(call)
  ))
  if(metoda %in% 'pearson'){
    stopifnot(
      is.numeric(x), is.numeric(y)
    )
  }
  if(!is.numeric(x)){
    x = xtfrm(x)
  }
  if(!is.numeric(y)){
    y = xtfrm(y)
  }
  dane = giodo(data.frame(x = x, y = y))
  dane = dane[!is.na(dane$x) & !is.na(dane$y), ]
  if(nrow(dane) == 0){
    wynik = '-'
  }else{
    wynik = cor(dane$x, dane$y, method = metoda)
    if(kwadrat){
      wynik = wynik^2;
    }
    if(!is.numeric(wynik) | is.na(wynik) | is.nan(wynik)){
      wynik = '-'
    }
  }
  if(wyrownaj){
    return(wyrownajDl(wynik, call, dokl))
  }else if(is.character(wynik)){
    return(wynik)
  }
  return(round(wynik, dokl))
}
