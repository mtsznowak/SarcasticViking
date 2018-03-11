# Sarkastyczny Wiking

## Motywacja i opis projektu

Co pół roku studenci na całym świecie stają do nierównej walki z prowadzącymi zajęcia podczas sesji. Aby pomóc im lepiej się przygotować i wygrać to starcie, nasz zespół zaimplementował aplikację wspomagającą naukę do konkretnego terminu egzaminu, w konkretnym terminie, odpowiednio organizującą pracę przez cały poprzedzający okres.

Działa ona na zasadzie połączenia dwóch najlepszych metod uczenia się (wg. <tu link>), tj. ciągłego testowania swoich umiejętności oraz regularnego powtarzania w odpowiednich momentach. Aplikacja służy do nauki za pomocą fiszek, które odpowiedni algorytm wybiera tak, aby zmaksymalizować zapamiętane informacje i zminimalizować spędzony czas na nauce.

Dodatkowym aspektem jest postać Sarkastycznego Wikinga Herolda pojawiająca się na ekranie z fiszkami. Jego zabawne, często mocno uszczypliwe teksty mają uprzyjemnić czas uzytkownikowi, wprowadzając ciekawy czynnik i sprawiając, że użytkownik jest bardziej zaangażowany w naukę.

Aplikacja została zaimplementowana w języku "Swift" na platformę iOS.

## Algorytm wyboru fiszek oraz interwałów nauki

Algorytm w głównej mierze oparty jest na algorytmie "Leitner system", który polega na przechodzeniu przed poszczególne fazy, aż do pełnego zapamiętania informacji.
![Laitner system](https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Leitner_system_alternative.svg/460px-Leitner_system_alternative.svg.png)

W celu wyznaczenia odpowiednich interwałów, wykorzystane zostało zachowania tzw. krzywej zapamiętywania:
![Krzywa zapamiętywania](http://www.growthengineering.co.uk/wp-content/uploads/2016/11/the-forgetting-curve.png)

Jak widać powyżej, zdobyte informacje zostają szybko zapomniane. Jednak po kilku fazach z odświerzeniem informacji, krzywa ta prezentuje się następująco:
![Krzywa zap. 2](https://drouinscblog.files.wordpress.com/2017/03/img-eppinghaus-retention-curves.gif?w=736)

Warto zaznaczyć, że prócz wyznaczenia optymalnych interwałów aplikacja dostosowuje się do pominięcia niektórych sesji przez uzytkownika. W tym przypadku interwały dla poszczególnych pytań są aktualizowane tak, aby ostateczna ilość sesji zapamiętywania zgadzała się.

W przypadku gdy uzytkownik ma słabe wyniki dla niektórych pytań, są one zadawane częściej niż pozostałe. Jest to realizowane przez zresetowanie postępu dla danego pytania oraz wyznaczenie nowego harmonogramu sesji dla tego jednego pytania. Aby uniknąć sytuacji, w której wiele pytań powinno być odświerzonych w innym czasie, są one odpowiednio grupowane w odpowiednie zestawy pytań.


## Potencjał biznesowy

Aplikacja zostanie umieszczona w AppStore jako aplikacja darmowa z reklamami. Pozwoli to na możliwie duże rozpromowanie projektu wśród użytkowników.
Możliwe jest dodanie w przyszłości płatych zestawów fiszek. Rozważany jest również model subskrybcji, w których użytkownik wykupowałby odpowiedni zestaw na dany okres czasu.

# Aplikacja i UI

Poniżej przedstawiony jest wersja aplikacji, która powstała podczas hackathonu:

## Ekran główny

Pokazuje zestawy fiszek, które są aktywne (tj. termin egzaminu został wprowadzony) oraz nieaktywne (możliwe do aktywacji.

[Fiszki](https://i.imgur.com/Kcwaa0S.png)

Po kliknięciu na nieaktywną fiszkę uzytkownikowi pokazywany jest ekran wyboru daty egzaminu:

[Data](https://i.imgur.com/AxmTjQD.png)

Po kliknięciu na aktywną fiszkę, prezentowany jest ekran nauki:

[Nauka](https://i.imgur.com/CaOm2GA.png)

Użytkownik ma możliwość pokazania odpowiedzi przez przesunięcie fiszki w dół. Następnie w stylu aplikacji Tinder - przesuwa całą fiszkę w lewo lub w prawo deklarując, że zna odpowiedż na pytanie lub nie
![Accepted](https://i.imgur.com/53YLWYT.png) ![Rejected](https://i.imgur.com/tS75aZ5.png)

Po niektórych odpowiedziach Wiking znajdujące się na dole ekranu sarkastycznie komentuje uzyskany wynik:
[Smieszny tekst](https://i.imgur.com/u9nc1Z3.png)

