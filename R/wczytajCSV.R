#' @title wczytuje dane z CSV
#' @description nakładka na read.table zapewniająca wartości domyślne zgodne z 
#'   formatem zapisu plików CSV przez Excel-a
#' @param plik ścieżka do pliku CSV
#' @param sep separator kolumn (domyślnie ;)
#' @param quote separator tekstu (domyślnie ")
#' @param dec separator dziesiętny (domyślnie ,)
#' @param fileEncoding kodowanie pliku CSV (domyślnie Windows-1250)
#' @param header czy pierwszy wiersz to nagłówki kolumn (domyślnie TRUE)
#' @param fill czy wyrównywać NA linie krótsze od pozostałych
#' @param comment.char znak rozpoczynający linie będące komentarzem
#' @param stringsAsFactors czy przekształcać stringi na factor-y (domyślnie FALSE)
#' @param ... wszelkie argumenty funkcji read.table
#' @return [data.frame] wczytane dane
#' @export
wczytajCSV = function(
  plik, 
  sep = ';', 
  quote = '"', 
  dec = ',', 
  fileEncoding = 'Windows-1250', 
  header = TRUE, 
  fill = T, 
  comment.char = '', 
  stringsAsFactors = FALSE, 
  ...
){
  return(utils::read.table(
    plik, 
    header = header,
    sep = sep,
    quote = quote,
    dec = dec,
    fill = fill,
    comment.char = comment.char,
    stringsAsFactors = stringsAsFactors, 
    fileEncoding = fileEncoding, 
    ...
  ))
}
