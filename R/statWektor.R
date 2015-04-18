#' @title oblicza wskazaną statystykę dla wskazanego wektora danych
#' @description
#' \itemize{
#'   \item sprawdza czy x jest wektorem
#'   \item wywołuje na x funkcję giodo()
#'   \item usuwa z x braki danych
#'   \item jeśli wektor x jest pusty przyjmuje '-' jako wynik
#'   \item jeśli wektor x nie jest pusty, wywołuje na x funkcję f i 
#'     zaokrągla wynik zgodnie z parametrem dokl
#'   \item ew. wyrównuje długość wyniku do długości wywołania call
#' }
#' @param x wektor wartości lub ramka danych wartości
#' @param f funkcja do wykonania na x
#' @param call wywołanie, do którego długości wyrównywany jest wynik
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return zależnie od funkcji f
statWektor = function(x, f, call, wyrownaj = T, dokl = 2){
  stopifnot(
    is.vector(x),
      is.numeric(x) | is.character(x) | is.logical(x),
    is.vector(wyrownaj), is.logical(wyrownaj), length(wyrownaj) == 1, all(!is.na(wyrownaj)),
    is.vector(dokl), is.numeric(dokl), length(dokl) == 1, all(!is.na(dokl))
  )
  x = giodo(x)
  x = x[!is.na(x)]
  if(length(x) == 0){
    wynik = '-'
  }else{
    wynik = f(x)
    if(!is.numeric(wynik)){
      wynik[] = '-'
    }
    if(any(is.na(wynik)) | any(is.nan(wynik)) | any(is.infinite(wynik))){
      wynik[is.na(wynik) | is.nan(wynik) | is.infinite(wynik)] = '-'
    }
  }
  
  if(wyrownaj){
    return(wyrownajDl(wynik, call, dokl))
  }else if(is.character(wynik)){
    return(wynik)
  }
  return(round(wynik, dokl))
}
