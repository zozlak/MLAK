#' @title zgaduje, czy należy dokonać wyrównania długości zwracanej wartości
#' @description
#' Jeśli parametr \code{wyrownaj} nie jest brakiem danych, jest po prostu 
#' zwracany. W wypadku, gdy jest brakiem danych, następuje sprawdzenie, czy 
#' środowisko znajdujące się o \code{offset} pozycji wyżej w hierarhii środowisk
#' jest tym samym, w którym załadowano pakiet MLAK. Jeśli tak, zwracana jest
#' wartość \code{TRUE}, jeśli nie, zwracana jest wartość \code{FALSE}.
#' Wyrównywanie zwracanej wartości ma bowiem sens w zasadzie jedynie w wypadku
#' zwracania jej wprost do wstawki markdown, jeśli natomiast będzie ona dalej
#' przetwarzana przez inne funkcje R, wtedy prawie na pewno nie powinna być
#' wyrównywana.
#' @param wyrownaj obecna wartość wyrownaj
#' @param offset o ile środowisk wyżej w hierarchii środowisk dokonać porównania
#' @return logical
ustawWyrownaj = function(wyrownaj, offset = 2){
  stopifnot(
    is.vector(wyrownaj), is.logical(wyrownaj), length(wyrownaj) == 1,
    is.vector(offset), is.numeric(offset), length(offset) == 1, all(!is.na(offset))
  )
  if(is.na(wyrownaj)){
    wyrownaj = FALSE
    try({
      get('.MLAK', envir = sys.frame(sys.nframe() - offset), inherits = FALSE)
      wyrownaj = TRUE
    }, silent = TRUE)
  }
  return(wyrownaj)
}