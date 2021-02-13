# ......................................................................................
# .................. Ccičení 7. Preprocesing dat a explorační analýza ..................
# ......................... Adéla Vrtková, Martina Litschmannová........................
# ......................................................................................

# Nezobrazuje-li se vám text korektně, nastavte File \ Reopen with Encoding... na UTF-8
# Pro zobrazení obsahu skriptu použijte CTRL+SHIFT+O
# Pro spouštění příkazů v jednotlivých řádcích použijte CTRL+ENTER

#   Základní skript ####
# 
# 
#   Máme data, a co dál?
#    1. Spustíme potřebné balíčky, které obsahují další statistické funkce
#    2. Nastavíme pracovní adresář, odkud importujeme data, popř. kam chceme ukládat
# výstupy
#    3. Importujeme data (z pracovního adresáře, z internetu)
#    4. Pre-processing ->  
#     1. Podíváme se na data
#     2. uložíme si data ve více formátech (každá funkce má "raději" jiný formát)
#    5. Analýza kvalitativních proměnných
#    6. Analýza kvantitativních proměnných
#    7. Identifikace a rozhodnutí o vyloučení/ponechání odlehlých pozorování
# 
# 
#  * 1. Jak nainstalovat a spustit rozšiřující balíček funkcí?  ####


# Instalování balíčků nutné pouze jednou (pokud je již nemáte)
# install.packages("readxl")
# install.packages("dplyr")
# install.packages("openxlsx")

# Načtení balíčku (nutno opakovat při každém novém spuštění Rka, vhodné mít na začátku skriptu)
library(readxl)
library(dplyr)
library(openxlsx)
# obsahuje upozornění na přepsané funkce případně na starší verzi balíčku

# * 2. Kde se ukládají generované výstupy, nastavení pracovního adresáře ####


# Výpis pracovního adresáře
getwd()

# Nastavení pracovního adresáře -> do uvozovek, celou cestu (relativní nebo absolutní)
setwd("./data")

getwd() # kde jsme teď

setwd("./..") # zase zpátky

getwd() # kontrola

# * 3. Načtení datového souboru ####


# Základní funkce - read.table, read.csv, read.csv2, ...
# 
# Záleží hlavně na formátu souboru (.txt, .csv), na tzv. oddělovači jednotlivých hodnot,
# desetinné čárce/tečce


# Načtení a uložení datového souboru ve formátu csv2 z pracovního adresáře
data = read.csv2(file="aku.csv")

# Načtení a uložení datového souboru ve formátu csv2 z lokálního disku do datového rámce data
data = read.csv2(file="./data/aku.csv")

# Načtení a uložení datového souboru ve formátu csv2 z internetu do datového rámce data
data = read.csv2(file="http://am-nas.vsb.cz/lit40/DATA/aku.csv")

# Načtení a uložení datového souboru ve formátu xlsx z lokálního disku do datového rámce
# data
# 
# Používáme funkci z balíčku readxl, který jsme v úvodu rozbalili


data = read_excel("./data/aku.xlsx", 
                  sheet = "Data",           # specifikace listu v xlsx souboru
                  skip = 3)                 # řádky, které se přeskočí

head(data)

data = data[,-1] # odstraníme první sloupec s indexy
head(data)

# Přejmenování sloupců - je-li nutné
colnames(data)=c("A5","B5","C5","D5","A100","B100","C100","D100") 

# *** Poznámka (kterou je dobré dočíst až do konce....) ####
# Vždy je možné importovat pomocí "Import Dataset" z okna Environment bez nutnosti psát
# kód
# 
# V tom případě ale nesmí být v "cestě" k souboru žádné speciální znaky (háčky, čárky).
# Jinak se objeví error.
# 
# Objekt importovaný touto cestou bude v novém RStudiu jako typ "tibble".
# 
# Jedná se o modernější "data.frame" a v některých funkcích může dělat problémy a házet
# errory!
# Jednoduše lze tento objekt převést na typ data.frame pomocí **as.data.frame()**
# 
# Pokud budete mít problém, s tím, že nějaká funkce nebude brát sloupec z "tibble"
# jakožto non-numeric output, můžete to napravit příkazem pull: data[,1] nahradit
# pull(data,1)
# 
# * 4. Pre-processing dat ####


# Výpis datového souboru
data

# Zobrazení prvních šesti řádků
head(data)

# Zobrazení posledních šesti řádků
tail(data)

# Zobrazení 10. řádku
data[10,]

# Zobrazení 3. sloupce - několik způsobů
data[,3]

# nebo (víme-li, jak se jmenuje proměnná zapsána ve 3. sloupci)
data$C5

# nebo pomocí funkce select balíčku dplyr, která vybere zvolené sloupce
data %>% select(C5)

# ......................................................................................


# Uložení prvního a pátého sloupce dat. rámce data do dat. rámce pokus
pokus = data[,c(1,5)]

# nebo pomocí funkce z dplyr
pokus = data %>% select(1,5)

# nebo pomocí názvů
pokus = data %>% select(A5,A100)

# ......................................................................................


# Vyloučení prvního a pátého sloupce z dat. rámce data a uložení do dat. rámce pokus
pokus = data[,-c(1,5)]

# nebo pomocí dplyr
pokus = data %>% select(-1, -5)

# nebo pomocí názvů
pokus = data %>% select(-A5,-A100)

# ......................................................................................
# Úprava dat do několika menších logických celků s různou strukturou
# 
# Pozn. při ukládání dat mysleme na přehlednost v názvech


data5 = data[,1:4] # z dat vybereme ty sloupce, které odpovídají měřením po 5 cyklech
colnames(data5) = c("A","B","C","D") # přejmenujeme sloupce
data5S = stack(data5)         # a převedeme do st. datového formátu 
colnames(data5S) = c("kap5","vyrobce") # a ještě jednou upravíme názvy sloupců

# Prozkoumejte strukturu data5 a data5S




# ......................................................................................


# Totéž provedeme pro měření provedené po 100 cyklech
data100 = data[,5:8] # z dat vybereme ty sloupce, které odpovídají měřením po 100 cyklech
colnames(data100) = c("A","B","C","D") # přejmenujeme sloupce
data100S = stack(data100)         # a převedeme do st. datového formátu 
colnames(data100S) = c("kap100","vyrobce") # a ještě jednou upravíme názvy sloupců

# ......................................................................................


# Nakonec si ještě vytvoříme datový soubor ve st. datovém formátu se všemi údaji
dataS = cbind(data5S,data100S) # sloučení "podle sloupců"
dataS = dataS[,-2] # vynecháme nadbytečný druhý sloupec
dataS = na.omit(dataS) # vynecháme řádky s NA hodnotami

# **!!! S funkci na.omit zacházejte extrémně opatrně, aby jste nechtěně nepřišli o data
# !!!**


# ......................................................................................


# Definování nové proměnné pokles
dataS$pokles=dataS$kap5-dataS$kap100

# nebo pomocí funkce z balíčku dplyr
dataS = dataS %>% mutate(pokles=kap5-kap100)

# ......................................................................................


# Může se hodit - vytvoření samostatných proměnných
a5 = dataS$kap5[dataS$vyrobce=="A"] # Třída (typ) numeric
a5

# takto s výsledkem typu data frame
a5.df = dataS %>%
  filter(vyrobce=="A") %>%  # Vybere / vyfiltruje řádky odpovídající výrobci A
  select(kap5)   # Vybere pouze hodnoty ve sloupci kap5, POZOR! - Třída (typ) data.frame
head(a5.df)

# Ostatní samostatné proměnné (uveden pouze jeden způsob)
b5=dataS$kap5[dataS$vyrobce=="B"]
c5=dataS$kap5[dataS$vyrobce=="C"]
d5=dataS$kap5[dataS$vyrobce=="D"]

a100=dataS$kap100[dataS$vyrobce=="A"]
b100=dataS$kap100[dataS$vyrobce=="B"]
c100=dataS$kap100[dataS$vyrobce=="C"]
d100=dataS$kap100[dataS$vyrobce=="D"]

pokles.a=dataS$pokles[dataS$vyrobce=="A"]
pokles.b=dataS$pokles[dataS$vyrobce=="B"]
pokles.c=dataS$pokles[dataS$vyrobce=="C"]
pokles.d=dataS$pokles[dataS$vyrobce=="D"]

# ** Podrobnější okénko do funkcí knihovny dplyr ####


# Je nutné aplikovat na data ve st. datovém formátu !!!
# 
# Operátor pipe %>% - pomáhá při řetězení funkcí - v novém RStudiu klávesová zkratka
# Ctrl+Shift+M
# ......................................................................................


# filter - vybere / vyfiltruje řádky na základě daných podmínek
# Výběr výrobků od výrobce A
dataS %>% 
  filter(vyrobce=="A")

# Výběr výrobků od výrobce A nebo B
dataS %>% 
  filter(vyrobce=="A" | vyrobce=="B")  # | oddělující podmínky odpovídá logickému "nebo"

# Výběr všech výrobků s poklesem o 200 mAh a větším od výrobce C
dataS %>% 
  filter(pokles>=200, vyrobce=="C")  # čárka oddělující podmínky odpovídá logickému "a zároveň"

# ......................................................................................


# select - vybere sloupce podle jejich názvu nebo čísla
# Výběr sloupce s údaji o výrobci podle názvu sloupce
dataS %>% 
  select(vyrobce)

# Výběr sloupce s údaji o výrobci podle čísla sloupce
dataS %>% 
  select(3)

# Co je bezpečnější/lepší?


# ......................................................................................


# mutate - přidá novou proměnnou nebo transformuje existující
# Vytvoření nového sloupce pokles_Ah, který údává pokles kapacit v Ah (původní data v mAh, 1 Ah = 1000 mAh)
dataS %>% 
  mutate(pokles_Ah=pokles/1000)

# ......................................................................................
# 
# *** summarise - generuje souhrnné charakteristiky různých proměnných ####


# Výpočet průměru a mediánu všech hodnot proměnné kap5
dataS %>% 
  summarise(prum=mean(kap5),median=median(kap5))

# ......................................................................................
# 
# *** arrange - seřadí řádky podle zvolené proměnné ####


# Vzestupné a sestupné seřazení řádků podle hodnoty poklesu
dataS %>%
  arrange(pokles)

dataS %>%
  arrange(desc(pokles))

# ......................................................................................
# 
# *** group_by - seskupí hodnoty do skupin podle zvolené proměnné - samotné v podstatě ####
# "k ničemu"


dataS %>%
  group_by(vyrobce)

# Ideální pro spočítání sumárních charakteristik pro každého výrobce zvlášť, např. průměru
dataS %>%
  group_by(vyrobce) %>% 
  summarise(prum=mean(kap5))

# ......................................................................................
# 
# Otestujte své znalosti dplyr
#  1. Určete minimální a maximální hodnotu poklesu kapacit pro jednotlivé výrobce
#   1. Vytvořte nový sloupec pokles_rel, který bude určovat relativní pokles kapacity (v
# %) vzhledem ke stavu po 5 cyklech.
#   2. Poté vytvořte nový sloupec pokles_rel_dich, který bude obsahovat hodnotu "vetsi",
# bude-li relativní pokles nad 10% a "mensi", bude-li relativní pokles menší nebo roven
# 10 %
# 
# Řešení naleznete na úplném konci skriptu.




# ......................................................................................
# 
# **Závěrečná poznámka k dplyr (kterou je dobré dočíst až do konce...)
# Některé operace mohou vyhodit objekt typu "tibble".
# Jedná se o modernější data.frame, nicméně v některých funkcích může dělat problémy a
# způsobovat chybová hlášení!
# Jednoduše lze tento "tibble" objekt převést na typ data.frame pomocí
# as.data.frame().**


# ** Poznámky ke grafice v R ####


#  základem jsou tzv. high-level funkce, které vytvoří graf (tj. otevřou grafické oknou
# a vykreslí dle zadaných parametrů)
#  na ně navazují tzv. low-level funkce, které něco do aktviního grafického okna
# přidají, samy o sobě neotevřou nové
#  př. low-level funkcí - např. abline, points, lines, legend, title, axis ... které
# přidají přímku, body, legendu...
#  tzn. před použitím "low-level" funkce je potřeba, volat "high-level" funkci (např.
# plot, boxplot, hist, barplot, pie,...)
# 
#  Další grafické parametry naleznete v nápovědě
#  nebo např. zde http://www.statmethods.net/advgraphs/parameters.html
#  nebo zde https://flowingdata.com/2015/03/17/r-cheat-sheet-for-graphical-parameters/
#  nebo http://bcb.dfci.harvard.edu/~aedin/courses/BiocDec2011/2.Plotting.pdf
# 
#  Barvy v R
#  http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
#  https://www.nceas.ucsb.edu/~frazier/RSpatialGuides/colorPaletteCheatsheet.pdf
# 
#  Ukládání grafů lze např. pomocí funkce dev.print, jpeg, pdf a dalších.
#  Jednodušeji pak v okně Plots -> Export


# * 5. Explorační analýza a vizualizace kategoriální proměnné ####


# Tabulka absolutních četností kategoriální proměnné výrobce...
cetnosti=table(dataS$vyrobce)
cetnosti #výpis - objekt typu "table" - většinou vhodnější, ale těžší převedení do typu data.frame

#...a pomocí funkcí z dplyr (složitější)
abs.cetnosti = dataS %>%
                  group_by(vyrobce) %>%
                  summarise(cetnost = n())  # počet výrobků pro každého výrobce

abs.cetnosti #výpis - objekt typu "tibble" - hodí se, když potřebujeme jednoduše převést na typ data.frame

# ......................................................................................
# 
# *** Tabulka relativních četností ####


# Přímým výpočtem
rel.cetnosti=100*cetnosti/sum(cetnosti)   
rel.cetnosti # výpis

# nebo pomocí funkce prop.table
rel.cetnosti2=prop.table(cetnosti)*100
rel.cetnosti2 # výpis

# nebo pomocí funkcí dplyr, kde budou zahrnuty i absolutní četnosti
tabulka_abs_rel = dataS %>%
                    group_by(vyrobce) %>%
                    summarise(cetnost = n()) %>%   
                    mutate(rel_cet_proc = round(100*(cetnost / sum(cetnost) ),1) )
tabulka_abs_rel # výpis

# U všech tabulek je potřeba pohlídat zaokrouhlení a s ním spojené riziko zaokrouhlovací chyby.
# Postup pro rel.cetnosti a rel.cetnosti2 je stejný.
rel.cetnosti=round(rel.cetnosti,digits=1) # zaokrouhlení na 1 desetinné místo
rel.cetnosti[4]=100-sum(rel.cetnosti[1:3]) # ohlídání zaokrouhlovací chyby

# Postup pro tabulka_abs_rel je jiný, a to kvůli jinému formátu (tibble)
tabulka_abs_rel[4,3]=100-sum((tabulka_abs_rel[1:3,3]))

# *** Vytvoření tabulky s absolutními i rel. četnostmi (bez dplyr). Máme: ####


cetnosti

rel.cetnosti

tabulka=cbind(cetnosti,rel.cetnosti)  # sloučení tabulek
colnames(tabulka)=c("četnost","rel.četnost (%)") # změna názvů sloupců
tabulka

# *** Uložení tabulky do csv souboru pro export do MS Excel ####


write.csv2(tabulka,file="tabulka.csv")

# Kde je tabulka uložena? Bez uvedení kompletní cesty v předchozím příkazu je uložena v pracovním adresáři.
getwd()

# ......................................................................................
# 
# ** Vizualizace pomocí grafů ####


# Sloupcový graf
# Základní (tzn. nevyžadující žádný balíček) sloupcový graf vychází z tabulky četností, kterou máme nachystanou
par(mfrow = c(1,1), # jednoduché rozdělení grafického okna - 1 řádek, 1 sloupec
    mar = c(2,2,2,2), # okraje kolem každého z grafů v počtech řádků - - c(dole, vlevo, nahoře, vpravo)
    oma = c(2,2,2,2)) # vnější okraje v počtech řádků - c(dole, vlevo, nahoře, vpravo)
barplot(cetnosti)

# Změna barev, přidání názvu
barplot(cetnosti,
        col=heat.colors(4), # alt. může být volen vektor konkrétních barev, např. c("blue","yellow,"red","green") 
        # nebo jiné škály (heat.colors, topo.colors, terrain.colors a mnoho dalších)
        main="Zastoupení výrobců ve výběru",
        space=0.6) # parametr space vytvoří mezeru mezi sloupci

# Přidání dalších popisků a legendy
barplot(cetnosti,
        col=heat.colors(4),
        horiz=TRUE,                            # horizontální orientace grafu
        border=FALSE,                   # nevykresluje čáru kolem sloupečků
        main="Zastoupení výrobců ve výběru",
        names.arg=paste0("Výrobce \n",names(cetnosti))) 
# Funkce paste0 umožňuje sloučit textové řetězce a hodnoty proměnných, symbol "\n" tvoří nový řádek v textu
legend("right",                             # umístění legendy u sloupcového grafu je velmi ošemetné
       paste("Výrobce",names(cetnosti)),       # mnohem snadněji se v tomto případě pracuje s ggplot2
       col=heat.colors(4),
       fill=heat.colors(4),
       border=TRUE,
       bty="n")

# Přidání absolutních a relativních četností k odpovídajícím sloupcům
bp = barplot(cetnosti,
             col=heat.colors(4),
             main="Zastoupení výrobců ve výběru",
             names.arg=paste("Výrobce",names(cetnosti)))
text(bp,
     cetnosti,paste0(cetnosti,"; ",rel.cetnosti,"%"),
     pos=1)
# parametr pos udává, kde bude text uveden vzhledem k dané pozici (1 = pod, 2 = vlevo, 3 = nad, 4 = vpravo) 

# Zkuste využít předešlého kódu a vytvořit si sloupcový graf pro proměnnou Výrobce podle
# sebe.
# 
# ......................................................................................
# 
# *** Koláčový graf ####


# Základní koláčový graf vychází z tabulky četností, kterou máme nachystanou
cetnosti
pie(cetnosti)

# Přidání názvu grafu a popisků, úprava barev
pie(cetnosti,
    col=topo.colors(4), 
    main="Zastoupení výrobců ve výběru", # název grafu
    labels=c("Výrobce A","Výrobce B","Výrobce C","Výrobce D")) # popisky

# Pokročilejší popisky - sloučení abs. četností a rel. četností pomocí funkce paste
# Funkce paste umožňuje sloučit textové řetězce a hodnoty proměnných, symbol "\n" tvoří nový řádek v textu
pie(cetnosti,
    col=heat.colors(4),
    main="Zastoupení výrobců ve výběru",
    labels=paste0("Výrobce ",names(cetnosti),"\n",cetnosti,"; ",rel.cetnosti,"%"))

# Pro zájemce - balíček plotrix a funkce pie3D vytvoří 3D koláčový graf
# 
# Zkuste využít předešlého kódu a vytvořit koláčový graf pro proměnnou Výrobce podle
# sebe.


#  **Pie charts are a very bad way of displaying information.
#  The eye is good at judging linear measures and bad at judging relative areas.
#  A bar chart or dot chart is a preferable way of displaying this type of data.**


# * 6. Explorační analýza a vizualizace kvantitativní proměnné ####


# Popisná statistika
summary(dataS$kap5)

# Výpočet průměru jedné proměnné
mean(dataS$kap5)

mean(a5)

# Pozor na chybějící hodnoty
mean(data$C5)

mean(data$C5,na.rm=TRUE)

# Výpočet mediánu jedné proměnné
quantile(dataS$kap5,probs=0.5)

quantile(a5,probs=0.5)

# Určení rozsahu
length(dataS$kap5)

# *** Další charakteristiky -> var(), sd(), min(), max(),... ####
# 
# Pozor! Funkce pro výpočet šikmosti (skewness) a špičatosti (kurtosis) nejsou součástí
# základního R, najdete je v balíčku moments
# 
# Normálnímu rozdělení odpovídá špičatost 3, resp. špčatost v intervalu (1,5)
# 
# Pro standardizaci špičatosti je nutno od vypočtené hodnoty odečíst 3.
# 
# Napíšete-li před název funkce název balíčku a "::", zajistíte tím, že bude použita
# funkce z daného balíčku
# 
# Nutno ohlídat, když jsou v různých balíčcích definovány různé funkce pod stejným
# jménem


# install.packages("moments")

library(moments)

moments::skewness(a5)

moments::kurtosis(a5)-3

# Chceme-li spočítat danou charakteristiku pro proměnnou kapacita po 5 cyklech podle výrobců, můžeme použít funkci tapply
tapply(dataS$kap5, dataS$vyrobce, mean, na.rm=T)

# nebo pomocí dplyr - zde pozor na automatické (ne vždy správné zaokrouhlení)
dataS %>% 
  group_by(vyrobce) %>% 
  summarise(mean(kap5,na.rm=T))

# Pro zjednodušení práce můžeme využít funkce dplyr a všechny charakteristiky si nasázet do jedné tabulky
dataS %>%    # bez použití group_by pro celou proměnnou kap5
  summarise(rozsah=length(kap5),
            minimum=min(kap5,na.rm=T),     # preventivní na.rm=T
            Q1=quantile(kap5,0.25,na.rm=T),
            prumer=mean(kap5,na.rm=T),
            median=median(kap5,na.rm=T),
            Q3=quantile(kap5,0.75,na.rm=T),
            maximum=max(kap5,na.rm=T),
            rozptyl=var(kap5,na.rm=T),
            smerodatna_odchylka=sd(kap5,na.rm=T),
            variacni_koeficient=(100*(smerodatna_odchylka/prumer)),  # variační koeficient v procentech
            sikmost=(moments::skewness(kap5,na.rm=T)),       # preventivní specifikace balíčku moments
            spicatost=(moments::kurtosis(kap5,na.rm=T)-3)) 

# Nezapoměňte na správné zaokrouhlení!
# Použijeme group_by a dostaneme charakteristiky pro kapacitu po 5 cyklech podle výrobců
# Vzhledem k neúplnému výpisu je vhodné si výstup uložit a prohlédnout si jej v novém okně
charakteristiky_dle_vyrobce = 
  dataS %>%
    group_by(vyrobce) %>% 
    summarise(rozsah=length(kap5),
            minimum=min(kap5,na.rm=T),
            Q1=quantile(kap5,0.25,na.rm=T),
            prumer=mean(kap5,na.rm=T),
            median=median(kap5,na.rm=T),
            Q3=quantile(kap5,0.75,na.rm=T),
            maximum=max(kap5,na.rm=T),
            rozptyl=var(kap5,na.rm=T),
            smerodatna_odchylka=sd(kap5,na.rm=T),
            variacni_koeficient=(100*(smerodatna_odchylka/prumer)),  # variační koeficient v procentech
            sikmost=(moments::skewness(kap5,na.rm=T)),
            spicatost=(moments::kurtosis(kap5,na.rm=T)-3))

charakteristiky_dle_vyrobce

# ......................................................................................
# 
# ** Krabicový graf ####


# Jednoduché a rychlé vykreslení pomocí základní funkce pouze pro výrobce C
boxplot(c5)

# Další úprava grafu, využití funkce points pro zobrazení průměru
boxplot(c5,
        main="Kapacita po 5 cyklech (mAh)", 
        xlab="Výrobce C",
        ylab="kapacita (mAh)",
        col="grey")
points(1, mean(c5,na.rm=TRUE), pch=3) # do stávajícího grafu doplní bod znázorňující průměr

# Horizontální orientace, změna šířky krabice
boxplot(c5,
        main="Kapacita po 5 cyklech (mAh), výrobce C", 
        horizontal=TRUE,  # při horizontální orientaci je třeba si ohlídat opačné nastavení popisků
        xlab="kapacita (mAh)",
        boxwex=0.5)  # změní šířku krabice na 1/2

# Využijte předešlého kódu a vytvořte si krabicový graf podle sebe.




# A ještě vykreslení vícenásobného krabicového grafu
boxplot(dataS$kap5~dataS$vyrobce) # grafické parametry lze nastavit obdobně jako u předchozích

boxplot(a5,b5,c5,d5)

# ......................................................................................
# 
# *** Histogram ####


# Jednoduché a rychlé vykreslení
hist(a5)

hist(a5,breaks=10) # Co dělají různé hodnoty parametru breaks s grafem?

hist(a5,breaks=10) # Co dělají různé hodnoty parametru breaks s grafem?

# Již tradičně lze nastavit popisky, barvy a další parametry
hist(a5, 
     main="Histogram pro kapacitu akumulátorů po 5 cyklech, výrobce A", 
     xlab="kapacita (mAh)",
     ylab="četnost",
     col="blue",       # barva výplně
     border="grey",    # barva ohraničení sloupců
     labels=TRUE)         # přidá absolutní četnosti daných kategorií ve formě popisků

# Změna měřítka osy y, kvůli vykreslení odhadu hustoty pravděpodobnosti
hist(a5, 
     main="Histogram pro kapacitu akumulátorů po 5 cyklech, výrobce A", 
     xlab="kapacita (mAh)",
     ylab="f(x)",
     col="cadetblue1", 
     border="grey",
     freq=FALSE)	       # změna měřítka na ose y --> f(x)
lines(density(a5))        # připojí graf odhadu hustoty pravděpodobnosti
# Generování hustoty normálního rozdělení a přidání k histogramu
xfit=seq(min(a5), max(a5), length=40)     # generování hodnot pro osu x
yfit=dnorm(xfit, mean=mean(a5), sd=sd(a5))  # generování hodnot pro osu y
lines(xfit, yfit, col="black", lwd=2)    # do posledního grafu přidání křivky na základě výše vygenerovaných hodnot
# Takto kombinovaný graf může posloužit k vizuálnímu posouzení normality.

# **Využijte předešlého kódu a vytvořte si histogram podle sebe.**




# *** QQ-graf ####


# Jednoduché a velmi rychlé vykreslení...
qqnorm(a5)
qqline(a5)

# ... s úpravou popisků os...
qqnorm(a5, 
       xlab="Teoretické kvantily",
       ylab="Výběrové kvantily",
       main="QQ-graf, kapacita po 5 cyklech, výrobce A")
qqline(a5)



# ......................................................................................
# 
# Pro pokročilé a zájemce - automatizace, využití for-cyklu, více grafů do jednoho
# obrázku
# 
# Využíváme-li základní funkce (barplot, boxplot, histogram), pak se využívá funkce
# par() nebo layout()
# 
# V těchto funkcích specifikujeme strukturu - jak chceme více obrázků vykreslit


# Např. chceme vykreslit histogram i boxplot pro kapacitu po 5 cyklech akumulátorů od výrobce A
pom=layout(mat = matrix(1:2,2,1, byrow=FALSE), height = c(2.5,1)) # vytvoření struktury
par(oma=c(2,2,3,2),mar=c(2,2,3,2)) # nastavení velikosti okrajů

hist(a5, 
     main="Výrobce A",
     xlab="kapacita (mAh) po 5 cyklech", 
     ylab="četnost", 
     ylim=c(0,32), 
     xlim=c(1730,2040))
boxplot(a5, 
        horizontal=TRUE, 
        ylim=c(1700,2040), 
        boxwex=1.5)

# Pomocí for-cyklu histogramy a boxploty pro všechny výrobce
pom=layout(mat = matrix(1:8,2,4, byrow=FALSE), height = c(1.5,1))

for (i in 1:4){
  hist(pull(data5,i), 
       main=paste("Výrobce",colnames(data5)[i]), 
       xlab="", 
       ylab="četnost", 
       xlim=c(min(data5,na.rm=TRUE), max(data5,na.rm=TRUE)), 
       ylim=c(0,32))
  boxplot(pull(data5,i), 
          horizontal=TRUE, 
          ylim=c(min(data5,na.rm=TRUE), max(data5,na.rm=TRUE)), 
          xlab="kapacita (mAh) po 5 cyklech",
          boxwex=1.5)
}
mtext("Kapacita akumulátorů (mAh) po 5 cyklech dle výrobců", cex = 1.1, outer=TRUE, side=3)

# Kombinace histogramu a QQ-plotu
pom=layout(mat = matrix(1:8,2,4, byrow=FALSE), height = c(2,1.5))
par(oma=c(2,2,3,2), mar=c(2,2,3,2))

for (i in 1:4){
  hist(pull(data5,i), 
       main=paste("Výrobce",colnames(data5)[i]), 
       xlab="kapacita (mAh) po 5 cyklech", 
       ylab="četnost", 
       xlim=c(min(data5,na.rm=TRUE), max(data5,na.rm=TRUE)), 
       ylim=c(0,0.037),
       freq=FALSE)
  lines(density(pull(data5,i), na.rm=TRUE))
  xfit=seq(min(pull(data5,i), na.rm=TRUE), max(pull(data5,i), na.rm=TRUE), length=40) 
  yfit=dnorm(xfit, mean=mean(pull(data5,i), na.rm=TRUE), sd=sd(pull(data5,i), na.rm=TRUE)) 
  lines(xfit, yfit, col="blue", lty=2)
  qqnorm(pull(data5,i),main = "")
  qqline(pull(data5,i))
}
mtext("Kapacita akumulátorů po 5 cyklech (mAh)", cex = 1.5, outer=TRUE, side=3)

# * 7. Identifikace odlehlých pozorování (a jejich odstranění z dat. rámce) ####


# Zcela individuální posouzení - jednoduše si data seřadíme a podíváme se na "chvosty"
# Při větším počtu dat velmi nepraktické, ale při menším rozsahu se může hodit.
dataS %>%
  filter(vyrobce=="A") %>% 
  arrange(vyrobce,kap5)

# ......................................................................................


# Ruční odstranění - využití funkce boxplot s parametrem plot=F - s ohledem na výrobce
pom = boxplot(data5S$kap5~data5S$vyrobce, plot = F)
pom   # v pom$out jsou uložena odlehlá pozorování detekována metodou vnitřních hradeb,
      # v pom$group je info, ze které skupiny odlehlá pozorování jsou

# Tyto konkrétní hodnoty jsou pak označeny v novém sloupci kap5_out jako NA
dataS$kap5_out=dataS$kap5
dataS$kap5_out[dataS$vyrobce == "A" & dataS$kap5>=2023] = NA
dataS$kap5_out[dataS$vyrobce == "C" & dataS$kap5==1848.4] = NA
dataS$kap5_out[dataS$vyrobce == "D" & dataS$kap5==1650.3] = NA

# ......................................................................................


#..................................................................
# Použití vnitřních hradeb - obecnější postup - uvedeno bez ohledu na výrobce!!!
IQR = quantile(dataS$kap5,0.75,na.rm=T)-quantile(dataS$kap5,0.25,na.rm=T)  # mezikvartilové rozpěti
dolni_mez = quantile(dataS$kap5,0.25,na.rm=T)-1.5*IQR  # výpočet dolní mezi vnitřních hradeb
horni_mez = quantile(dataS$kap5,0.75,na.rm=T)+1.5*IQR  # výpočet horní mezi vnitřních hradeb

# Pomocí funkce mutate definování nového sloupce, ve kterém budou odlehlá pozorování odstraněna
dataS = dataS %>%
  mutate(kap5_out=ifelse(kap5>=horni_mez | kap5<=dolni_mez, NA, kap5))

# nebo bez použití funkcí dplyr
dataS$kap5_out=dataS$kap5
dataS$kap5_out[dataS$kap5>=horni_mez | dataS$kap5<=dolni_mez]=NA

# **Analytik může vždy říct, že odlehlá pozorování odstraňovat nebude, ale tuto
# informaci musí do zápisu o analýze uvést!**


# * Otestujte své znalosti dplyr - řešení ####


# 1. Určete minimální a maximální hodnotu poklesu kapacit pro jednotlivé výrobce
dataS %>% 
  group_by(vyrobce) %>% 
  summarise(minima=min(pokles),maxima=max(pokles))

# 2a. Vytvořte nový sloupec pokles_rel, který bude udávat relativní pokles kapacity (v
# %) vzhledem ke stavu po 5 cyklech
# 
# 2b. Poté vytvořte nový sloupec pokles_rel_dich, který bude obsahovat hodnotu "vetsi",
# bude-li relativní pokles nad 10% a "mensi", bude-li relativní pokles menší nebo roven
# 10%


dataS %>% 
  mutate(pokles_rel=100*pokles/kap5)

dataS %>% 
  mutate(pokles_rel=100*pokles/kap5) %>% 
  mutate(pokles_rel_dich=ifelse(pokles_rel>10,"vetsi","mensi"))



