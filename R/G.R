#' @title wyznacza grupę ze względu na kwantyle
#' @description
#' Zwraca wektor wybierający obserwacje, które jednocześnie:
#' \itemize{
#'   \item należą do grupy wyznaczanej przez parametr filtr
#'   \item w ramach w. w. grupy należą do kwantyla q (spośród
#'     n kwantyli) ze względu na wartość zmiennej przekazanej
#'     w parametrze x
#' }
#' @param x wartości wg których nastąpi podział na grupy
#' @param q numer kwantyle
#' @param n liczba kwantyli
#' @param filtr globalny filtr obserwacji
#' @return [logical.vector]
#' @export
G = function(x, q, n, filtr = NULL){
  if(is.null(filtr)){
    filtr = rep(T, length(x))
  }
  stopifnot(
    is.numeric(x),
    is.numeric(q),
    is.numeric(n),
    is.logical(filtr),
    length(q) == 1,
    length(n) == 1,
    length(filtr) == length(x),
    n >= q,
    n >= 1
  )
  
  tmp = quantile(x[filtr], seq(0, 1, length.out = n + 1))
  if(q == 1){
    tmp[q] = tmp[q] - 1 # aby nie pomijać najmniejszej obserwacji
  }
  return(x <= tmp[q + 1] & x > tmp[q] & filtr)
}