#' @title wczytuje wskazanego odbiorcę
#' @description
#' Wczytuje z ramki danych, listy lub pliku CSV/XLSX z definicjami odbiorców
#' definicję
#' wskazanego odbiorcy (domyślnie pierwszego).
#' 
#' Jeśli definicja odbiorcy zawiera zmienne, które powinny zostać zewaluowane
#' w kontekście danych (ich nazwa zaczyna się od kropki), dokonuje ich ewaluacji
#' (i usuwa w. w. kropkę z nazw zmiennych).
#' 
#' Do definicji odbiorcy dołączane są również przekazane dane.
#' @details Funkcja sprawdza, czy, a jeśli tak, to gdzie, w ścieżce wywołań
#' znajduje się funkcja generujRaporty(). W wypadku, gdy generujRaporty()
#' znajduje się w ścieżce wywołań, ale wczytajOdbiorce() nie zostało wywołane
#' bezpośrednio z niej, zwracana jest pusta lista. Służy to pominięciu wywołania
#' wczytajOdbiorce() w treści szablonu w momencie wsadowego generowania raportów
#' funkcją generujRaporty().
#' @param grupy ramka danych, lista lub ścieżka do pliku CSV z definicjami grup 
#'   odbiorców
#' @param dane ramka danych lub ścieżka do pliku z danymi
#' @param daneMiesieczne ramka danych lub ścieżka do pliku z danymi miesięcznymi
#' @param n numer odbiorcy do wczytania
#' @param dolacz czy dołączyć (funkcją attach) wczytane dane do środowiska, w
#'   którym funkcja została uruchomiona
#' @param kodowanie kodowanie polskich znaków stosowane w plikach opisu grup i
#'   danych (istotne tylko w wypadku plików CSV)
#' @param separator separator plików CSV (istotny tylko w wypadku plików CSV)
#' @return [list] definicja odbiorcy
#' @export
wczytajOdbiorce = function(grupy, dane = data.frame(), daneMiesieczne = data.frame(), n = 1, dolacz = TRUE, kodowanie = 'Windows-1250', separator = ';'){
  # aby nie było potrzebne oddzielne wywolywanie przy generowaniu raportu
  # wprost z RStudio
  konfigurujKnitr()
  
  # pobieramy stos wywołań; uwaga:
  # - pozycja 1 to funkcja najwyższego poziomu
  # - pozycja ostatnia to funkcja, w której właśnie jesteśmy
  stos = unlist(lapply(sys.calls(), function(x){
    return(deparse(x)[1])
  }))
  pozShiny = any(grepl('shiny::runApp', stos))
  pozGenRap = suppressWarnings(max(seq_along(stos)[grepl('^generujRaporty', stos)]))
  if(pozShiny | length(pozGenRap) > 0 & pozGenRap != length(stos) - 1 & !is.infinite(pozGenRap)){
    return(ifelse(dolacz, invisible(list()), list()))
  }
  
  if(is.character(grupy)){
    stopifnot(
      length(grupy) == 1,
      file.exists(grupy)
    )
    grupy = wczytajDane(grupy, kodowanie, separator)
  }
  if(is.character(dane)){
    stopifnot(
      length(dane) == 1,
      file.exists(dane)
    )
    dane = wczytajDane(dane, kodowanie, separator)
  }
  if(is.character(daneMiesieczne)){
    stopifnot(
      length(daneMiesieczne) == 1,
      file.exists(daneMiesieczne)
    )
    daneMiesieczne = wczytajDane(daneMiesieczne, kodowanie, separator)
  }
  stopifnot(
    is.list(grupy) | is.data.frame(grupy),
    is.data.frame(dane),
    is.data.frame(daneMiesieczne)
  )
  
  if(is.data.frame(grupy)){
    odbiorca = grupy[n, ]
  }else{
    odbiorca = grupy[[n]]
  }

  odbiorca = as.list(odbiorca)
  kolEval = grep('^[.]', names(odbiorca), value = T)

  if(length(kolEval) > 0){
    odbiorca = with(
      dane,
      {
        for(i in kolEval){
          odbiorca[[i]] = eval(parse(text = odbiorca[[i]]))
        }
        return(odbiorca)
      }
    )
  }

  names(odbiorca) = sub('^[.]', '', names(odbiorca))  
  
  odbiorca = append(append(odbiorca, dane), daneMiesieczne)
  if(dolacz){
    while(any(grepl('^odbiorca$', search()))){
      detach(pos = grep('^odbiorca$', search()))
    }
    suppressWarnings(attach(odbiorca))
    return(invisible(odbiorca))
  }
  return(odbiorca)
}
