# ......................................................................................
# ...............Cvičení 3 - Vybraná rozdělení diskrétní náhodné veličiny...............
# ..................Martina Litschmannová, Adéla Vrtková, Michal Béreš..................
# ......................................................................................

# Nezobrazuje-li se vám text korektně, nastavte File \ Reopen with Encoding... na UTF-8
# Pro zobrazení obsahu skriptu použijte CTRL+SHIFT+O
# Pro spouštění příkazů v jednotlivých řádcích použijte CTRL+ENTER

#  Přehled rozdělení a jejich funkcí ####
# * Úvod: Pravděpodobnostní, Kumulativní pravděpodobnostní (Distribuční) a Kvantilová ####
# funkce
# ** Pravděpodobnostní funkce ####
# - začíná písmenkem **d**: $p = P(X = x)$: p = d...(x, ...)
#
# ** Kumulativní pravděpodobnostní (Distribuční funkce) ####
# - začíná písmenkem **p**: $p = P(X \leq x)$: p = p...(x, ...)
# - pozor Kumulativní pravděpodobnostní je s alternativní definicí $P(X \leq t)$
# - pro naši distribuční funkci $F(t) = P(X<t)$: F(t) = p...(t - 1, ...)
#
# ** Kvantilová funkce ####
# - začíná písmenkem **q**:  $p \geq P(X \leq x)$: x = q...(p, ...)
# - hledá nejmenší $x$ pro které je $P(X \leq x)$ větší než $p$


# * Binomické (Alternativní): $X \sim Bi(n, π),X \sim A(π) = Bi(1, π)$ ####
# - počet úspěchů v $n$ Bernoulliho pokusech (případně pro jeden pokus v případě
# Alternativní)
# - každý pokus má šanci na úspěch $π$


# Pravděpodobnostní funkce P(X = x)
x <- 10 # hodnota, pro níž hledáme p-stní funkci
n <- 21 # rozsah výběru
p <- 0.5 # pravděpodobnost úspěchu
dbinom(x, n, p)


dbinom(3.2, n, p)


options(warn = -1) # tímto se dají vypnout warningy


dbinom(3.2, n, p)


options(warn = 0) # tímto zase zapnout


# vykreslíme si pravděpodobnostní funkci
x <- 0:21 # minimálně 0, maximálně n má kladnou pravděpodobnost
P_x <- dbinom(x, n, p)
plot(x, P_x)
grid()


# Kumulativní pravděpodobnostní funkce P(X <= x)
x <- 10 # hodnota, pro níž hledáme kumulativní p-stní funkci
n <- 21 # rozsah výběru
p <- 0.5 # pravděpodobnost úspěchu
pbinom(x, n, p)


# Distribuční funkce F(x) = P(X < x)
x <- 10 # hodnota, pro níž hledáme kumulativní p-stní funkci
n <- 21 # rozsah výběru
p <- 0.5 # pravděpodobnost úspěchu
pbinom(x, n, p) - dbinom(x, n, p)
# nebo
pbinom(x - 1, n, p)


# vykreslíme si distribuční funkci
x <- 0:21 # minimálně 0, maximálně n má kladnou pravděpodobnost
P_x <- dbinom(x, n, p)
F_x <- cumsum(P_x)
plot(x, F_x, type = "s")
grid()


# nebo
x <- seq(0, 21, 0.01) # minimálně 0, maximálně n
options(warn = -1)
F_x <- pbinom(x, n, p) - dbinom(x, n, p)
plot(x, F_x, cex = 0.3)
grid()
options(warn = 0)


# zkontrolujeme korektnost na hodnotě 10
x <- seq(9.9, 10.1, 0.01) # minimálně 0, maximálně n
options(warn = -1)
F_x <- pbinom(x, n, p) - dbinom(x, n, p)
options(warn = 0)
plot(x, F_x, cex = 0.5)
grid()


# najdi x pro dané q: q = P(X <= x)
q <- 0.7 # h
n <- 21 # rozsah výběru
p <- 0.5 # pravděpodobnost úspěchu
qbinom(q, n, p)
pbinom(11, n, p)
pbinom(12, n, p)
pbinom(13, n, p)


# Kvantilová funkce (inverzi dist. fce): q = F(x) = P(X < x)
q <- 0.7 # pravděpodobnost pro kterou hledáme kvantil
n <- 21 # rozsah výběru
p <- 0.5 # pravděpodobnost úspěchu
qbinom(q, n, p) + 1
pbinom(12 - 1, n, p)
pbinom(13 - 1, n, p)
pbinom(14 - 1, n, p)


# * Hypergeometrické: $X \sim H(N, M, n)$ ####
# - počet úspěchů v $n$ závislých pokusech
# - závislost typu:
#  - $N$ objektů,
#  - z toho $M$ objektů se zadanou vlastností,
#  - výběr velikosti $n$
#  - **při výběru nevracíme zpět - pravděpodobnost výběru objektu s danou vlastností se
# mění s každým dalším vybraným objektem**
# - **R funkce bere jako parametry *hyper(k, M, N - M, n)**
#  - k je počet úspěchů pro které počítáme pravděpodobnost,
#  - M je počet objektů se zadanou vlastností,
#  - N-M je počet objektů bez zadané vlastnosti,
#  - n je ceklová velikost výběru.


# Pravděpodobnostní funkce P(X = x)
x <- 5 # hodnota, pro níž hledáme p-stní funkci
N <- 20 # celkový počet objektů
M <- 5 # z toho se zadanou vlastností
n <- 10 # velikost výběru
dhyper(x, M, N - M, n)


# vykreslíme si pravděpodobnostní funkci
x <- 0:5 # minimálně 0, maximálně n nebo M má kladnou pravd.
P_x <- dhyper(x, M, N - M, n)
plot(x, P_x)
grid()


# Distribuční funkce F(x) = P(X < x)
x <- 5 # hodnota, pro níž hledáme dist. funkci
N <- 20 # celkový počet objektů
M <- 5 # z toho se zadanou vlastností
n <- 10 # velikost výběru
phyper(x - 1, M, N - M, n)


# vykreslíme si Distribuční funkci
x <- 0:5 # minimálně 0, maximálně n nebo M má kladnou pravd.
P_x <- dhyper(x, M, N - M, n)
F_x <- cumsum(P_x)
plot(x, F_x, type = "s")
grid()


# Kvantilová funkce (inverzi dist. fce): q = P(X < x)
q <- 0.7 # pravděpodobnost pro kterou hledáme kvantil
N <- 20 # celkový počet objektů
M <- 5 # z toho se zadanou vlastností
n <- 10 # velikost výběru
qhyper(q, M, N - M, n) + 1
phyper(3 - 1, M, N - M, n)
phyper(4 - 1, M, N - M, n)
phyper(5 - 1, M, N - M, n)


# * Negativně binomické (Geometrické): $X \sim NB(k, π), X \sim Ge(π) = NB(1, π)$ ####
# - počet pokusů do $k$. úspěchu (včetně)
# - každý pokus má šanci na úspěch $π$
# - **Negativně binomická NV je v Rku definována jako počet neúspěchů před k-tým
# úspěchem**
#  - proto jako první parametr budeme posílat x - k


# Pravděpodobnostní funkce P(X = x)
x <- 15 # počet pokusů pro který hledáme pravd. fci
k <- 5 # požadovaný počet úspěchů
p <- 0.3 # pravd. jednotlivých pokusů
# pozor první argument musí být počet neúspěchů
dnbinom(x - k, k, p)


# vykreslíme si pravděpodobnostní funkci
x <- 0:40 # minimálně k, maximum neomezeno
P_x <- dnbinom(x - k, k, p)
plot(x, P_x)
grid()
# hodnoty 0,1,2,3,4 mají P(x)=0


# Distribuční funkce F(x) = P(X < x)
x <- 15 # počet pokusů pro který hledáme pravd. fci
k <- 5 # požadovaný počet úspěchů
p <- 0.3 # pravd. jednotlivých pokusů
# pozor první argument musí být počet neúspěchů
pnbinom(x - k - 1, k, p)


# vykreslíme si Distribuční funkci
x <- 0:40 # minimálně 0, maximálně n nebo M má kladnou pravd.
P_x <- dnbinom(x - k, k, p)
F_x <- cumsum(P_x)
plot(x, F_x, type = "s")
grid()


# Kvantilová funkce (inverzi dist. fce): q = P(X < x)
q <- 0.7 # pravd. pro kvantil
k <- 5 # požadovaný počet úspěchů
p <- 0.3 # pravd. jednotlivých pokusů
qnbinom(q, k, p) + k + 1
pnbinom(19 - k - 1, k, p)
pnbinom(20 - k - 1, k, p)
pnbinom(21 - k - 1, k, p)


# * Poissonovo: $X \sim Po(λt)$ ####
# - počet událostí v Poissonově procesu v uzavřené oblasti (v čase, na ploše, v objemu)
# - s hustotou výskytu $λ$
# - v čase/ploše/objemu velikosti $t$


# Pravděpodobnostní funkce P(X = x)
x <- 9 # počet pokusů pro který hledáme pravd. fci
lambda <- 5 # hustota výskytu
t <- 2 # pravd. jednotlivých pokusů
lt <- lambda * t
dpois(x, lt)


# vykreslíme si pravděpodobnostní funkci
x <- 0:25 # minimálně 0, maximum neomezeno
P_x <- dpois(x, lt)
plot(x, P_x)
grid()


# Distribuční funkce F(x) = P(X < x)
x <- 9 # počet pokusů pro který hledáme pravd. fci
lambda <- 5 # hustota výskytu
t <- 2 # pravd. jednotlivých pokusů
lt <- lambda * t
ppois(x - 1, lt)


# vykreslíme si Distribuční funkci
x <- 0:25 # minimálně 0, maximálně n nebo M má kladnou pravd.
P_x <- dpois(x, lt)
F_x <- cumsum(P_x)
plot(x, F_x, type = "s")
grid()


# Kvantilová funkce (inverzi dist. fce): q = P(X < x)
q <- 0.4 # pravd. pro kvantil
lambda <- 5 # hustota výskytu
t <- 2 # pravd. jednotlivých pokusů
lt <- lambda * t
qpois(q, lt) + 1
ppois(9 - 1, lt)
ppois(10 - 1, lt)
ppois(11 - 1, lt)


#  Příklady ####
# * Příklad 1. ####
# Bridž se hraje s 52 bridžovými kartami, které se rozdají mezi 4 hráče. Vždy 2 hráči
# hrají spolu. Při rozdávání (13 karet) jste dostali do rukou 2 esa. Jaká je
# pravděpodobnost, že váš partner bude mít zbývající dvě esa?


# X ... počet es mezi 13 kartami
# X ~ H(N = 39, M = 2, n = 13)
# P(X = 2)
M <- 2
N <- 39 # 52-13
n <- 13
# výpočet
dhyper(2, M, N - M, n) # což je dhyper(2,2,37,13)


# graf pravděpodobnostní funkce
x <- 0:M # všechny možné realizace NV X
p <- dhyper(x, M, N - M, n) # hodnoty pravděpodobnostní funkce pro x
plot(x, p)


# * Příklad 2. ####
# Pokusy se zjistilo, že radioaktivní látka vyzařuje během 7,5 s průměrně 3,87
# α-částice. Určete pravděpodobnost toho, že za 1 sekundu vyzáří tato látka alespoň
# jednu α-částici.


# X ... počet vyzářených alfa částic během 1 s
# X ~ Po(lt = 3.87/7.5)

lambda <- 3.87 / 7.5 # četnost výskytu
t <- 1 # za 1 sekundu
lt <- lambda * t # parametr Poissonova rozdělení

# P(X >= 1) = P(X > 0) = 1 - P(X <= 0)
1 - ppois(1 - 1, lt)


# graf pravděpodobnostní funkce
# teoreticky může být vyzářeno až nekonečně mnoho částic,
# od jisté hodnoty je pravděpodobnost zanedbatelná
x <- 0:10
p <- dpois(x, lt) # hodnoty pravděpodobnostní funkce pro x
plot(x, p)


# * Příklad 3. ####
# Kamarád vás pošle do sklepa, abyste donesl(a) 4 lahvová piva - z toho dvě desítky a
# dvě dvanáctky. Nevíte, kde rozsvítit, proto vezmete z basy poslepu 4 láhve. S jakou
# pravděpodobností jste vyhověl(a), víte-li, že v base bylo celkem 10 desítek a 6
# dvanáctek?


# X ... počet 10°piv mezi 4 vybranými
# X ~ H(N = 16, M = 10, n = 4)

x <- 2
N <- 16
M <- 10
n <- 4

# P(X = 2)
dhyper(x, M, N - M, n)


# graf pravděpodobnostní funkce
x <- 0:4 # všechny možné realizace NV X
p <- dhyper(x, M, N - M, n) # hodnoty pravděpodobnostní funkce pro x
plot(x, p)


# * Příklad 4. ####
# V jednom mililitru určitého dokonale rozmíchaného roztoku se v průměru nachází 15
# určitých mikroorganismů. Určete pravděpodobnost, že při náhodném výběru vzorku o
# objemu 1/2 mililitru bude ve zkumavce méně než 5 těchto mikroorganismu.


# X ... počet mikroorganismů v 0.5 ml roztoku
# X ~ Po(lt = 15/2)

lambda <- 15
t <- 1 / 2
lt <- lambda * t # parametr Poissonova rozd.

# P(X < 5) = P(X <= 4)
ppois(5 - 1, lt)
# nebo
ppois(5, lt) - dpois(5, lt)


# graf pravděpodobnostní funkce
# teoreticky může být v roztoku až nekonečně mnoho mikroorganismů,
# od jisté hodnoty je pravděpodobnost zanedbatelná
x <- 0:20
p <- dpois(x, lt) # hodnoty pravděpodobnostní funkce pro x
plot(x, p)


# * Příklad 5. ####
# Na stůl vysypeme 15 mincí. Jaká je pravděpodobnost, že počet mincí ležících lícem
# nahoře, je od 8 do 15?


# X ... počet mincí, které padnou lícem nahoru z celkového množství 15 mincí
# X ~ Bi(n = 15, p = 0.5)

n <- 15
p <- 0.5

# P(8 <= X <= 15) = P(X <= 15) - P(X < 8) = P(X <= 15) - P(X <= 7)
pbinom(15, n, p) - pbinom(7, n, p)


# jinak: P(8<=X<=15)=P(X>7)=1-P(X<=7)
1 - pbinom(7, n, p)


# graf pravděpodobnostní funkce
x <- 0:15 # všechny možné realizace NV X
p <- dbinom(x, n, p) # hodnoty pravděpodobnostní funkce pro x
plot(x, p)


# * Příklad 6. ####
# Pravděpodobnost, že se dovoláme do studia rozhlasové stanice, která právě vyhlásila
# telefonickou soutěž je 0,08. Jaká je pravděpodobnost, že se dovoláme nejvýše na 4.
# pokus?


# X ... počet pokusů než se dovoláme do rozhlasového studia
# X ~ NB(k = 1,p = 0.08) nebo G(0.08)

x <- 4
k <- 1
p <- 0.08

# P(X <= 4)
pnbinom(x - k, k, p)


# graf pravděpodobnostní funkce
# teoreticky můžeme uskutečnit až nekonečně mnoho pokusů,
# od jisté hodnoty je pravděpodobnost zanedbatelná
x <- 1:40
p <- dnbinom(x - k, k, p) # hodnoty pravděpodobnostní funkce pro x
plot(x, p)


# * Příklad 7. ####
# V továrně se vyrobí denně 10 % vadných součástek. Jaká je pravděpodobnost, že
# vybereme-li třicet součástek z denní produkce, tak nejméně dvě budou vadné?


# X ... počet vadných součástek ze 30 vybraných
# X ~ Bi(n = 30, p = 0.1)

n <- 30
p <- 0.1

# P(X >= 2) = 1 - P(X < 2) = 1 - P(X <= 1)
1 - pbinom(1, n, p)

# nebo P(X >= 2) vsechno mimo 0 a 1
1 - (dbinom(0, n, p) + dbinom(1, n, p))


# graf pravděpodobnostní funkce
x <- 0:30 # všechny možné realizace NV X
p <- dbinom(x, n, p) # hodnoty pravděpodobnostní funkce pro x
plot(x, p)


# * Příklad 8. ####
# Ve skladu je 200 součástek. 10 % z nich je vadných. Jaká je pravděpodobnost, že
# vybereme-li ze skladu třicet součástek, tak nejméně dvě budou vadné?


# X ... počet vadných součástek ze 30 vybraných z 200
# X ~ H(N = 200, M = 20, n = 30)

N <- 200
M <- 20
n <- 30

# P(X >= 2) = 1 - P(X < 2) = 1 - P(X <= 1)
1 - phyper(2 - 1, M, N - M, n)


# graf pravděpodobnostní funkce
x <- 0:30 # všechny možné realizace NV X
p <- dhyper(x, M, N - M, n) # hodnoty pravděpodobnostní funkce pro x
plot(x, p)


# * Příklad 9. ####
# V určité firmě bylo zjištěno, že na 33 % počítačů je nainstalován nějaký nelegální
# software. Určete pravděpodobnostní a distribuční funkci počtu počítačů s nelegálním
# softwarem mezi třemi kontrolovanými počítači.


# X ... počet počítačů s nelegálním softwarem ze 3 kontrolovaných
# X ~ Bi(n = 3,p = 0.33)

n <- 3
p <- 0.33

# pravděpodobnostní funkce
x <- 0:3 # všechny možné realizace NV X
p <- dbinom(x, n, p) # hodnoty pravděpodobnostní funkce pro x

p <- round(p, 3) # zaokrouhlení pravděpodobností na 3 des. místa
p[4] <- 1 - sum(p[1:3]) # dopočet poslední hodnoty do 1

tab <- rbind(x, p) # vytvoření tabulky pravděpodobnostní funkce
rownames(tab) <- c("x", "P(x)")
tab


# graf pravděpodobnostní funkce
plot(x, p)

# distribuční funkce
cumsum(p) # zjednodušený výpis distribuční funkce


# * Příklad 10. ####
# Sportka je loterijní hra, v níž sázející tipuje šest čísel ze čtyřiceti devíti, která
# očekává, že padnou při budoucím slosování. K účasti ve hře je nutné zvolit alespoň
# jednu kombinaci 6 čísel (vždy 6 čísel na jeden sloupec) a pomocí křížků tato čísla
# označit na sázence společnosti Sazka a.s. do sloupců, počínaje sloupcem prvním.
# Sázející vyhrává v případě, že uhodne alespoň tři čísla z tažené šestice čísel. Jaká
# je pravděpodobnost, že proto, aby sázející vyhrál, bude muset vyplnit:


# Nejprve pravděpodobnost, že vehrajeme v jednom sloupci

# Y ... počet uhádnutých čísel v 6 tažených ze 49
# Y ~ H(N = 49, M = 6, n = 6)

N <- 49
M <- 6
n <- 6

# P-st uhádnutí alespoň 3 čísel v jednom sloupci
# P(Y >= 3) = 1 - P(Y < 3) = 1 - P(Y <= 2)
pp <- 1 - phyper(3 - 1, M, N - M, n)
pp


# ** a) ####
# právě tři sloupce,


# X … počet sloupců, které bude muset sázející vyplnit, aby vyhrál
# X ~ NB(k = 1, p = pp)

# a) P(X = 3)
k <- 1
p <- pp

dnbinom(3 - k, k, pp)


# ** b)  ####
# alespoň 5 sloupců,


# b) P(X >= 5) = 1 - P(X < 5) = 1 - P(X <= 4)

1 - pnbinom(5 - k - 1, k, pp)


# ** c) ####
# méně než 10 sloupců,


# c) P(X < 10) = P(X <= 9)
pnbinom(10 - k - 1, k, pp)


# * d) ####
# více než 5 a nejvýše 10 sloupců?


# P(5 < X <= 10) = P(X <= 10) - P(X <= 5)
pnbinom(10 - k, k, pp) - pnbinom(5 - k, k, pp)
# nebo P(X < 11) - P(X < 6)
pnbinom(11 - k - 1, k, pp) - pnbinom(6 - k - 1, k, pp)


# * Příklad 11. ####
# Pravděpodobnost, že hodíme 6 na 6stěnné kostce je 1/6. Hážeme tak dlouho, než hodíme
# šestku 10 krát.
# ** a)  ####
# Jaká je střední hodnota počtu hodů.


# X … hodů kostkou než hodíme 10 šestek
# X ~ NB(k = 10, p = 1/6)

k <- 10
p <- 1 / 6

E_X <- k / p
E_X


# ** b)  ####
# S kolika hody nejméně musíme počítat, pokud chceme, aby pradvěpodobnost, že se nám
# podaří naházet 10 šestek, byla alespoň 70%.


# P(X <= k) >= 0.7
qnbinom(0.7, k, p) + k
