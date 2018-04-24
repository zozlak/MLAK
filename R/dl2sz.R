#' @title przekształca dane z postaci długiej do szerokiej
#' @description \code{\link[reshape2]{dcast}} oraz \code{\link[tidyr]{spread}} 
#'   są o tyle niewygodne, że wymagają danych w postaci "kanonicznie długiej". 
#'   Tymczasem wygodnie jest móc przekształcić do postaci "prawdziwie szerokiej"
#'   dane w formie "pośredniej", np. `okres` (wartości 1, 2, 3), `zm1`, `zm2` 
#'   przekształcić na `zm1_1`, `zm1_2`, `zm1_3`, `zm2_1`, `zm2_2`, `zm2_3`.
#'   
#'   Funkcja dostarcza skrótowej składni do wykonania takiej właśnie operacji.
#'   
#'   Wewnętrznie wykonuje \code{\link[tidyr]{spread}} na każdej z wyznaczonych 
#'   zmiennych, a następnie łączy wyniki za pomocą
#'   \code{\link[dplyr]{full_join}}.
#' @details Jeśli parametr \code{id} (lub \code{zmienne}) nie zostanie podany,
#' zostanie on wywiedziony jako "wszystkie kolumny danych wejściowych z
#' wyłączeniem tych, na które wskazuje parametr \code{klucz} oraz \code{zmienne}
#' (\code{id})". Oznacza to oczywiście, że przynajmnie jeden z parametrów
#' \code{id} i \code{zmienne} musi zostać podany.
#' @param dane ramka danych z danymi w postaci "pośredniej"
#' @param klucz kolumna zawierająca sufiksy, które stworzą nowe kolumny
#' @param id wektor nazw zmiennych będących kluczami (dane wyjściowe będą miały
#'   tyle wierszy, ile jest unikalnych kombinacji wartości tych kolumn w danych
#'   wejściowych)
#' @param zmienne wektor nazw zmiennych, które mają zostać przetworzone do
#'   postaci "szerokiej"
#' @import dplyr
#' @export
dl2sz = function(dane, klucz, id = character(), zmienne = character()) {
  stopifnot(
    is.data.frame(dane),
    is.vector(klucz), is.character(klucz), length(klucz) == 1, all(klucz %in% names(dane)),
    is.vector(id), is.character(id), all(id %in% names(dane)),
    is.vector(zmienne), is.character(zmienne), all(zmienne %in% names(dane)),
    length(zmienne) + length(id) > 0
  )

  if (length(id) == 0) {
    id = setdiff(names(dane), c(zmienne, klucz))
  }
  if (length(zmienne) == 0) {
    zmienne = setdiff(names(dane), c(id, klucz))
  }
  
  wynik = dane %>%
    select_(.dots = id) %>%
    distinct()
  for (zm in zmienne) {
    tmp = dane %>%
      select_(.dots = c(id, klucz, zm)) %>%
      rename_(.klucz = klucz) %>%
      mutate_(.klucz = ~paste0(zm, .klucz)) %>%
      tidyr::spread_('.klucz', zm)
    wynik = full_join(wynik, tmp)
  }
  return(wynik)
}