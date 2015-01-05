#' @title wczytuje dane z pliku rozpoznając typ pliku
#' @description
#' Wczytuje dane ze wskazanego pliku automatycznie dostosowując sposób ich 
#' wczytania do typu pliku (obecnie obsługiwane CSV i RData).
#' 
#' W wypadku plików RData zwracane są wszystkie ramki danych zawarte w pliku.
#' Jeśli jest ich wiele, zwracana jest ich lista, jeśli tylko jedna, zwracana
#' jest wprost jako ramka danych.
#' @param plik ścieżka do pliku danych
#' @return wczytane dane
#' @export
wczytajDane = function(plik){
  stopifnot(
    file.exists(plik),
    grepl('[.](csv|rdata)$', tolower(plik))
  )
  
  plikL = tolower(plik)
  if(grepl('csv$', plikL)){
    dane = wczytajCSV(plik)
  }else if(grepl('rdata$', plikL)){
    srodowisko = new.env()
    load(plik, srodowisko, FALSE)
    dane = list()
    for(i in ls(, envir = srodowisko)){
      tmp = get(i, envir = srodowisko)
      if(is.data.frame(tmp)){
        dane[[i]] = tmp
      }
    }
    if(length(dane) == 0){
      dane = data.frame()
    }else if(length(dane) == 1){
      dane = dane[[1]]
    }
  }
  
  return(dane)
}