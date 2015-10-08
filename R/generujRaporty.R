#' @title generuje raporty na podstawie szablonu danych oraz opisu grup odbiorców
#' @description
#' Pliki raportów tworzone są ze złączenia prefiksu z wartością z pierwszej 
#' kolumny ramki danych opisującej odbiorców (a gdy odbiorcy opisywani są listą
#' przez nazwy elementów listy).
#' 
#' Kolumny ramki danych parametru 'grupyOdbiorcow' odpowiadają zmiennym używanym
#' w szablonie Markdown raportu, a wiersze kolejnym grupom odbiorców. Przy tym
#' te zmienne ramki danych, których nazwy zaczynają się kropką są:
#' \itemize{
#'   \item ewaluowane w środowisku danych (a więc w ten sposób należy 
#'     definiować wszelkie filtry)
#'   \item przed przekazaniem do szablonu ich nazwa pozbawiana jest wiodącej 
#'     kropki
#' }
#'
#' Parametr 'grupy Odbiorcow' może być również listą. W taki wypadku
#' przetwarzanie grup odbiorców polega na prostym ładowaniu zawartości kolejnych
#' elementów listy 'grupyOdbiorcow' jako zmiennych dostępnych w środowisku, a
#' następnie kompilacji pliku szablonu raportu.
#' @param plikSzablonu ścieżka do pliku Markdown z szablonem raportu
#' @param dane ramka danych lub ścieżka do pliku CSV z danymi
#' @param grupyOdbiorcow ramka danych (lub lista), której kolejne elementy określają grupy odbiorców
#' @param katalogWy katalog, w którym zapisane zostaną wygenerowane raporty
#'   (względem pliku szablonu); uwaga! jeśli podany, wtedy pełna ścieżka
#'   katalogu wyjściowego nie może zawierać polskich znaków ani spacji (sic!)
#' @param prefiksPlikow prefiks nazw plików wygenerowanych raportów
#' @param ramkiTablic czy przekształcać wyjściowy kod TeX-a w celu uzyskania ramek w tabelach
#' @param sprzataj czy usuwać pliki tymczasowe wytworzone w trakcie generowania ostatecznych PDF-ów
#' @return NULL
#' @import rmarkdown
#' @export
generujRaporty = function(plikSzablonu, dane, grupyOdbiorcow, katalogWy = '', prefiksPlikow = '', ramkiTablic = FALSE, sprzataj = TRUE){
  stopifnot(
    is.vector(katalogWy), is.character(katalogWy), length(katalogWy) == 1, all(!is.na(katalogWy)),
    is.vector(prefiksPlikow), is.character(prefiksPlikow), length(prefiksPlikow) == 1, all(!is.na(prefiksPlikow)),
    is.vector(ramkiTablic), is.logical(ramkiTablic), length(ramkiTablic) == 1, all(!is.na(ramkiTablic))
  )
  
  konfigurujKnitr()
  
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
  katalogBazowy = katalogWy
  if(katalogWy == ''){
    katalogWy = NULL
    katalogBazowy = sub('[^/\\]+$', '', plikSzablonu)
  }

  if(ramkiTablic){
    katalogRoboczy = getwd()
    on.exit({setwd(katalogRoboczy)})
  }
  
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
    odbiorca = wczytajOdbiorce(grupyOdbiorcow, dane, i)
    with(
      odbiorca, 
      {
        render(
          input = plikSzablonu, 
          output_format = pdf_document(keep_tex = ramkiTablic),
          output_file = paste0(
            prefiksPlikow,
            names(grupyOdbiorcow)[i],
            '.pdf'
          ),
          output_dir = katalogWy
        )
      }
    )
    
    # przerabianie skladni tablic w pliku TeX-a i ponowna generacja PDF-a
    #TODO dodać dbanie o brak polskich znaków, spacji, itp. w nazwach plików - pdf
    if(ramkiTablic){
      setwd(katalogBazowy)
      plikTex = paste0(prefiksPlikow, names(grupyOdbiorcow)[i], '.tex')
      
      tex = readChar(plikTex, 10^6)
      tex = gsub("\\\\toprule\\\\addlinespace", "\\\\hline", tex)
      tex = gsub('\\\\toprule', '\\\\hline', tex)
      tex = gsub('\\\\midrule', '', tex)
      tex = gsub('\\\\bottomrule', '', tex)
      tex = gsub('\\\\tabularnewline', '\\\\tabularnewline\\\\hline', tex)
      tex = gsub("\\\\\\\\\\\\addlinespace", "\\\\\\\\\\\\hline", tex)
      tex = gsub('@[{][}]', '|', tex)
      wzor = '\\\\begin[{]longtable[}]\\[[a-z]\\][{][|][lcr][lcr]*[|][}]'
      while(grepl(wzor, tex)){
        pozycja = regexpr(wzor, tex)
        definicja = substr(tex, pozycja, pozycja + attr(pozycja, 'match.length') - 1)
        definicja = gsub('([lcr])([lcr])', '\\1|\\2|', definicja)
        definicja = sub('[|][|]', '|', paste0('\\', definicja))
        tex = sub(wzor, definicja, tex)
      }
      tex = gsub(paste0('\\\\includegraphics[{]', getwd(), '/'), '\\\\includegraphics{', tex)
      writeLines(tex, plikTex)
      
      komendaKompilacji = sprintf("pdflatex '%s'", plikTex)
      repeat{
        wyjscie = system(komendaKompilacji, intern = TRUE) 
        if(!any(suppressWarnings(grepl('Package rerunfilecheck Warning', wyjscie)))){
          break
        }
      }
      if(sprzataj){
        unlink(c(
          plikTex,
          sub('.tex', '.out', plikTex),
          sub('.tex', '.log', plikTex),
          sub('.tex', '.aux', plikTex),
          sub('.tex', '_files', plikTex)
        ), recursive = TRUE)
      }
      setwd(katalogRoboczy)
    }
  }
}
