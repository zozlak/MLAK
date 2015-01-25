#' @title generuje raporty na podstawie szablonu danych oraz opisu grup odbiorców
#' @description
#' Przetwarzanie grup odbiorców polega na prostym ładowaniu zawartości kolejnych
#' elementów listy 'grupyOdbiorcow' jako zmiennych dostępnych w środowisku,
#' a następnie kompilacji pliku szablonu raportu. Tak więc zawartość elementów
#' listy 'grupyOdbiorcow' determinowana jest przez zmienne używane w szablonie
#' Markdown raportu.
#' 
#' Aby wprowadzić tu pewne uporządkowanie najlepiej trzymać się wytycznych:
#' \itemize{
#'   \item filtr definiujący najszerszą populację badaną w raporcie nazywamy 'grupaGl'
#'   \item wszelkie stałe nazywamy 'stNazwaStałej'
#' }
#' 
#' Parametr 'grupyOdbiorcow' może być również ramką danych. W takim wypadku 
#' kolumny ramki danych odpowiadają zmiennym używanym w szablonie Markdown 
#' raportu, a wiersze kolejnym grupom odbiorców. Przy tym te zmienne ramki
#' danych, których nazwy zaczynają się kropką są:
#' \itemize{
#'   \item ewaluowane w środowisku danych (a więc w ten sposób należy 
#'     definiować wszelkie filtry)
#'   \item przed przekazaniem do szablonu ich nazwa pozbawiana jest wiodącej 
#'     kropki
#' }
#' 
#' @param plikSzablonu ścieżka do pliku Markdown z szablonem raportu
#' @param dane ramka danych lub ścieżka do pliku CSV z danymi
#' @param grupyOdbiorcow lista, której kolejne elementy określają grupy odbiorców
#' @param katalogWy katalog, w którym zapisane zostaną wygenerowane raporty (względem pliku szablonu)
#' @param prefiksPlikow prefiks nazw plików wygenerowanych raportów
#' @return NULL
#' @import rmarkdown
#' @export
generujRaporty = function(plikSzablonu, dane, grupyOdbiorcow, katalogWy = '', prefiksPlikow = ''){
  #TODO kiedyś należy to zrobić bardziej elegancko
  pdf.options(encoding = 'CP1250')
  
  if(is.character(dane)){
    stopifnot(
      length(dane) == 1,
      file.exists(dane)
    )
    dane = wczytajDane(dane)
  }
  if(is.character(grupyOdbiorcow)){
    stopifnot(
      length(grupyOdbiorcow) == 1,
      file.exists(grupyOdbiorcow)
    )
    grupyOdbiorcow = wczytajDane(grupyOdbiorcow)
  }
  stopifnot(
    is.data.frame(dane),
    is.data.frame(grupyOdbiorcow) | is.list(grupyOdbiorcow)
  )

  # przerabianie grup odbiorców podanych jako ramka danych na listę
  if(is.data.frame(grupyOdbiorcow)){
    tmp = list()
    for(i in 1:nrow(grupyOdbiorcow)){
      tmp[[i]] = as.list(grupyOdbiorcow[i, ])
    }
    names(tmp) = grupyOdbiorcow[, 1]
    grupyOdbiorcow = tmp
  }
  
  for(i in 1:length(grupyOdbiorcow)){
    suppressWarnings(rm(.nieWczytujOdbiorcy))
    odbiorca = wczytajOdbiorce(grupyOdbiorcow, dane, i)
    with(
      odbiorca, 
      {
        .nieWczytujOdbiorcy = TRUE
        render(
          input = plikSzablonu, 
          output_format = pdf_document(),
          output_file = paste0(
            prefiksPlikow,
            names(grupyOdbiorcow)[i],
            '.pdf'
          ),
          output_dir = katalogWy
        )
      }
    )
  }
}
