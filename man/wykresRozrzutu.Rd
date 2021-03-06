% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/wykresRozrzutu.R
\name{wykresRozrzutu}
\alias{wykresRozrzutu}
\title{Wykres rozrzutu}
\usage{
wykresRozrzutu(
  x,
  y,
  etykiety = NULL,
  rozmiar = NULL,
  tytul = "",
  tytulX = NULL,
  tytulY = NULL,
  maxRozmPkt = 5,
  rozmiarMin = 10,
  rozmiarTekstu = NULL,
  opcjeWykresu = NULL,
  rysuj = TRUE
)
}
\arguments{
\item{x}{wektor pozycji na osi X}

\item{y}{wektor pozycji na osi Y}

\item{etykiety}{etykiety punktów na wykresie}

\item{rozmiar}{rozmiar poszczególnych punktów}

\item{tytul}{tytuł wykresu}

\item{tytulX}{tytuł osi X wykresu}

\item{tytulY}{tytuł osi Y wykresu}

\item{maxRozmPkt}{rozmiar punktu na wykresie odpowiadający największej
wartości parametru \code{rozmiar}#'}

\item{rozmiarMin}{minimalna wartość rozmiaru danego punktu, aby został
zaprezentowany na wykresie (brana pod uwagę tylko gdy podano parametr
\code{rozmiar})}

\item{rozmiarTekstu}{bazowy rozmiar tekstu na wykresie}

\item{opcjeWykresu}{dodatkowe opcje wykresu (zostaną dodane do obiektu wykresu ggplot2)}

\item{rysuj}{czy funkcja ma narysować wykres czy tylko zwrócić wygenerowany obiekt wykresu}
}
\value{
[gg] obiekt wykresu pakietu ggplot2
}
\description{
Rysuje wykres rozrzutu (X-Y).
}
