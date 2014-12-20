#' @title wczytuje wskazanego odbiorcę
#' @description
#' Wczytuje z ramki danych, listy lub pliku CSV z definicjami odbiorców definicję
#' wskazanego odbiorcy (domyślnie pierwszego).
#' 
#' Jeśli definicja odbiorcy zawiera zmienne, które powinny zostać zewaluowane
#' w kontekście danych (ich nazwa zaczyna się od kropki), dokonuje ich ewaluacji
#' (i usuwa w. w. kropkę z nazw zmiennych).
#' 
#' Do definicji odbiorcy dołączane są również przekazane dane.
#' @details
#' Jeśli w środowisku ustawiona jest zmienna .nieWczytujOdbiorcy, wtedy funkcja
#' zwraca pustą listę. Służy to pominięciu wywołania wczytajOdbiorce() w treści 
#' szablonu w momencie wsadowego generowania raportów, np. funkcją 
#' generujRaporty() (którą ustawia zmienną .nieWczytujOdbiorcy).
#' @param grupy ramka danych, lista lub ścieżka do pliku CSV z definicjami grup
#'   odbiorców
#' @param dane ramka danych lub ścieżka do pliku CSV z danymi
#' @param n numer odbiorcy do wczytania
#' @return [list] definicja odbiorcy
#' @export
wczytajOdbiorce = function(grupy, dane = data.frame(), n = 1){
  if(length(ls(pattern = '^[.]nieWczytujOdbiorcy$')) > 0){
    return(list())
  }
  
  if(is.character(grupy)){
    stopifnot(
      length(grupy) == 1,
      file.exists(grupy)
    )
    grupy = wczytajDane(grupy)
  }
  if(is.character(dane)){
    stopifnot(
      length(dane) == 1,
      file.exists(dane)
    )
    dane = wczytajDane(dane)
  }
  stopifnot(
    is.data.frame(dane),
    is.list(grupy) | is.data.frame(grupy)
  )
  
  if(is.data.frame(dane)){
    attach(dane)
    on.exit({
      detach(dane)
    })
  }
 
  if(is.data.frame(grupy)){
    odbiorca = grupy[n, ]
  }else{
    odbiorca = grupy[[n]]
  }

  tmp = names(odbiorca)
  kolEval = grep('^[.]', names(odbiorca))
  odbiorca = as.list(odbiorca)
  names(odbiorca) = sub('^[.]', '', tmp)
  
  for(i in kolEval){
    odbiorca[[i]] = eval(parse(text = odbiorca[[i]]))
  }
  
  odbiorca = append(odbiorca, dane)  
  return(odbiorca)
}