#' @title generuje raporty na podstawie szablonu danych oraz opisu grup
#'   odbiorców
#' @description Pliki raportów tworzone są ze złączenia prefiksu z wartością z
#' pierwszej kolumny ramki danych opisującej odbiorców (a gdy odbiorcy opisywani
#' są listą przez nazwy elementów listy).
#' 
#' Kolumny ramki danych parametru 'grupyOdbiorcow' odpowiadają zmiennym używanym
#' w szablonie Markdown raportu, a wiersze kolejnym grupom odbiorców. Przy tym 
#' te zmienne ramki danych, których nazwy zaczynają się kropką są: \itemize{ 
#' \item ewaluowane w środowisku danych (a więc w ten sposób należy definiować
#' wszelkie filtry) \item przed przekazaniem do szablonu ich nazwa pozbawiana
#' jest wiodącej kropki }
#' 
#' Parametr 'grupy Odbiorcow' może być również listą. W taki wypadku 
#' przetwarzanie grup odbiorców polega na prostym ładowaniu zawartości kolejnych
#' elementów listy 'grupyOdbiorcow' jako zmiennych dostępnych w środowisku, a 
#' następnie kompilacji pliku szablonu raportu.
#' @param plikSzablonu ścieżka do pliku Markdown z szablonem raportu
#' @param grupyOdbiorcow ramka danych (lub lista), której kolejne elementy
#'   określają grupy odbiorców
#' @param dane lista ramka danych, ścieżka do plików z danymi, lista ramek danych
#'   lub wektor ścieżek do plików z danymi
#' @param katalogWy katalog, w którym zapisane zostaną wygenerowane raporty 
#'   (względem pliku szablonu); uwaga! jeśli podany, wtedy pełna ścieżka 
#'   katalogu wyjściowego nie może zawierać polskich znaków ani spacji (sic!)
#' @param prefiksPlikow prefiks nazw plików wygenerowanych raportów
#' @param sprzataj czy usuwać pliki tymczasowe wytworzone w trakcie generowania
#'   ostatecznych PDF-ów
#' @param kontynuujPoBledzie czy kontynuować generowania raportów jeśli podczas
#'   generowania jednego z nich wystąpił błąd
#' @param paramRender dodatkowe parametry do przekazania funkcji
#'   \code{\link[rmarkdown]{render}}
#' @param paramRender dodatkowe parametry do przekazania funkcji
#'   \code{\link[rmarkdown]{pdf_document}}
#' @return NULL
#' @import rmarkdown
#' @export
generujRaporty = function(plikSzablonu, grupyOdbiorcow, dane = list(), katalogWy = '', prefiksPlikow = '', sprzataj = TRUE, kontynuujPoBledzie = TRUE, paramRender = list(), paramPdfDocument = list()){
  stopifnot(
    is.vector(katalogWy), is.character(katalogWy), length(katalogWy) == 1, all(!is.na(katalogWy)),
    is.vector(prefiksPlikow), is.character(prefiksPlikow), length(prefiksPlikow) == 1, all(!is.na(prefiksPlikow)),
    is.vector(kontynuujPoBledzie), is.logical(kontynuujPoBledzie), length(kontynuujPoBledzie) == 1, all(!is.na(kontynuujPoBledzie))
  )
  
  konfigurujKnitr()
  
  if (is.character(grupyOdbiorcow)) {
    stopifnot(
      length(grupyOdbiorcow) == 1,
      file.exists(grupyOdbiorcow)
    )
    grupyOdbiorcow = wczytajDane(grupyOdbiorcow)
  }
  if (is.character(dane)) {
    sciezki = dane
    dane = list()
    for (i in sciezki) {
      stopifnot(
        file.exists(i)
      )
      dane[[length(dane) + 1]] = wczytajDane(i)
    }
  }
  stopifnot(
    is.data.frame(grupyOdbiorcow) | is.list(grupyOdbiorcow),
    is.list(dane)
  )
  katalogBazowy = katalogWy
  if (katalogWy == '') {
    katalogWy = NULL
    katalogBazowy = sub('[^/\\]+$', '', plikSzablonu)
  }

  # przerabianie grup odbiorców podanych jako ramka danych na listę
  if (is.data.frame(grupyOdbiorcow)) {
    tmp = list()
    for (i in 1:nrow(grupyOdbiorcow)) {
      tmp[[i]] = as.list(grupyOdbiorcow[i, ])
    }
    names(tmp) = grupyOdbiorcow[, 1]
    grupyOdbiorcow = tmp
  }
  
  paramRender[['input']] = plikSzablonu
  paramRender[['output_format']] = do.call(rmarkdown::pdf_document, paramPdfDocument)
  paramRender[['output_dir']] = katalogWy
  for (i in 1:length(grupyOdbiorcow)) {
    odbiorca = wczytajOdbiorce(grupyOdbiorcow, dane, i)
    tryCatch(
      {
        with(
          odbiorca, 
          {
            paramRender[['output_file']] = paste0(prefiksPlikow, names(grupyOdbiorcow)[i], '.pdf')
            do.call(rmarkdown::render, paramRender)
          }
        )
      },
      error = function(e){
        if (!kontynuujPoBledzie) {
          stop(e)
        }
      }
    )
  }
}
