# ......................................................................................
# ................Cvičení 5 - Vybraná rozdělení spojité náhodné veličiny................
# ..................Martina Litschmannová, Adéla Vrtková, Michal Béreš..................
# ......................................................................................

# Nezobrazuje-li se vám text korektně, nastavte File \ Reopen with Encoding... na UTF-8
# Pro zobrazení obsahu skriptu použijte CTRL+SHIFT+O
# Pro spouštění příkazů v jednotlivých řádcích použijte CTRL+ENTER

#  Přehled rozdělení a jejich funkcí ####
# * Úvod: Hustota pravděpodobnosti, Distribuční funkce a Kvantilová funkce ####
# ** Hustota pravděpodobnosti ####
# - začíná písmenkem **d**: p = d...(x, ...)
#
# ** Distribuční funkce ####
# - začíná písmenkem **p**: $p = P(X < x)$: p = p...(x, ...)
#
# ** Kvantilová funkce ####
# - začíná písmenkem **q**:  najdi x pro zadané p: $p = F(x) \rightarrow x = F^{-1}(p)$:
# x = q...(p, ...)


# * Rovnoměrné rozdělení: $X \sim Ro(a, b)$ ####
# - náhodná veličina nabývá pouze hodnot větších než a a menších než b
# - všechny hodnoty mají stejnou hustotu výskytu -> hustota pravděpodobnosti je
# konstantní mezi a a b, jinde nulová


# Hustota pravděpodobnosti f(x)
a <- 2 # odkud
b <- 4 # kam
x <- 3
dunif(x, a, b)


# vykreslíme si Hustotu pravděpodobnosti
x <- seq(from = 0, to = 6, by = 0.01)
f_x <- dunif(x, a, b)
plot(x, f_x, cex = 0.1) # cex je velikost markerů
grid()


# Distribuční funkce F(x) = P(X < x)
a <- 2 # odkud
b <- 4 # kam
x <- 3
punif(x, a, b)


# vykreslíme si Distribuční funkci
x <- seq(from = 0, to = 6, by = 0.01)
F_x <- punif(x, a, b)
plot(x, F_x, type = "l")
grid()


# kvantilová funkce F^(-1)(p) = x: P(X<x)=p
a <- 2 # odkud
b <- 4 # kam
p <- 0.75
qunif(p, a, b)


# vykreslení - kvantilová funkce F^(-1)(p) = x
p <- seq(from = 0, to = 1, by = 0.01)
x <- qunif(p, a, b)
plot(p, x, type = "l")
grid()


# * Exponenciální rozdělení: $X \sim Exp(\lambda)$ ####
# - doba do 1. události, doba mezi událostmi (pouze v období stabilního života -
# Poissonův proces)
# - parametr $\lambda$ je tentýž co v Poissonově rozdělení
# - střední hodnota je: $E(X)=1 / \lambda$


# Hustota pravděpodobnosti f(x)
lambda <- 2
x <- 1
dexp(x, lambda)


# vykreslíme si Hustotu pravděpodobnosti
x <- seq(from = 0, to = 6, by = 0.01)
f_x <- dexp(x, lambda)
plot(x, f_x, type = "l")
grid()


# Distribuční funkce F(x) = P(X < x)
lambda <- 2
x <- 1
pexp(x, lambda)


# vykreslíme si Distribuční funkci
x <- seq(from = 0, to = 6, by = 0.01)
F_x <- pexp(x, lambda)
plot(x, F_x, type = "l")
grid()


# kvantilová funkce F^(-1)(p) = x: P(X<x)=p
lambda <- 2
p <- 0.5
qexp(p, a, b)


# vykreslení - kvantilová funkce F^(-1)(p) = x
p <- seq(from = 0, to = 1, by = 0.001)
x <- qexp(p, lambda)
plot(p, x, type = "l")
grid()


# * Weibullovo rozdělení: $X \sim W(\theta,\beta)$ ####
# - doba do 1. události (poruchy)(vhodná volba β umožuje použití v libovolném období
# intenzity poruch)
# - rozšíření exponenciálního rozdělení Exp(λ) = W(Θ=1/λ, β=1)


# Hustota pravděpodobnosti f(x)
theta <- 1 / 2 # ekvivalent 1/lambda u exp. rozdělení
beta <- 1 # beta = 1 -> exponenciální rozdělení
x <- 5
dweibull(x, shape = beta, scale = theta)


# vykreslíme si Hustotu pravděpodobnosti
x <- seq(from = 0, to = 6, by = 0.01)
f_x <- dweibull(x, shape = beta, scale = theta)
plot(x, f_x, type = "l")
grid()


# Distribuční funkce F(x) = P(X < x)
theta <- 3 # ekvivalent 1/lambda u exp. rozdělení
beta <- 2 # beta = 1 -> exponenciální rozdělení
x <- 5
pweibull(x, shape = beta, scale = theta)


# vykreslíme si Distribuční funkci
x <- seq(from = 0, to = 6, by = 0.01)
F_x <- pweibull(x, shape = beta, scale = theta)
plot(x, F_x, type = "l")
grid()


# kvantilová funkce F^(-1)(p) = x: P(X<x)=p
theta <- 3 # ekvivalent 1/lambda u exp. rozdělení
beta <- 2 # beta = 1 -> exponenciální rozdělení
p <- 0.5
qweibull(p, shape = beta, scale = theta)


# vykreslení - kvantilová funkce F^(-1)(p) = x
p <- seq(from = 0, to = 1, by = 0.01)
x <- qweibull(p, shape = beta, scale = theta)
plot(p, x, type = "l")
grid()


# * Normální rozdělení: $X \sim N(\mu,\sigma^2)$ ####
# - rozdělení modelující např. chyby měření, chování součtu/průměru mnoha jiných
# náhodných veličin
# - viz. Centrální limitní věta
# - $\mu$ je přímo střední hodnota rozdělení: $E(X)=\mu$
# - $\sigma$ je přímo směrodatná odchyla rozdělení: $D(X)=\sigma^2$
# - s parametry $\mu=0,\sigma=1$ se nazývá normované Normální rozdělení


# Hustota pravděpodobnosti f(x)
mu <- 2
sigma <- 3
x <- 4
dnorm(x, mean = mu, sd = sigma)


# vykreslíme si Hustotu pravděpodobnosti
x <- seq(from = -5, to = 10, by = 0.01)
f_x <- dnorm(x, mean = mu, sd = sigma)
plot(x, f_x, type = "l")
grid()


# Distribuční funkce F(x) = P(X < x)
mu <- 2
sigma <- 3
x <- 4
pnorm(x, mean = mu, sd = sigma)


# vykreslíme si Distribuční funkci
x <- seq(from = -5, to = 10, by = 0.01)
F_x <- pnorm(x, mean = mu, sd = sigma)
plot(x, F_x, type = "l")
grid()


# kvantilová funkce F^(-1)(p) = x: P(X<x)=p
mu <- 2
sigma <- 3
p <- 0.5
qnorm(p, mean = mu, sd = sigma)


# vykreslení - kvantilová funkce F^(-1)(p) = x
p <- seq(from = 0, to = 1, by = 0.01)
x <- qnorm(p, mean = mu, sd = sigma)
plot(p, x, type = "l")
grid()


#  Příklady ####


# * Příklad 1. ####
# Výška v populaci chlapců ve věku 3,5-4 roky má normální rozdělení se střední hodnotou
# 102 cm a směrodatnou odchylkou 4,5 cm. Určete, jaké procento chlapců v uvedeném věku
# má výšku menší nebo rovnou 93 cm.


# X ... výška chlapců ve věku 3.5 až 4 roky (cm)
# X ~ N(mu = 102, sd = 4.5)

mu <- 102
sigma <- 4.5

# P(X<=93)=F(93)
pnorm(93, mean = mu, sd = sigma)


# * Příklad 2. ####
# Průměrná životnost strojní součástky je 30 000 hodin. Předpokládejme, že součástka je
# v období
# stabilního života. Určete:


# X ... životnost součástky (h)
# X ~ Exp(lambda), kde E(X)=1/lambda

lambda <- 1 / 30000


# ** a) ####
# pravděpodobnost, že součástka nevydrží více než 2 000 hodin,


# a) P(X<2000)=F(2000)
pexp(2000, lambda)


# ** b) ####
# pravděpodobnost, že součástka vydrží více než 35 000 hodin,


# b) P(X>35000)=1-F(35000)
1 - pexp(35000, lambda)


# ** c) ####
#  dobu, do níž se porouchá 95 % součástek.


# c) P(X<t)=0,95 -> F(t)=0,95 -> t… 95% kvantil
qexp(0.95, lambda)


# * Příklad 3. ####
# Výrobní zařízení má poruchu v průměru jednou za 2000 hodin. Veličina Y představující
# dobu čekání na poruchu má exponenciální rozdělení. Určete dobu T0 tak, aby
# pravděpodobnost, že přístroj bude pracovat delší dobu než T0, byla 0,99.


# X ... doba čekání na poruchu (h)
# X ~ Exp(lambda), kde E(X)=1/lambda
lambda <- 1 / 2000

# P(X>t)=0,99 -> 1-F(t)=0,99 -> F(t)=0,01 -> t… 1% kvant.
qexp(0.01, lambda)


# * Příklad 4. ####
# Výsledky měření jsou zatíženy jen normálně rozdělenou chybou s nulovou střední
# hodnotou a se směrodatnou odchylkou 3 mm. Jaká je pravděpodobnost, že při 3 měřeních
# bude alespoň jednou chyba v intervalu (0 mm; 2,4mm)?


# Y… velikost chyby měření (mm)
# Y ~ N(mu = 0,sigma = 3)

mu <- 0
sigma <- 3

# pp… pravd., že chyba měření bude v int. 0,0-2,4mm
pp <- pnorm(2.4, mean = mu, sd = sigma) - pnorm(0, mean = mu, sd = sigma)
pp


# X … počet chyb měření v int. 0 mm -2,4 mm ve 3 měř.
# X ~ Bi(n = 3,p = pp)
n <- 3
p <- pp

# P(X>=1)=1-P(X=0)
1 - dbinom(0, n, p)


# * Příklad 5. ####
# Ve velké počítačové síti se průměrně přihlašuje 25 uživatelů za hodinu. Určete
# pravděpodobnost,
# že:
# ** a)  ####
# se nikdo nepřihlásí během 14:30 - 14:36,


# X … počet uživatelů přihlášených za 6 minut
# X ~ Po(lt = 2.5)

lambda <- 25 / 60
t <- 6
lt <- lambda * t

# P(X=0)
dpois(0, lt)


# ** b)  ####
# do dalšího přihlášení uběhnou 2-3 minuty.


# Y … doba do dalšího přihlášení
# Y ~ Exp(lambda = 25/60), kde E(X)=1/lambda
lambda <- 25 / 60

# P(2<Y<3)=F(3)-F(2)
pexp(3, lambda) - pexp(2, lambda)


# ** c) ####
# Určete maximální délku časového intervalu tak, aby pravděpodobnost, že se nikdo
# nepřihlásí byla alespoň 0,90.


# P(Y>t)=0,90 -> 1-F(t)=0,90 -> F(t)=0,10 -> t…10% kv.

qexp(0.10, lambda) * 60


# * Příklad 6. ####
# Náhodná veličina X má normální rozdělení N(µ; σ). Určete:
# ** a) ####
# P(µ − 2σ < X < µ + 2σ),


# P(µ − 2σ < X < µ + 2σ) = F(µ + 2σ) - F(µ - 2σ)
# X~N(µ,σ)
# je jedno jaké hodnoty zvolíme
mu <- -105.5447
sigma <- 2.654

pnorm(mu + 2 * sigma, mean = mu, sd = sigma) -
    pnorm(mu - 2 * sigma, mean = mu, sd = sigma)


# ** b) ####
# nejmenší k ∈ Z, tak, aby P(µ − kσ < X < µ + kσ) > 0,99.


# normální rozdělení je symetrické
# P(µ − kσ < X < µ + kσ) =
# = 1 - (P(X < µ − kσ ) + P(X > µ + kσ)) =
# = 1 - 2*P(X > µ + kσ) = 0.99 -> P(X > µ + kσ) = 0.005
# -> P(X < µ + kσ) = 0.995

# x = µ + kσ
x <- qnorm(0.995, mean = mu, sd = sigma)
(x - mu) / sigma


for (k in 1:5) {
    p <- pnorm(mu + k * sigma, mean = mu, sd = sigma) -
        pnorm(mu - k * sigma, mean = mu, sd = sigma)
    print(paste0(k, ":", p))
}


# * Příklad 7. ####
# Na prohlídce výstavy je promítán doprovodný film o životě autora vystavovaných děl.
# Jeho projekce začíná každých 20 minut. Určete pravděpodobnost, že pokud náhodně
# přijdete do promítacího sálu,


# Y … doba do začátku další projekce
# Y ~ Ro(a=0, b=20)

a <- 0
b <- 20


# ** a) ####
# nebudete na začátek filmu čekat víc než 5 minut,


# P(X<5)
punif(5, a, b)


# ** b) ####
# budete čekat mezi 5 a 10 minutami,


# P(5<X<10)
punif(10, a, b) - punif(5, a, b)


# ** c) ####
# střední hodnotu a směrodatnou odchylku doby čekání na začátek filmu.


E_X <- (a + b) / 2
E_X

D_X <- (a - b)^2 / 12
D_X

sigma_X <- sqrt(D_X)
sigma_X


# * Příklad 8. ####
# Při kontrole jakosti přebíráme součástku pouze tehdy, jestliže se její rozměr pohybuje
# v mezích 26-27 mm. Rozměry součástek mají normální rozdělení se střední hodnotou 26,4
# mm a směrodatnou odchylkou 0,2 mm. Jaká je pravděpodobnost, že rozměr součástky
# náhodně vybrané ke kontrole bude v požadovaných mezích?


# X ... rozměr součástky (mm)
# X ~ N(mu =  26.4,sigma = 0.2)

mu <- 26.4
sigma <- 0.2

# P(26<X<27)=F(27)-F(26)
pnorm(27, mean = mu, sd = sigma) - pnorm(26, mean = mu, sd = sigma)


# * Příklad 9. ####
# Délka skoků sportovce Jakuba měřená v cm má normální rozdělení N(µ1; σ1), kde µ1 = 690
# a σ1 = 10. Délka skoků sportovce Aleše měřená v cm má také normální rozdělení N(µ2;
# σ2), kde µ2 = 705 a σ2 = 15. Na závody se kvalifikuje ten, kdo ze dvou skoků alespoň
# jednou skočí více než 700 cm.


# SJ ... délka skoku Jakuba
# SJ ~ N(mu = 690,sigma = 10)
mu_J <- 690
sigma_J <- 10

# SA … délka skoku Aleše
# SA ~ N(mu = 705,sigma = 15)
mu_A <- 705
sigma_A <- 15

# J...Jakubův skok je úspěšný (delší než 700 cm)
# A...Alešův skok je úspěšný (delší než 700 cm)

# P(J)=P(SJ>700)=1-F(700)
P.J <- 1 - pnorm(700, mean = mu_J, sd = sigma_J)
P.J

# P(A)=P(SA>700)=1-F(700)
P.A <- 1 - pnorm(700, mean = mu_A, sd = sigma_A)
P.A


# KJ … Jakub se kvalifikuje na závody,
# P(KJ) = 1-(1-P(J))(1-P(J))
P.KJ <- 1 - (1 - P.J) * (1 - P.J)
P.KJ

# KA … Aleš se kvalifikuje na závody,
# P(KA) = 1-(1-P(A))(1-P(A))
P.KA <- 1 - (1 - P.A) * (1 - P.A)
P.KA


# ** a) ####
# S jakou pravděpodobností se oba dva kvalifikují na závody?


# ada)
P.KJ * P.KA


# ** b) ####
# S jakou pravděpodobností se kvalifikuje Aleš, ale Jakub ne?




# adb)
(1 - P.KJ) * P.KA
