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
    is.numeric(x), is.vector(x),
    is.numeric(q), is.vector(q), length(q) == 1, all(!is.na(q)),
    is.numeric(n), is.vector(n), length(n) == 1, all(!is.na(n)), n >= 1,
    is.logical(filtr), is.vector(filtr),
    length(filtr) == length(x),
    n >= q
  )
  
  tmp = stats::quantile(x[filtr], seq(0, 1, length.out = n + 1), na.rm = TRUE)
  if(q == 1){
    tmp[q] = tmp[q] - 1 # aby nie pomijać najmniejszej obserwacji
  }
  return(x <= tmp[q + 1] & x > tmp[q] & filtr & !is.na(x))
}
