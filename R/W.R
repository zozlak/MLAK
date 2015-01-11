#' @title wyrównanie długości
#' @description
#' Zwraca przekazany argument wyrównując go spacjami z lewej, tak by długość
#' zwróconej wartości odpowiadała długości wstawki R.
#' 
#' Przydatna do wstawianie wartości do multiline tables w wypadku, gdy wyniki
#' obliczono wcześniej w innej wstawce R.
#' @param x wartość
#' @return NULL
#' @export
W = function(x){
  dl = 4 + nchar(deparse(sys.call()))
  return(sprintf(paste0('% ', dl, 's'), x))
}
