#' Łamie przekazany wektor znaków
#' @description
#' Łamie przekazany wektor znaków, tak by długość pojedynczej linii nie
#' przekraczała zadanej liczby znaków.
#' @param wektor wektor znaków do połamania
#' @param n maksymalna liczba znaków w linii
#' @param wymus czy łamać tekst, jeśli zawiera znaki nowej linii
#' @return [character] połamany wektor znaków
polamTekst = function(wektor, n = 15, wymus = FALSE){
  stopifnot(
    is.vector(wektor) | is.factor(wektor),
    is.vector(n), is.numeric(n), length(n) == 1, all(!is.na(n)),
    is.vector(wymus), is.logical(wymus), length(wymus) == 1, all(!is.na(wymus))
  )
  
  dodajOdstepy = function(x){
    x = sub('^\n+', '', x)
    x = sub('\n+$', '', x)
    return(paste0('\n', x, '\n'))
  }
  
  if(any(grepl('\n', wektor))){
    if(wymus){
      wektor = sub('\n', ' ', wektor)
    }else{
      return(dodajOdstepy(wektor))
    }
  }
  
  wektor = gsub(' +', ' ', wektor)
  wyrazy = strsplit(wektor, ' ')
  wynik = sapply(wyrazy, function(x){
    suma = 0
    wynik = ''
    for(i in seq_along(x)){
      dl = nchar(x[i])
      if(suma > 0 & suma + 1 + dl > n){
        wynik = paste0(wynik, '\n')
        suma = 0
      }else if(suma > 0){
        wynik = paste0(wynik, ' ')
        suma = suma + 1
      }
      wynik = paste0(wynik, x[i])
      suma = suma + dl
    }
    return(dodajOdstepy(wynik))
  })
  return(dodajOdstepy(wynik))
}
