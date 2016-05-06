# funkcja ustawiająca opcje konfiguracyjne knitr-a,
# tak by bardziej odpowiadały naszym potrzebom
#' @import knitr
konfigurujKnitr = function(){
  opts_chunk$set(
    'error' = FALSE, 'warnings' = FALSE, 'message' = FALSE,
    'echo' = FALSE, 'results' = 'asis'
  )
  
  if(!is.null(opts_knit$get('rmarkdown.pandoc.to'))){
    if(opts_knit$get('rmarkdown.pandoc.to') == 'latex'){
      cairo = capabilities()['cairo']
      if(cairo %in% TRUE){
        opts_chunk$set('dev' = 'cairo_pdf')
      }
      # Bez tego na Mac-u koniec koncow produkuja sie poprawne wykresy,
      # ale najpierw nastepuje litania bledow (tak jakby mimo wskazania
      # cairo_pdf() probowal najpierw wyprodukowac wykres za pomoca pdf(),
      # a dopiero po bledzie przechodzil do cairo_pdf())
      grDevices::pdf.options(encoding = 'CP1250')
    }
  }
}
