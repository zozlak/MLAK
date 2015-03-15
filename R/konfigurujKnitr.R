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
      }else{
        pdf.options(encoding = 'CP1250')
      }
    }
  }
}