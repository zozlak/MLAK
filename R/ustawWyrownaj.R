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
#' @return logical
ustawWyrownaj = function(wyrownaj){
  stopifnot(
    is.vector(wyrownaj), is.logical(wyrownaj), length(wyrownaj) == 1
  )
  if(is.na(wyrownaj)){
    wyrownaj = FALSE
    stos = paste0(sys.calls())
    pozInline = length(stos) - suppressWarnings(max(which(grepl('^process_group.inline[(]', stos))))
    pozBlock  = length(stos) - suppressWarnings(max(which(grepl('^process_group.block[(]', stos))))
    if(pozInline == 8 | pozBlock == 12){
      wyrownaj = TRUE
    }
  }
  return(wyrownaj)
}