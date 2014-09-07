# PEJK
Pakiet do generowania raportów dla PEJK

## Instalacja

Praca z pakietem składa się zasadniczo z dwóch kroków:

1. Instalacji pakietu w R, co zapewnia doinstalowanie wszystkich potrzebnych 
   pakietów, itp.
   
2. Założenia nowego projektu RStudio na podstawie repozytorium _Git_, co 
   zapewnia dostęp do przykładowych szablonów raportów, jak również umożliwia 
   udostępnienie innym szablonów przygotowanych przez siebie.

### Instalacja pakietu

1. Jeśli nie masz jeszcze pakietu _devtools_, zainstaluj go:
```r
install.packages('devtools')
```

2. Zainstaluj pakiet _PEJK_ z użyciem _devtools_:
```r
devtools::install_github('zozlak/PEJK')
```

3. Jeśli jesteś użytkownikiem 64-bitowego linuksa, wtedy krok 2. może się nie
   powieść (z uwagi na błąd w pakiecie _devtools_). W takim wypadku musisz
   zainstalować pakiet _PEJK_ ręcznie z linii komend:
```
git clone https://github.com/zozlak/PEJK.git
R CMD INSTALL PEJK
rm -fR PEJK
```

### Założenie projektu RStudio na podstawie repozytorium _Git_

1. W *RStudio* wybrać menu *File->New Project...*.

2. Wybrać *Version Control*, a następnie _Git_.

3. Wpisać `https://github.com/zozlak/PEJK.git` w pole *Repository URL* oraz 
   wskazać katalog, do którego zostaną ściągnięte źródła pakietu (pole
   *Create project as subdirectory of*), po czym kliknąć przycisk *Create
   Project*
4. Poczekać, aż wszystko się ściągnie.

5. Przejść do lektury następnego rozdziału.

## Tworzenie i edycja raportów

**Szablony raportów znajdują się w katalogu *raporty* **.  

Na chwilę obecną przygotowany został szablon raportu _R2-uczelnia*. Na jego
przykładzie opisany zostanie sposób samodzielnego tworzenia raportów.

### Użyta technologia i jej dokumentacja

Raporty generowane są za pomocą pakietu *rmarkdown*. Ten z kolei pod spodem
korzysta z pakietów *knitr* (raporty w formacie PDF) oraz *shiny* (raporty 
interaktywne).

**Dokładną dokumentację składni _Markdown_ można znaleźć na stronach:**

- http://rmarkdown.rstudio.com/authoring_basics.html
- http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html

**Tworzenie raportów interaktywnych opisane zostało na stronie:**

- http://rmarkdown.rstudio.com/authoring_shiny.html

### Tworzenie raportu

Katalog z szablonem raportu (np. _raporty/R2-uczelnia/_) zawiera następujące
pliki i katalogi:

- Plik z właściwym szablonem raportu w formacie *.Rmd_ (tu _R2-uczelnia.Rmd_).
  Opisuje on zawartość raportu. Odnosząc go do _raportera_ jest on kombinacją
  _technicznego szablonu RTF_ oraz pliku _.ord_ definiującego poszczególne
  podgrupy populacji oraz obliczane dla nich statystyki.

- [opcjonalnie] Skrypt R generujący raporty dla poszczególnych grup odbiorców
  (tu _R2-uczelnia.R*). Jest to prosty skrypt, który ma na celu jedynie:
  - wczytanie zbioru danych;
  - zdefiniowanie listy odbiorców
  - uruchomienie funkcji _generujRaporty()_
  
- [opcjonalnie] Szablon _Markdown_ raportu interaktywnego (tu 
  _R2-uczelnia-shiny.Rmd_). Zawiera on definicje kontrolek umożliwiających
  użytkownikowi wybór parametrów raportu oraz skrypt R, który na podstawie
  pobranych od użytkownika parametrów oraz pliku z właściwym szablonem raportu
  (patrz punkt 1.) generuje i wyświetla odpowiedni raport.

- Katalog _raporty_, w którym generowane są wersje PDF raportów.

- Zbiór danych w formacie czytelnym dla R (CSV, SPSS, Stata, DBF ale już nie 
  MFM).
  - **Z uwagi na poufność danych zbiorów danych nigdy nie należy
    ich dodawać do repozytorium _Git_ **.
  - Zbiór danych do raportu _R2-uczelnia* to przekonwertowany za pomocą
    _konwertera_ zbiór _R2-uczelnia/dane_USOS.mfm* w formie takiej, w jakiej
    otrzymałem go od Mikołaja Jasińskiego.

- Wszelkie pozostałe pliki i katalogi (także podkatalogi katalogu _raporty_)
  są plikami tymczasowymi powstającymi podczas generowania raportów. Można
  je bez żadnej szkody usuwać i nie należy ich dodawać do repozytorium _Git_.
  
### Plik Markdown z właściwym szablonem raportu (plik .Rmd)

Jest to zwykły plik w _nowym formacie Markdown_, co oznacza obsługiwanie go
z użyciem pakietu _rmarkdown_. Bardzo dobre wsparcie dla edycji dokumentów
w tym formacie zapewnia _Rstudio_ od wersji 0.98.945 (zresztą pakiet 
_rmarkdown_ napisali właśnie programiści _RStudio_).

Zaczyna się on krótkim nagłówkiem opisującym metadane szablonu, w szczególności
tytuł, format docelowy, datę utworzenia:
```
---
title: "ETAP STUDIÓW"
output: html_document
date: "05.09.2014"
---
```
Opcje te można wygodnie edytować w okienku ustawień wywoływanym kliknięciem na
szare kółko zębate po prawej stronie belki znajdującej się nad treścią 
edytowanego szablonu.

Warto zwrócić uwagę, że obok przysiku zębatki znajduje się przycisk 
umożliwiający wygenerowanie przykładowego raportu. Do tego, jeśli klikniemy na
małą strzałeczkę obok niego, możemy wybrać alternatywne formaty (DOCX lub 
HTML).

W dalszej części plik zawiera zwykły kod _Markdown_ zgodnie z opisem na 
stronach:
- http://rmarkdown.rstudio.com/authoring_basics.html
- http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html

Aby sam kod _Markdown_ pozostał przejrzysty i łatwo można było na jego 
podstawie wyobrazić sobie układ końcowego dokumentu definiowanie podgrup, 
wyliczanie bardziej złożonych statystyk, itp. najlepiej umieścić w oddzielnym
bloku na początku szablonu. W pliku _R2-uczelnia.Rmd_ służy do tego drugi
blok kodu R:
```r
devtools::load_all('../../') # załaduj pakiet PEJK (funkcje formatujące)
# definicje grup
grupa1 = grupaGl
grupa13 = grupaGl & dane$ERASMUS %in% 100
grupa14 = grupaGl & dane$ERASMUS %in% 0
grupa32 = grupaGl & dane$NPELUSOS %in% 0
grupa33 = grupaGl & dane$NPELUSOS %in% 100
grupa37 = grupaGl & dane$STYPEND %in% 100
grupa38 = grupaGl & dane$STYPEND %in% 0
```
Odpowiada on za to samo, co definicje _VAR13, VAR14, itp._ wyklikiwane w
_raportrzerze_. Definicje powyższe umożliwiają przejrzyste w zapisie
obliczanie statystyk w dalszej części dokumentu z użyciem krótkich wstawek R,
np.:
```
`r N(dane$ENKA[grupa13])`
```
Dodatkowo (w pierwszej linii) ładuje on pakiet PEJK, aby możliwe było 
korzystanie z _funkcji formatujących_ (patrz dalej).

Oddzielnego omówienia wymaga pierwszy blok kodu R:
```r
# przykładowe dane, jeśli nie generujemy wsadowo
if(all(!grepl('dane', ls()))){ # nie ma zmiennej "dane"
  dane = read.csv2('dane.csv', stringsAsFactors = F)
  devtools::load_all('../../')

  # definicja odbiorców i stałych
  grupaGl = dane$STOPIEN %in% 1 & dane$ROKSTART %in% 2007
  stStopienN = 1
  stStopienS = '1 stopnia'
  stRok = 2007
}
```
Służy on pobraniu przykładowych danych i zdefiniowaniu przykładowej grupy
odbiorców na czas tworzenia szablonu raportu. Docelowo, przy generowaniu
raportów w ich ostatecznym kształcie, odpowiadać będzie za to skrypt 
_R2-uczelnia.R*, ale w momencie, gdy szablon dopiero powstaje i chcemy mieć
możliwość szybkiego podejrzenia podglądu, wygodnie jest zdefiniować przykładową
grupę odbiorców w samym pliku szablonu. Aby nie przeszkadzała ona przy wsadowym
generowaniu raportów skryptem _R2-uczelnia.R_ kod ten wykonywany jest 
warunkowo, jedynie w wypadku, gdy jeszcze nie wczytano danych (za co 
odpowiedzialny jest skrypt _R2-uczelnia.R_).

Reszta pliku to już najzwyklejszy kod _Markdown_.

#### Pomocnicze funkcje formatujące

Aby:

- uczynić kod _Markdown_ bardziej przejrzystym;

- ustandaryzować formatowania stosowane w raportach;

- wspomóc w radzeniu sobie z durnymi problemami (patrz rozdział o tabelach)

pakiet _PEJK_ zawiera _funkcje formatujące_. Są to proste funkcje 
odpowiedzialne za obliczanie najczęściej wykrorzystywanych statystyk.

W chwili obecnej dostępne są dwie:

- `N()` - zwraca liczbę obserwacji danej zmiennej, które nie są brakami danych;

- `E()` - zwraca średnią wartości danej zmiennej (z pominięciem braków danych).

Jeśli będzie taka potrzeba, dopisywane zostaną następne.

Pozwalają one na skrótowy i bardziej przejrzysty zapis wstawek R w pliku szablonu, np.:
```
`r N(dane$ENKA[grupa32])`
```
zamiast
```
`r length(na.omit(dane$ENKA[grupa32]))`
```

#### Tabele

Tablice definiować można na kilka sposobów (patrz 
http://rmarkdown.rstudio.com/authoring_pandoc_markdown.html#tables). Tutaj 
skupimy się na dwóch.

W wypadku, gdy zawartość tabeli nie wymaga łamania wierszy, najwygodniej
deifniować je jako _pipe tables_, gdzie separatorem kolumny jest znak `|`. Ma 
to tą zaletę, że kod _Markdown_ opisujący poszczególne komórki tabeli nie musi
zachowywać szerokości kolumn, tzn. poprawną definicją tabeli będzie np.:
```
nagł kol. 1 | nagł. kol. 2
-|-
12|15
```

**Jest to duża zaleta, ponieważ w wypadku osadzania kodu R przetworzony kod
_Markdown_ będzie miał zapewne inną strukturę niż ten, który widzimy w pliku
szablonu**. Weźmy jako przykład tabelkę:
```
Osoby, które                                          |       Uzyskały stypendium|   Nie uzyskały stypendium
------------------------------------------------------|-------------------------:|-------------------------:
uzyskały co najmniej raz stypendium za wyniki w nauce | `r N(dane$ENKA[grupa37])`| `r N(dane$ENKA[grupa38])`
```
Po wykonaniu osadzonego kodu R przyjmie ona postać (wartości oczywiście zmyślam):
```
Osoby, które                                          |       Uzyskały stypendium|   Nie uzyskały stypendium
------------------------------------------------------|-------------------------:|-------------------------:
uzyskały co najmniej raz stypendium za wyniki w nauce | 234| 697
```
a więc poszczególne kolumny _przestaną na siebie trafiać_. Tylko _pipe tables_ 
radzą sobie gładko w takim wypadku.

_Pipe tables_ mają jednak tą istotną wadę, że w wypadku eksportu do PDF (i 
tylko wtedy [sic!]) nie łamią zawartości komórek tabeli, gdy ta jest zbyt 
szeroka, by zmieścić się na stronie. Stąd w wypadku, *gdy mamy do czynienia z
tabelą zawierającą długie teksty, konieczne jest stosowanie _multiline tables_ 
**.

Głównym problemem z _multiline tables_ jest konieczność idealnego *trafiania na
siebie* kolumn w kolejnych wierszach. Aby sobie z tym poradzić *funkcje 
formatujące* (patrz poprzedni rozdział) przyjmują opcjonalnie drugi argument
oznaczający długość, jaką powinna mieć zwracana przez funkcję wartość 
(do dopełnienia do tej długości używana jest spacja). Jego wartość powinna być
równa całkowitej liczbie znaków zajmowanych przez wstawkę R, łącznie z 
otwierającym _`r_ oraz kończącym _`_. Jako przykład weźmy ostatnią tabelę z 
szablonu _R2-uczelnia.Rmd_:
```
------------------------------------------------------------------------------------------------------------------------
Wartości wskaźników                                                 Osoby pełnosprawne             Osoby niepełnosprawne
---------------------------------------------------- --------------------------------- ---------------------------------
Procent studentów, którzy terminowo uzyskali dyplom   `r E(dane$DTERM1[grupa33], 31)`%  `r E(dane$DTERM1[grupa33], 31)`%
(licząc od rozpoczęcia studiów)        
```
Jak widać wartości zwracane przez wstawki wypełniane są do długości 31 znaków, 
bo taka jest właśnie długość tych wstawek.

#### Wykresy

Wykresy generujemy dokładnie w ten sam sposób, jak robilibyśmy to w zwykłym
kodzie R (oczywiście osadzając ten kod w pliku szablonu jako wstawkę kodu R).

Aby osiągnąć porządany rozmiar wykresu w docelowym dokumencie dostosowujemy
odpowiednio parametry _fig.height_ oraz _fig.width_ wstawki kodu R, np. 
w _R2-uczelnia.Rmd_:
```r
```{r echo = FALSE, fig.height = 3.5}
(...kod generujący wykres...)
```

### Skrypt R opisujący grupy odbiorców i generujący raporty

Jest to plik z kodem R odpowiedzialnym za:

- załadowanie pakietu _PEJK_;

- wczytanie danych;

- zdefiniowanie grup odbiorców;

- wykonanie funkcji _generujRaporty()_.

W pierwszej linii powinien zawsze wywoływać funkcję `devtools::load_all()`,
która załaduje pakiet _PEJK_ (w tym funkcję _generujRaporty()_).
```r
devtools::load_all()
```

Dalej niezbędne jest załadowanie danych. W przykładzie używany jest plik
_dane.csv_ będący skonwertowanym z użyciem _konwertera_ zbiorem 
_R2-uczelnia/dane_USOS.mfm*, który otrzymałem od Mikołaja Jasińskiego:
```r
dane = read.csv2('raporty/R2-uczelnia/dane.csv', stringsAsFactors = F)
```
W ogólności może to być dowolny zbiór danych czytany przez R.

W kolejnych trzech liniach definiowane są katalog zapisu wygenerowanych 
raportów (względem położenia pliku szablonu), położenie pliku szablonu 
Markdown raportu (względem katalogu projektu) oraz prefiks dodawany do nazwy
każdego generowanego pliku raportu. Wartości te można by oczywiście przekazać 
wprost do funkcji _generujRaporty()_ bez przekazywania ich przez zmienne, ale 
użycie zmiennych porządkuje strukturę skryptu.

Następnie widzimy definicję grup odbiorców, a więc odpowiednik pliku _.dbf_
w _raporterze_:
```r
grupy = list(
  '1_etap' = list(
    'grupaGl' = dane$STOPIEN %in% 1 & dane$ROKSTART %in% 2007,
    'stStopienN' = 1,
    'stStopienS' = '1 stopnia',
    'stRok' = 2007
  ),
  '2_etap' = list(
    'grupaGl' = dane$STOPIEN %in% 2 & dane$ROKSTART %in% 2010,
    'stStopienN' = 2,
    'stStopienS' = '2 stopnia',
    'stRok' = 2010
  )
)
```
Na podstawie nazwy każdej z grup wygenerowana zostanie nazwa pliku, w którym
zapisany zostanie raport. 

Z kolei wszystkie zmienne zdefiniowane dla danego elementu listy dostępne będą
ze zdefiniowanymi wartościami podczas przetwarzania szablonu _Markdown_ raportu
dla danej grupy odbiorców. Tak więc np. dla grupy odbiorców *1_etap* zmienna
_stRok_ będzie mieć wartość _2007_, a dla grupy *2_etap* _2010_. Stąd też 
użycie w szablonie Markdown wstawki R
```
Raport dotyczy studentów, którzy zostali przyjęci na studia w `r stRok` roku.
```
Spowoduje dostosowanie jego treści dla poszczególnych grup.

Przyjęta w raporcie _R2-uczelnia* konwencja nazywania zmiennych o wartościach
stałych dla danej grupy odbiorców z prefiksem _st_ jest tylko konwencją, 
niemniej warto się tu, dla porządku i łatwości czytania szablonów Markdown 
raportów, jakiejś konwencji trzymać.

Bardzo ważna z punktu widzenia szablonu Markdown raportu _R2-uczelnia* zmienną 
opisującą każdą grupę odbiorców jest zmienna _grupaGl_, służy ona bowiem za
_bazę_ dla określania wszystkich podgrup, dla których wykonywane są w raporcie
analizy (patrz druga wstawka R w pliku _R2-uczelnia.Rmd_). Również tutaj jej 
nazwa jest tylko przyjętą konwencją i tak naprawdę zależy od sposobu 
zdefiniowania podgrup w pliku szablonu Markdown raportu, ale również tutaj
warto jakąś konwencję przyjąć i się jej trzymać.

Ostatnia linijka to po prostu wywołanie funkcji _generujRaporty()_ ze 
zdefiniowanymi parametrami.

Struktura tego skryptu będzie na dobrą sprawę niezależnie od raportu taka sama.
Zmieniać powinny się jedynie definicje grup odbiorców, ścieżka do pliku 
szablonu _Markdown_ oraz prefiks nazw wygnerowanych plików raportów.

### Raporty interaktywne

Korzystanie z pakietu _rmarkdown_ daje możliwość łatwego stworzenia raportów
interaktywnych. Oczywiście wtedy już nie w formacie PDF, ale w postaci stron 
WWW (choć niewymagających do działania serwera).

Najprostszym przykładem takiej interaktywności może być danie użytkownikowi
możliwości samodzielnego wyboru grupy odbiorców. Przykład taki znajduje się
w pliku _R2-uczelnia-shiny.Rmd_. Po otwarciu pliku i naciśnięciu przycisku
_Run document_ (tam, gdzie w zwykłym pliku szablonu Markdown znajdował się
przycisk tworzący PDF z raportem) otwarta zostanie strona WWW, na której
istniej możliwość wyboru etapu studiów oraz roku rozpoczęcia nauki. Po każdej
zmianie raport odświeża się prezentując wyniki dla danej wybranej grupy.

Plik definiujący taki raport (tu _R2-uczelnia-shiny.Rmd_) składa się z czterech
części:

1. Opcji pliku _Markdown_:
```
---
title: "ETAP STUDIÓW"
output: html_document
date: "06.09.2014"
runtime: shiny
---
```
   Są one analogiczne, jak dla _zwykłego_ szablonu _Markdown_ (porównaj z plikiem
   _R2-uczelnia.Rmd_), jednak zawierają linijkę `runtine: shiny`, a jako format
   wyjściowy wybrany musi być html (`output: html_document`).

2. Sekcji wczytującej dane i ładującej pakiet _PEJK_:
```
devtools::load_all('../..')

dane = read.csv2('dane.csv', stringsAsFactors = F)
lataStart = na.omit(unique(dane$ROKSTART))
lataStart = lataStart[order(lataStart)]
```

3. Sekcji opisującej kontrolki, za pomocą których użytkownik określa parametry
   raportu:
```r
inputPanel(
  selectInput(
    'etap', 
    label = 'Etap studiów',
    choices = 1:2,
    selected = 1
  ),
  selectInput(
    'rok', 
    label = 'Rok rozpoczęcia etapu studiów',
    choices = lataStart,
    selected = lataStart[1]
  )
)

```
   W tym wypadku są to dwie listy rozwijalne o nazwach, odpowiednio, _etap_ 
   oraz _rok_. Wprowadzenie do dostępnych kontrolek znaleźć można pod adresem
   http://shiny.rstudio.com/tutorial/lesson3/.

4. Sekcji generującej sparametryzowany raport:
```r
renderUI({
   dane = dane # głupie, ale potrzebne - osadza zmienną w lokalnym kontekście, żeby szablon mógł ją znaleźć
   grupaGl = dane$STOPIEN %in% input$etap & dane$ROKSTART %in% input$rok
   stStopienN = input$etap
   stStopienS = ifelse(input$etap == 1, '1 stopnia', '2 stopnia')
   stRok = input$rok
   
   rmarkdown::render(
       input = 'R2-uczelnia.Rmd', 
       output_format = html_document(),
       output_file = 'tmp.html'
   )
   raport = 
   return(HTML(readLines('tmp.html')))
})
```
   Sekcja ta musi:
   - przypisać wartości zmiennym używanym w szablonie _Markdown_ raportu 
     stosownie do wybranych przez użytkownika parametrów; parametry wybrane
     przez użytkownika dostępne są jako elementy listy _input_ (porównaj
     powyższy kod z nazwami kontrolek w poprzednim punkcie)
   - wygenerować kod HTML z zawartością raportu na podstawie szablonu 
     _Markdown_ (służy do tego funkcja _rmarkdown::render()_); ponieważ
     funkcja _rmarkdown::render()_ zawsze zapisuje wygenerowany raport
     do pliku, trzeba podać jakąś nazwę;
   - odczytać zapisany raport z pliku, po czym usunąć plik;
   - zwrócić treść raportu przetworzoną funkcją _HTML()_.

Chcąc samemu przygotować raport interaktywny należałoby względem pliku 
_R2-uczelnia-shiny.Rmd_ dostosować:

- sekcję wczytującą dane;

- sekcję definiującą kontrolki wyboru parametrów raportu;

- sekcję generującą sparametryzowany raport, ale jedynie w zakresie przypisania
  wartości zmiennych używanych w szablonie _Markdown_ raportu oraz ścieżki
  do pliku tego szablonu.