#' @title formatuje wartość do długości wywołania funkcji
#' @description
#' Dopełnia wartość spacjami po lewej stronie, tak by łączna długość 
#' utworzonego łańcucha znaków była równa liczbie znaków kodu wywołania funkcji
#' przekazanej w parametrze "call" plus tyle znaków, ile wynosi parametr 
#' "delta"
#' @param wynik wartość do sformatowania
#' @param call wywołanie funkcji (np. z sys.call()), do którego wyrównywany jest wynik
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @param delta liczba znaków, która ma zostać doliczna do długości wywołania
#' @return character
wyrownajDl = function(wynik, call, dokl, delta = 4){
  dl = delta + sum(nchar(deparse(call)))
  if(max(nchar(wynik)) > dl){
    warning('Wyrównanie długości nie było możliwe')
  }
  format = ifelse(
    is.character(wynik),
    paste0('% ', dl, 's'),
    paste0('% ', dl, '.', dokl, 'f')
  )
  return(setNames(sprintf(format, wynik), names(wynik)))
}
