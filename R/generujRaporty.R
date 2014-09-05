#' @title generuje raporty na podstawie szablonu danych oraz opisu grup odbiorców
#' @param plikSzablonu ścieżka do pliku Markdown z szablonem raportu
#' @description
#' Przetwarzanie grup odbiorców polega na prostym ładowaniu zawartości kolejnych
#' elementów listy 'grupyOdbiorcow' jako zmiennych dostępnych w środowisku,
#' a następnie kompilacji pliku szablonu raportu. Tak więc zawartość elementóœ
#' listy 'grupyOdbiorcow' determinowana jest przez zmienne używane w szablonie
#' Markdown raportu.
#' 
#' Aby wprowadzić tu pewne uporządkowanie najlepiej trzymać się wytycznych:
#' \itemize{
#'  \item filtr definiujący najszerszą populację badaną w raporcie nazywamy 'grupaGl'
#'  \item wszelkie stałe nazywamy 'stNazwaStałej'
#' }
#' @param dane ramka danych z danymi
#' @param grupyOdbiorcow lista, której kolejne elementy określają grupy odbiorców
#' @param katalogWy katalog, w którym zapisane zostaną wygenerowane raporty (względem pliku szablonu)
#' @param prefiksPlikow prefiks nazw plików wygenerowanych raportów
#' @return NULL
#' @export
generujRaporty = function(plikSzablonu, dane, grupyOdbiorcow, katalogWy = '', prefiksPlikow = ''){
  for(i in 1:length(grupyOdbiorcow)){
    attach(grupyOdbiorcow[[i]])
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
    detach(grupyOdbiorcow[[i]])
  }
}
