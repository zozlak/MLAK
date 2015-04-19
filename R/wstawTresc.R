#' @title wykonuje wstawki R w danym kodzie Markdown i wypisuje wynik za pomocą 
#'   cat
#' @param kod kod Markdown (z ew. wstawkami R) do wykonania lub ścieżka do pliku .Rmd
#' @return przetworzony kod
#' @export
#' @import knitr
wstawTresc = function(kod){
  stopifnot(
    is.character(kod),
    length(kod) == 1
  )
  
  if(file.exists(kod)){
    kod = readChar(kod, 10^6)
  }
  
  plik = tempfile(fileext = '.Rmd')
  writeChar(kod, plik)
  plikMd = knit(plik, tempfile(fileext = '.md'), quiet = TRUE, envir = parent.frame())
  kodMd = readChar(plikMd, 10^6)
  unlink(c(plik, plikMd))
  cat(kodMd)
  return(invisible(kodMd))
}
