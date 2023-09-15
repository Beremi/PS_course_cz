# ......................................................................................
# .............. Cvičení 9. Úvod do testování hypotéz, jednovýběrové testy..............
# ......................... Michal Béreš, Martina Litschmannová.........................
# ......................................................................................

# Nezobrazuje-li se vám text korektně, nastavte File \ Reopen with Encoding... na UTF-8
# Pro zobrazení obsahu skriptu použijte CTRL+SHIFT+O
# Pro spouštění příkazů v jednotlivých řádcích použijte CTRL+ENTER

#  Od intervalových odhadů k testům hypotéz ####
# * Co je to statistický test hypotéz? ####
# Mějme následující:
# - náhodná veličina X (například výška mužů)
# - výběr z náhodné veličiny (měření výšky 30 mužů)
#
# Statistické testování hypotéz rozhoduje na základě získaných dat z náhodného výběru o
# platnosti:
# - $H_0$ - nulové hypotézy
# - $H_A$ - alternativní hypotézy
#
# Například:
# $H_0$: $\mu_X = 175$
# $H_A$: $\mu_X > 175$
# Jelikož se jedná o statistické rozhodnutí, vždy bude vázáno k nějaké hladnině
# významnosti $\alpha$. Vždy můžeme dospět pouze k 2 různým rozhodnutím:
# - Zamítám $H_0$ ve prospěch $H_A$
#     - to znamená, že tvrdím, že $H_0$ neplatí
#     - toto rozhodnutí je s maximální chybou $\alpha$ (hladina významnosti, chyba I.
# druhu) - to znamená, že velikost této chyby jsme schopni ovlivnit
# - Nezamítám $H_0$
#     - to znamená, že tvrdím, že vzhledem k získaným datům (výběr) nelze vyvrátit $H_0$
#     - toto rozhodnutí je s chybou $\beta$ (chyba II. druhu), tato chyba není přímo
# ovlivnitelná a záleží na typu použitého testu
#
# Jak testy hypotéz souvisí s intervalovými odhady a jak do nich vstupuje hladina
# významnosti si ukážeme v další části.


# * Intervalový odhad a hladina významnosti ####


data <- readxl::read_excel("data/uvod.xlsx")
head(data)


options(repr.plot.width = 12) # šířka grafů v Jupyteru
par(mfrow = c(1, 2)) # matice grafů 1x2

boxplot(data$data)
hist(data$data)


moments::skewness(data$data) # šikmost
moments::kurtosis(data$data) - 3 # špičatost

shapiro.test(data$data)$p.value # test normality


length(data$data)
mean(data$data)
sd(data$data)


# Vyrobíme 95% intervalový odhad střední hodnoty pomocí t-testu:


t.test(data$data, alternative = "two.sided", conf.level = 0.95)$conf.int


# Představme si nyní, že chceme testovat hypotézu:
# $H_0$: $\mu = 100$
# $H_A$: $\mu \neq 100$
# Jaké by bylo rozhodnutí vzhledem k spočtenému IO a tedy hladině významnosti $\alpha =
# 0.05$?


# Představme si dále, že chceme testovat hypotézu:
# $H_0$: $\mu = 105$
# $H_A$: $\mu \neq 105$
# Jaké by bylo rozhodnutí vzhledem k spočtenému IO a tedy hladině významnosti $\alpha =
# 0.05$?


# **To co jsme právě udělali se nazývá klasický test.**
# Ukážeme si ještě klasické testy pro jednostranné alternativy.
# $H_0$: $\mu = 105$
# $H_A$: $\mu > 105$


t.test(data$data, alternative = "greater", conf.level = 0.95)$conf.int


# $H_0$: $\mu = 105$
# $H_A$: $\mu < 105$


t.test(data$data, alternative = "less", conf.level = 0.95)$conf.int


# Všimněte si, že první z těchto jednostranných alternativ vedla k "nezamítnutí" $H_0$.
# Je to z důvodu porovnávání nepravděpodobné $H_0$ s ještě méně pravděpodobnou $H_A$.
# *** Čistý test významnosti a souvislost s IO ####
# Alternativou ke klasickému testu (kde vytváříme IO - v terminologii klasických testů
# tzv. obor přijetí a jeho doplněk do R kritický obor) je tzv. čistý test významnosti:


# H_0: mu = 105
# H_A: mu <> 105
t.test(data$data, mu = 105, alternative = "two.sided")


t.test(data$data, mu = 105, alternative = "two.sided")$p.value


# Výsledkem čistého testu významnosti je p-hodnota. Na jejím základě rozhodujeme o
# zamítnutí či nezamítnutí $H_0$.
# p-hodnota se dá chápat jako nejvyšší možná hladina váznamnosti, taková aby naše
# rozhodnutí bylo - nezamítám. Tedy IO/obor přijetí by obsahoval zkoumanou hodnotu:


# H_0: mu = 105
# H_A: mu <> 105

p.hod <- t.test(data$data, mu = 105, alternative = "two.sided")$p.value
p.hod

t.test(data$data, alternative = "two.sided", conf.level = 1 - p.hod)$conf.int


# H_0: mu = 105
# H_A: mu > 105

p.hod <- t.test(data$data, mu = 105, alternative = "greater")$p.value
p.hod

t.test(data$data, alternative = "greater", conf.level = 1 - p.hod)$conf.int


# H_0: mu = 105
# H_A: mu < 105

p.hod <- t.test(data$data, mu = 105, alternative = "less")$p.value
p.hod

t.test(data$data, alternative = "less", conf.level = 1 - p.hod)$conf.int


# * Přehled testů ####
# ** Míry polohy ####
# Mírami polohy rozumíme údaj určující polohu dat, nehledě na tom jak jsou rozptýlená.
# Pro data z normálního rozdělení můžeme odhadovat střední hodnotu, pro ostatní medián.
# *** a) studentův t-test ####
# - testujeme střední hodnotu
# - data musejí pocházet z normálního rozdělení
#     - exploračně: šikmost a špičatost leží v (-2,2)
#     - exploračně: QQ graf má body přibližně na čáře
#     - exaktně: pomocí statistického testu, např. Shapiro-Wilk test
# (shapiro.test(data))


# H_0: mu = 100
# H_A: mu <> 100
t.test(data$data, mu = 100, alternative = "two.sided")$p.value


# H_0: mu = 100
# H_A: mu > 100
t.test(data$data, mu = 100, alternative = "greater")$p.value


# H_0: mu = 100
# H_A: mu < 100
t.test(data$data, mu = 100, alternative = "less")$p.value


# *** b) Wilcoxnův test ####
# - testujeme medián
# - data musejí pocházet ze symetrického rozdělení
#     - exploračně: šikmost leží v (-2,2)
#     - exploračně: histogram vypadá přibližně symetricky
#     - exaktně: pomocí statistického testu, např. balíček "lawstat", funkce
# "symmetry.test(data,boot=FALSE)"


# H_0: X_0.5 = 100
# H_A: X_0.5 <> 100
wilcox.test(data$data, mu = 100, alternative = "two.sided")$p.value


# H_0: X_0.5 = 100
# H_A: X_0.5 > 100
wilcox.test(data$data, mu = 100, alternative = "greater")$p.value


# H_0: X_0.5 = 100
# H_A: X_0.5 < 100
wilcox.test(data$data, mu = 100, alternative = "less")$p.value


# *** c) znaménkový test test ####
# - testujeme medián
# - výběr většího rozsahu (>10)
# - vyžaduje knihovnu "BSDA"
# - jakožto nejrobustnější test, se dá použít i na nespojitá data - např. pořadí v
# nějakém seznamu


# H_0: X_0.5 = 100
# H_A: X_0.5 <> 100
BSDA::SIGN.test(data$data, md = 100, alternative = "two.sided")$p.value


# H_0: X_0.5 = 100
# H_A: X_0.5 > 100
BSDA::SIGN.test(data$data, md = 100, alternative = "greater")$p.value


# H_0: X_0.5 = 100
# H_A: X_0.5 < 100
BSDA::SIGN.test(data$data, md = 100, alternative = "less")$p.value


# ** Míry variability ####
# Mírami variability rozumíme údaj určující rozptýlenost/variabilitu dat, nehledě na
# celkových hodnotách. Pro data z normálního rozdělení můžeme odhadovat směrodatnou
# odchylku.
# *** test směrodatné odchylky ####
# - testujeme směrodatnou odchylku
# - data musejí pocházet z normálního rozdělení
#     - exploračně: šikmost a špičatost leží v (-2,2)
#     - exploračně: QQ graf má body přibližně na čáře
#     - exaktně: pomocí statistického testu, např. Shapiro-Wilk test
# (shapiro.test(data))
# - vyžaduje balíček "EnvStats"
# - funkce v Rku, porovnává rozptyl!!!


# H_0: sigma = 10
# H_A: sigma <> 10
EnvStats::varTest(data$data,
    sigma.squared = 10 * 10,
    alternative = "two.sided"
)$p.value


# H_0: sigma = 10
# H_A: sigma > 10
EnvStats::varTest(data$data,
    sigma.squared = 10 * 10,
    alternative = "greater"
)$p.value


# H_0: sigma = 10
# H_A: sigma < 10
EnvStats::varTest(data$data,
    sigma.squared = 10 * 10,
    alternative = "less"
)$p.value


# * Pravděpodobnost výskytu u jednoho výběru ####
# *** IO pravděpodobnosti ####
# - testujeme pravděpodobnost
# - vyžadujeme dostatečný počet dat: $n>\frac{9}{p(1-p)}$
# - Clopperův - Pearsonův odhad (binom.test)
#     - jako parametr nebere data, ale počet úspěchů a počet pozorování


pi <- 0.3
data_bin <- runif(n = 100, min = 0, max = 1) < pi

n <- length(data_bin)
x <- sum(data_bin)
n
x


# H_0: pi = 0.2
# H_A: pi <> 0.2
binom.test(x = x, n = n, p = 0.2, alternative = "two.sided")$p.value


# H_0: pi = 0.2
# H_A: pi > 0.2
binom.test(x = x, n = n, p = 0.2, alternative = "greater")$p.value


# H_0: pi = 0.2
# H_A: pi < 0.2
binom.test(x = x, n = n, p = 0.2, alternative = "less")$p.value


#  Příklady ####
# * Příklad 1. ####
# Máme výběr 216 pacientů a změřili jsme jejich bílkovinné sérum (soubor
# testy_jednovyberove.xlsx list bilk_serum). Ověřte, zda se průměrné bílkovinné sérum
# (Albumin) všech pacientů tohoto typu (populační průměr µ) statisticky významně liší od
# hodnoty 35 g/l.


# Načtení dat z xlsx souboru (pomoci balíčku readxl)
albumin <- readxl::read_excel("data/testy_jednovyberove.xlsx",
    sheet = "bilk_serum"
)
head(albumin)


colnames(albumin) <- "hodnoty"


# Explorační analýza
boxplot(albumin$hodnoty)
summary(albumin$hodnoty)


length(albumin$hodnoty) # sd zaokrouhlujeme na 3 platné cifry
sd(albumin$hodnoty) # sd a míry polohy zaokrouhlujeme na tisíciny


# **Test na míru polohy**


# Ověření normality - exploračně
moments::skewness(albumin$hodnoty) # šikmost
moments::kurtosis(albumin$hodnoty) - 3 # špičatost

options(repr.plot.width = 12) # šířka grafů v Jupyteru
par(mfrow = c(1, 2)) # matice grafů 1x2

qqnorm(albumin$hodnoty)
qqline(albumin$hodnoty)
hist(albumin$hodnoty)


# Pro konečné rozhodnutí o normalitě dat použijeme test normality.

# Předpoklad normality ověříme Shapirovovým - Wilkovovým testem.
# H0: Data jsou výběrem z normálního rozdělení.
# Ha: Data nejsou výběrem z normálního rozdělení.
shapiro.test(albumin$hodnoty)
# p-value > 0.05 -> Na hl. významnosti 0,05 nelze předpoklad normality zamít.


# normalita OK -> t.test

# H0: mu = 35 g/l
# Ha: mu <> 35 g/l

t.test(albumin$hodnoty, mu = 35, alternative = "two.sided")

# p-value < 0.05 -> Na hl. významnosti 0,05 zamítáme nulovou hypotézu
# ve prospěch hypotézy alternativní
# Střední hodnota albuminu se statisticky významně liší od 35 g/l.


# * Příklad 2. ####
# V souboru testy_jednovyberove.xlsx list preziti jsou uvedeny doby přežití pro 100
# pacientů s rakovinou plic léčených novým lékem. Z předchozích studií je známo, že
# průměrné přežití takových pacientů bez podávání nového léku je 22,2 měsíce. Lze na
# základě těchto dat usoudit, že nový lék prodlužuje přežití?


# Načtení dat z xlsx souboru (pomoci balíčku readxl)
preziti <- readxl::read_excel("data/testy_jednovyberove.xlsx",
    sheet = "preziti"
)
head(preziti)


colnames(preziti) <- "hodnoty"


## Explorační analýza
par(mfrow = c(1, 2)) # matice grafů 1x2

boxplot(preziti$hodnoty)
hist(preziti$hodnoty)


# **Data obsahují OP -> můžeme je odstranit. Nebo si také všimnout, že se pravděpdobně
# jedná o exponenciální rozdělení a OP tam ve skutečnosti nejsou (rozdělení se tak
# prostě chová).**


# Data obsahují odlehlá pozorování. Pomoci f-ce boxplot je umíme vypsat.
pom <- boxplot(preziti$hodnoty, plot = FALSE)
pom$out
# rozhodli-li jsme se pro odstranění odlehlých hodnot, pak
preziti$hodnoty.bez <- preziti$hodnoty # doporučujeme nepřepisovat původní data
preziti$hodnoty.bez[preziti$hodnoty %in% pom$out] <- NA


## Explorační analýza pro data bez odlehlých pozorování
boxplot(preziti$hodnoty.bez)
summary(preziti$hodnoty.bez, na.rm = TRUE)


length(na.omit(preziti$hodnoty.bez)) # sd zaokrouhlujeme na 3 platné cifry
sd(preziti$hodnoty.bez, na.rm = TRUE) # sd a míry polohy zaokr. na desetiny


# **Test o míře polohy (střední hodnotě / mediánu)**


# Ověření normality - exploračně
moments::skewness(preziti$hodnoty.bez, na.rm = TRUE)
moments::kurtosis(preziti$hodnoty.bez, na.rm = TRUE) - 3

par(mfrow = c(1, 2)) # matice grafů 1x2

qqnorm(preziti$hodnoty.bez)
qqline(preziti$hodnoty.bez)
hist(preziti$hodnoty.bez)

# QQ - graf i hist. ukazují, že výběr pravd. není výběrem z norm. rozdělení.
# Šikmost i špičatost odpovídá norm. rozdělení.
# použijeme test normality.


# Předpoklad normality ověříme Shapirovovým . Wilkovovým testem.
shapiro.test(preziti$hodnoty.bez)
# p-value < 0.05 -> Na hl. významnosti 0.05 zamítáme předpoklad normality


# explorační posouzení symetrie - výše hist. a šikmost

# Předpoklad symetrie - ověření testem
# H0: data pocházejí ze symetrického rozdělení
# HA: ~H0

lawstat::symmetry.test(preziti$hodnoty.bez, boot = FALSE)
# p-value < 0.05 -> Na hl. významnosti 0.05 zamítáme předpoklad symetrie


# normalita zamítnuta -> symetrie zamítnuta -> Sign. test
# H0: median = 22,2 měsíců
# Ha: median > 22,2 měsíců

BSDA::SIGN.test(preziti$hodnoty.bez,
    md = 22.2,
    alternative = "greater", conf.level = 0.95
)

# p-value > 0.05 -> Na hl. významnosti 0,05 nelze zamítnout nulovou hypotézu
# Medián doby přežití není statisticky významně větší než 22,2 měsíců.


median(preziti$hodnoty.bez, na.rm = TRUE)


# H0: median = 22,2 měsíců
# Ha: median < 22,2 měsíců

BSDA::SIGN.test(preziti$hodnoty.bez,
    md = 22.2,
    alternative = "less", conf.level = 0.95
)


# * Příklad 3. ####
# Automat vyrábí pístové kroužky o daném průměru. Výrobce udává, že směrodatná odchylka
# průměru kroužku je 0,05 mm. K ověření této informace bylo náhodně vybráno 80 kroužků a
# vypočtena směrodatná odchylka jejich průměru 0,04 mm. Lze tento rozdíl považovat za
# statisticky významný ve smyslu zlepšení kvality produkce? Ověřte čistým testem
# významnosti. Předpokládejte, že průměr pístových kroužků má normální rozdělení.


# Test o směrodatné odchylce

# Předpokládáme normalitu dat (dle zadání)
n <- 80 # rozsah souboru
s <- 0.04 # mm .... výběrová směrodatná odchylka (bodový odhad sm. odchylky)

# H0: sigma = 0.05 mm
# Ha: sigma < 0.05 mm

x.obs <- (n - 1) * s^2 / 0.05^2
x.obs


p.hodnota <- pchisq(x.obs, n - 1)
p.hodnota

# p.hodnota < 0.05 -> Na hladině významnosti 0,05 zamítáme nulovou hypotézu
# ve prospěch alternativní hypotézy
# Směr. odchylka průměru kroužku je statisticky významně menší než 0,05 mm.


# * Příklad 4. ####
# Automat vyrábí pístové kroužky o daném průměru. Výrobce udává, že směrodatná odchylka
# průměru kroužku je 0,05 mm. K ověření této informace bylo náhodně vybráno 80 kroužků a
# byl změřen jejich průměr (soubor testy_jednovyberove.xlsx list krouzky). Lze zjištěné
# výsledky považovat za statisticky významné ve smyslu zlepšení kvality produkce? Ověřte
# čistým testem významnosti.


# Načtení dat z xlsx souboru (pomoci balíčku readxl)
krouzky <- readxl::read_excel("data/testy_jednovyberove.xlsx",
    sheet = "krouzky"
)
head(krouzky)


colnames(krouzky) <- "hodnoty"


## Explorační analýza
boxplot(krouzky$hodnoty)


# Data obsahují odlehlá pozorování. Pomoci f-ce boxplot je umíme vypsat.
pom <- boxplot(krouzky$hodnoty, plot = FALSE)
pom$out
# rozhodli-li jsme se pro odstranění odlehlých hodnot, pak
krouzky$hodnoty.bez <- krouzky$hodnoty
krouzky$hodnoty.bez[krouzky$hodnoty %in% pom$out] <- NA


# Explorační analýza pro data bez odlehlých pozorování
summary(krouzky$hodnoty.bez, na.rm = TRUE)
boxplot(krouzky$hodnoty.bez)


length(na.omit(krouzky$hodnoty.bez)) # sd zaokrouhlujeme na 3 platné cifry
sd(krouzky$hodnoty.bez, na.rm = TRUE) # sd a míry polohy zaokr. na tisíciny


# Ověření normality - exploračně
moments::skewness(krouzky$hodnoty.bez, na.rm = TRUE)
moments::kurtosis(krouzky$hodnoty.bez, na.rm = TRUE) - 3

par(mfrow = c(1, 2)) # matice grafů 1x2

qqnorm(krouzky$hodnoty.bez)
qqline(krouzky$hodnoty.bez)
hist(krouzky$hodnoty.bez)
# Šikmost i špičatost odpovídá norm. rozdělení.
# Pro konečné rozhodnutí o normalitě dat použijeme


# test normality.
# Předpoklad normality ověříme Shapirovovým . Wilkovovým testem.
shapiro.test(krouzky$hodnoty.bez)
# p-value > 0.05 -> Na hl. významnosti 0,05 nelze předpoklad norm. zamítnout


# test na míru variability -> test o rozptylu

# H0: sigma = 0,05 mm
# Ha: sigma < 0,05 mm
EnvStats::varTest(krouzky$hodnoty.bez,
    sigma.squared = 0.05^2,
    alternative = "less"
)

# p-value < 0.05 -> Na hladině významnosti 0,05 zamítáme H0 ve prospěch Ha


# Jak najít 95% intervalový odhad směrodatné odchylky?
pom <- EnvStats::varTest(krouzky$hodnoty.bez,
    sigma.squared = 0.05^2,
    alternative = "less", conf.level = 0.95
)

sqrt(pom$conf.int)


# * Příklad 5. ####
# Firma TT udává, že 1% jejich rezistorů nesplňuje požadovaná kritéria. V testované
# dodávce 1000 ks bylo nalezeno 15 nevyhovujících rezistorů. Potvrzuje tento výsledek
# tvrzení TT? Ověřte čistým testem významnosti.


n <- 1000 # rozsah výběru
x <- 15 # počet "úspěchů"
p <- x / n # relativní četnost (bodový odhad pravděpodobnosti)
p


# Ověření předpokladů
9 / (p * (1 - p))
# Dále předpokládáme  n/N < 0.05, tj. že daná populace (rezistorů) má rozsah
# alespoň 1000/0.05 = 1000*20 = 20 000 rezistorů


## Clopperův - Pearsonův (exaktní) test
## H0: pi = 0.01
## Ha: pi <> 0.01

binom.test(x = x, n = n, p = 0.01, alternative = "two.sided")


## Clopperův - Pearsonův (exaktní) test
## H0: pi = 0.01
## Ha: pi > 0.01

binom.test(x = x, n = n, p = 0.01, alternative = "greater")

# Na hladině významnosti 0,05 nezamítáme H0
# Nelze očekávat, že podíl vadných rezistorů ve výrobě statisticky významně
# převyšuje 1 %.
