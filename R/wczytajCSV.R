#' @title nakładka na read.csv2 ustawiająca kilka przydatnych wartości domyślnych
#' @param plik ścieżka do pliku CSV
#' @param ... wszelkie argumenty funkcji read.csv2
#' @description
#' Wywołuje read.csv2() z parametrami stringsAsFactors = FALSE oraz fileEncoding = 'Windows-1250'
#' @return NULL
#' @export
wczytajCSV = function(plik, ...){
  return(read.csv2(plik, stringsAsFactors = F, fileEncoding = 'Windows-1250', ...))
}
