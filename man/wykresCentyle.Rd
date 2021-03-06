% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wykresCentyle.R
\name{wykresCentyle}
\alias{wykresCentyle}
\title{Wykres - histogram ze wskazanych centyli}
\usage{
wykresCentyle(
  dane,
  centyle = NULL,
  tytul = "",
  tytulX = NULL,
  tytulY = NULL,
  rozmiarTekstu = NULL,
  opcjeWykresu = NULL,
  rysuj = TRUE,
  pomijajEtykiety = 500
)
}
\arguments{
\item{dane}{wektor wartości centyli}

\item{centyle}{wektor centyli (na skali 0-1); musi być tej samej długości co
parametr \code{dane} lub mieć wartość \code{NULL}; jeśli \code{NULL},
funkcja zakłada równomierne rozłożenie centyli przekazanych w parametrze
\code{dane} (\code{centyle = seq(0, 1, length.out = length(dane))})}

\item{tytul}{tytuł wykresu}

\item{tytulX}{tytuł osi X wykresu}

\item{tytulY}{tytuł osi Y wykresu}

\item{rozmiarTekstu}{bazowy rozmiar tekstu}

\item{opcjeWykresu}{dodatkowe opcje wykresu (zostaną dodane do obiektu
wykresu ggplot2)}

\item{rysuj}{czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany
obiekt wykresu}

\item{pomijajEtykiety}{wartość, na podstawie której funkcja decyduje, które
etykiety będą na siebie nachodzić i należy je pomijać; nie ma żadnej
intuicyjnej interpretacji, wiadomo jedynie, że im ona mniejsza, tym
szybciej etykiety będą pomijane; odpowiedią wartość należy dobrać
eksperymentalnie}
}
\value{
[gg] obiekt wykresu pakietu ggplot2
}
\description{
Rysuje histogram na podstawie już policzonego rozkładu.
}
