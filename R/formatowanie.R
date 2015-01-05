###########################################################
#
# Plik z funkcjami wykonującymi proste agregaty
# i formatującymi wynik, które ułatwiają pisanie
# szablonów
#
###########################################################

#' @title wyznacza grupę ze względu na kwantyle
#' @description
#' Zwraca wektor wybierający obserwacje, które jednocześnie:
#' \itemize{
#'   \item należą do grupy wyznaczanej przez parametr filtr
#'   \item w ramach w. w. grupy należą do kwantyla q (spośród
#'     n kwantyli) ze względu na wartość zmiennej przekazanej
#'     w parametrze x
#' }
#' @param x wartości wg których nastąpi podział na grupy
#' @param q numer kwantyle
#' @param n liczba kwantyli
#' @param filtr globalny filtr obserwacji
#' @return [logical.vector]
#' @export
G = function(x, q, n, filtr = NULL){
  if(is.null(filtr)){
    filtr = rep(T, length(x))
  }
  stopifnot(
    is.numeric(x),
    is.numeric(q),
    is.numeric(n),
    is.logical(filtr),
    length(q) == 1,
    length(n) == 1,
    length(filtr) == length(x),
    n >= q,
    n >= 1
  )
  
  tmp = quantile(x[filtr], seq(0, 1, length.out = n + 1))
  if(q == 1){
    tmp[q] = tmp[q] - 1 # aby nie pomijać najmniejszej obserwacji
  }
  return(x <= tmp[q + 1] & x > tmp[q] & filtr)
}

#' @title wyrównanie długości
#' @description
#' Zwraca przekazany argument wyrównując go spacjami z lewej, tak by długość
#' zwróconej wartości odpowiadała długości wstawki R.
#' 
#' Przydatna do wstawianie wartości do multiline tables w wypadku, gdy wyniki
#' obliczono wcześniej w innej wstawce R.
#' @param x wartość
#' @return NULL
#' @export
W = function(x){
  dl = 4 + nchar(deparse(sys.call()))
  return(sprintf(paste0('% ', dl, 's'), x))
}

#' @title liczba rekordów niebędących brakami danych
#' @description
#' Zlicza liczbę rekordów niebędących brakami danych.
#' 
#' Jeśli podano wektor w, zliczane są tylko wartości zawarte w wektorze w.
#' @param x wektor wartości
#' @param w [opcjonalny] wektor zliczanych wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w 
#'   tabelach)
#' @return NULL
#' @export
N = function(x, w = NULL, wyrownaj = T){
  if(!is.null(w)){
    f = function(d){
      return(sum(d %in% w))
    }
    # obejście funkcji giodo() przy braku wartości w wektorze
    if(f(x) == 0){
      x = c(x, rep(NA, 50))
    }
    return(statWektor(x, f, sys.call(), wyrownaj, 0))
  }else{
    return(statWektor(x, length, sys.call(), wyrownaj, 0))
  }
}

#' @title średnia
#' @param x wektor wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
E = function(x, wyrownaj = T, dokl = 2){
  return(statWektor(x, mean, sys.call(), wyrownaj, dokl))
}

#' @title mediana
#' @param x wektor wartości
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
Me = function(x, wyrownaj = T, dokl = 2){
  return(statWektor(x, median, sys.call(), wyrownaj, dokl))
}

#' @title wskazany kwantyl
#' @description
#' Istnieje możliwość obliczenia wartości wielu kwantyli jednocześnie - 
#' wystarczy jako q przekazać wektor. W takim wypadku zwrócony zostanie wektor
#' odpowiednich kwantyli.
#' @param x wektor wartości
#' @param q numer kwantyla (może być wektorem)
#' @param n liczba kwantyli
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return NULL
#' @export
Q = function(x, q, n, wyrownaj = T, dokl = 2){
  stopifnot(
    is.numeric(x),
    is.numeric(q),
    is.numeric(n),
    length(n) == 1,
    all(n >= q),
    n >= 1
  )
  
  f = function(x){
    tmp = quantile(x, seq(0, 1, length.out = n + 1))
    return(tmp[q + 1])
  }
  return(statWektor(x, f, sys.call(), wyrownaj, dokl))
}

#' @title oblicza wskazaną statystykę dla wskazanego wektora danych
#' @description
#' \itemize{
#'   \item sprawdza czy x jest wektorem
#'   \item wywołuje na x funkcję giodo()
#'   \item wywołuje na x na.omit()
#'   \item jeśli wektor x jest pusty przyjmuje '-' jako wynik
#'   \item jeśli wektor x nie jest pusty, wywołuje na x funkcję f i 
#'     zaokrągla wynik zgodnie z parametrem dokl
#'   \item ew. wyrównuje długość wyniku do długości wywołania call
#' }
#' @param x wektor wartości lub ramka danych wartości
#' @param f funkcja do wykonania na x
#' @param call wywołanie, do którego długości wyrównywany jest wynik
#' @param wyrownaj czy wyrównywać długość wyniku (TRUE w wypadku osadzania w tabelach)
#' @param dokl liczba cyfr po przecinku, do których zaokrąglony zostanie wynik
#' @return zależnie od funkcji f
#' @export
statWektor = function(x, f, call, wyrownaj = T, dokl = 2){
  stopifnot(is.vector(x))
  x = giodo(x)
  x = na.exclude(x)
  if(length(x) == 0){
    wynik = '-'
  }else{
    wynik = f(x)
  }
  
  if(wyrownaj){
    dl = 4 + nchar(deparse(call))
    if(max(nchar(wynik)) > dl){
      warning('Wyrównanie długości nie było możliwe')
    }
    format = ifelse(
      is.character(wynik),
      paste0('% ', dl, 's'),
      paste0('% ', dl, '.', dokl, 'f')
    )
    return(sprintf(format, wynik)) 
  }
  return(wynik)
  
}
