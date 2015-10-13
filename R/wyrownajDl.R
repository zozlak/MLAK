#' @title formatuje wartość do długości wywołania funkcji
#' @description
#' Dopełnia wartość spacjami po lewej stronie, tak by łączna długość 
#' utworzonego łańcucha znaków była równa liczbie znaków kodu wywołania funkcji
#' przekazanej w parametrze "call" plus tyle znaków, ile wynosi parametr 
#' "delta"
#' 
#' Jeśli w stosie wywołań odnaleziona zostanie funkcja mutate_, summarize_ bądź
#' summarise_, wtedy uznaje się, że wyrównywanie nie ma sensu (ze względu na to,
#' że wywołanie zawiera wtedy podstawione wartości argumentów i jest absurdalnie
#' długie, jak również praktycznie na pewno nie jest ono używane do zwracania
#' wartości wprost do raportu) i długość wyrównania jest automatycznie ustawiana
#' na \code{max(nchar(wynik))}. Niestety podczas stosowania summarize nie można
#' całkowicie zrezygnować z wyrównywania, bo w wypadku, gdy część grup zwróci
#' stringi, a część liczby, próbuje ono z uporem godnym lepszej sprawy rzutować
#' stringi na liczby, czego wynikiem są bardzo dziwne wartości liczbowe (z '-'
#' wychodzą np. bardzo, bardzo małe, ale bynajmniej nie zerowe wartości).
#' @param wynik wartość do sformatowania
#' @param call wywołanie funkcji (np. z sys.call()), do którego wyrównywany jest wynik
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @param delta liczba znaków, która ma zostać doliczna do długości wywołania
#' @return character
wyrownajDl = function(wynik, call, dokl, delta = 4){
  # obejście dla funkcji pakietu dplyr
  stos = unlist(lapply(sys.calls(), function(x){
    return(deparse(x)[1])
  }))
  if(any(grepl('^(summari[sz]e_|mutate_)', stos))){
    dl = max(nchar(wynik))
  }else{
    # normalne liczenie długości
    dl = delta + sum(nchar(deparse(call))) 
  }
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
