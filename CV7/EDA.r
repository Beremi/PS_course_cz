# ......................................................................................
# .................. Cvičení 7. Preprocesing dat a explorační analýza ..................
# .................. Adéla Vrtková, Martina Litschmannová, Michal Béreš.................
# ......................................................................................

# Nezobrazuje-li se vám text korektně, nastavte File \ Reopen with Encoding... na UTF-8
# Pro zobrazení obsahu skriptu použijte CTRL+SHIFT+O
# Pro spouštění příkazů v jednotlivých řádcích použijte CTRL+ENTER

#   1. Rozšiřující balíčky funkcí - instalace a načítání ####


# Instalování balíčků nutné pouze jednou (pokud je již nemáte)
# install.packages("readxl")
# install.packages("dplyr")
# install.packages("openxlsx")

# Načtení balíčku (nutno opakovat při každém novém spuštění Rka, vhodné mít na začátku skriptu)
library(readxl)
library(dplyr)
library(openxlsx)
# obsahuje upozornění na přepsané funkce případně na starší verzi balíčku

#  2. Pracovního adresář (working directory) - odkud načítáme a kam ukládáme data ####
# - Pozor aktuální otebvřená složka v Rstudiu, případně umístění Rskriptu není
# automaticky pracovní adresář


# Výpis pracovního adresáře
getwd()

# Nastavení pracovního adresáře -> do uvozovek, celou cestu (relativní nebo absolutní)
setwd("./data")

getwd() # kde jsme teď

setwd("./..") # zase zpátky

getwd() # kontrola

#  3. Načtení datového souboru ####


# * Ze souboru CSV ####
# Základní funkce - read.table, read.csv, read.csv2, ...
# 
# Záleží hlavně na formátu souboru (.txt, .csv), na tzv. oddělovači jednotlivých hodnot,
# desetinné čárce/tečce


# Načtení a uložení datového souboru ve formátu csv2 z pracovního adresáře
data = read.csv2(file="aku.csv")

data

data = read.csv2(file="aku.csv", sep=";", quote="", skip=0, header=TRUE)
data

#help(read.csv2)

# Načtení a uložení datového souboru ve formátu csv2 z lokálního disku do datového rámce data
data = read.csv2(file="./data/aku.csv")

# Načtení a uložení datového souboru ve formátu csv2 z internetu do datového rámce data
data = read.csv2(file="http://am-nas.vsb.cz/lit40/DATA/aku.csv")

# * Z Excelu (souboru xlsx) ####
# Načtení a uložení datového souboru ve formátu xlsx z lokálního disku do datového rámce
# data
# 
# Používáme funkci z balíčku readxl, který jsme v úvodu rozbalili


data = read_excel("./data/aku.xlsx", 
                  sheet = "Data",           # specifikace listu v xlsx souboru
                  skip = 3)                 # řádky, které se přeskočí

head(data)

# * Odstranění nepotřebných řádků/sloupců a pojmenování řádků/sloupců pro snadnější ####
# adresování dat


# indexování se zápornými indexy vrátí vše kromě hodnoty indexů
# nemíchat záporné a kladné indexy!
data = data[,-1] # odstraníme první sloupec s indexy
head(data)

# Přejmenování sloupců - je-li nutné
colnames(data)=c("A5","B5","C5","D5","A100","B100","C100","D100") 
head(data)

# *** Poznámka (kterou je dobré dočíst až do konce....) ####
# (v Rstudiu) je možné importovat pomocí "Import Dataset" z okna Environment bez
# nutnosti psát kód
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


#  4. Pre-processing dat + knihovna Dplyr ####
# ** Přehled funkcí knihovny Dplyr ####
# - **%>%** je takzvaný pipe operátor, typické využití je "res = data %>% operace", kde
# výsledkem je operace opalikovaná na data
# - **select(...)** je jednou z operací kterou můžeme vložit do "pipe" operátoru -
# slouží k výběru dat
#  - select(1) - vybere první sloupec
#  - select(A5) - vybere sloupec se jménem A5
#  - select(1,3,5) - vybere sloupce 1,3,5
# - **mutate(novy_sloupec=...)** je operace, které vyrobí v datovém rámci nový datový
# sloupec pomocí zadaného výpočtu nad aktuálními sloupci
#  - data %>% mutate(C=A-B) vyrobí v datovém rámci "data" nový sloupec s názvem "C" jako
# rozdíl hodnot ve stávajícím sloupci "A" a "B"
# - **filter(...)** vyfiltruje z dat hodnoty splňující zadané požadavky
#  - data %>% filter(vyrobce=="A" | vyrobce=="B") vrátí datový soubor, který má ve
# sloupci "vyrobce" pouze hodnoty "A" nebo "B"
#  - data %>% filter(vyrobce=="A", hodnoty>1000) pokud požadavky píšeme za sebou
# (oddělené čárkou) chápeme to jako a zároveň
# - **summarise(...)** vypočte předepsanéčíslené charakteristiky v rámci zadaných
# sloupců (vhodné pro kombinaci s group.by)
#  - data %>% summarise(prum=mean(kap5),median=median(kap5)) 
# - **arrange(...)** vzestupné, případně sestupné seřazení řádků
#  - data %>% arrange(pokles) vzestupně
#  - data %>% arrange(desc(pokles)) sestupně
# - **group_by(...)** seskupení dat dle unikátních hodnot v zadaném sloupci
#  - data %>% group_by(vyrobce)
#  
# Velice užitečný Dplyr "cheat sheet" naleznete zde:
# https://github.com/rstudio/cheatsheets/raw/master/data-transformation.pdf


# ** Výběry sloupců/řádků ####


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
head(pokus)

# nebo pomocí funkce z dplyr
pokus = data %>% select(1,5)
head(pokus)

# nebo pomocí názvů
naz_sl = "A100"
pokus = data %>% select(A5, naz_sl)
head(pokus)

# ......................................................................................
# 
# Vylučování dat ze souboru.


# Vyloučení prvního a pátého sloupce z dat. rámce data a uložení do dat. rámce pokus
pokus = data[,-c(1,5)]
head(pokus)

# nebo pomocí dplyr
pokus = data %>% select(-1, -5)
head(pokus)

# nebo pomocí názvů
pokus = data %>% select(-A5,-A100)
head(pokus)

# ......................................................................................
# Úprava dat do několika menších logických celků s různou strukturou
# 
# Pozn. při ukládání dat mysleme na přehlednost v názvech
# ** Základní převod jednoduché datové matice do standardního datového formátu  ####-
# stack(...)


data5 = data[,1:4] # z dat vybereme ty sloupce, které odpovídají měřením po 5 cyklech
colnames(data5) = c("A","B","C","D") # přejmenujeme sloupce
head(data5)

data5S = stack(data5)         # a převedeme do st. datového formátu 
colnames(data5S) = c("kap5","vyrobce") # a ještě jednou upravíme názvy sloupců
head(data5S)

# Totéž provedeme pro měření provedené po 100 cyklech
data100 = data[,5:8] # z dat vybereme ty sloupce, které odpovídají měřením po 100 cyklech
colnames(data100) = c("A","B","C","D") # přejmenujeme sloupce
data100S = stack(data100)         # a převedeme do st. datového formátu 
colnames(data100S) = c("kap100","vyrobce") # a ještě jednou upravíme názvy sloupců

# Nakonec si ještě vytvoříme datový soubor ve st. datovém formátu se všemi údaji
dataS = cbind(data5S,data100S) # sloučení "podle sloupců"
head(dataS)

dataS = dataS[,-2] # vynecháme nadbytečný druhý sloupec
dataS = na.omit(dataS) # vynecháme řádky s NA hodnotami
head(dataS)

# **!!! S funkci na.omit zacházejte extrémně opatrně, aby jste nechtěně nepřišli o data
# !!!**


# ......................................................................................
# 
# ** Definování nových sloupců v datovém rámci ####


# Definování nové proměnné pokles
dataS$pokles = dataS$kap5 - dataS$kap100

head(dataS)

# nebo pomocí funkce z balíčku dplyr
dataS = dataS %>% mutate(pokles=kap5-kap100)

# ** Vybírání dat ze standardního datového formátu ####


dataS$kap5

# Může se hodit - vytvoření samostatných proměnných
a5 = dataS$kap5[dataS$vyrobce=="A"] # Třída (typ) numeric
a5

# takto s výsledkem typu data frame
a5.df = dataS %>%
  filter(vyrobce=="A") %>%  # vyfiltruje řádky odpovídající výrobci A
  select(kap5)   # Vybere pouze hodnoty ve sloupci kap5,
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

# ** Podrobnější okénko do funkcí knihovny Dplyr - práce nad daty ve standardním ####
# datovém formátu


# Je nutné aplikovat na data ve st. datovém formátu !!!
# 
# Operátor pipe %>% - pomáhá při řetězení funkcí - v novém RStudiu klávesová zkratka
# Ctrl+Shift+M
# 
# *** filter - aplikuje filtr na daný sloupec ####


# filter - vybere / vyfiltruje řádky na základě daných podmínek
# Výběr výrobků od výrobce A
dataS %>% filter(vyrobce=="A")

# Výběr výrobků od výrobce A nebo B
# | oddělující podmínky odpovídá logickému "nebo"
dataS %>% filter(vyrobce=="A" | vyrobce=="B")  

# Výběr všech výrobků s poklesem o 200 mAh a větším od výrobce C
# čárka oddělující podmínky odpovídá logickému "a zároveň"
dataS %>% filter(pokles>=200, vyrobce=="C")  

# *** mutate - vyrobí nový sloupec ####


# mutate - přidá novou proměnnou nebo transformuje existující
# Vytvoření nového sloupce pokles_Ah, který údává pokles kapacit v Ah (původní data v mAh, 1 Ah = 1000 mAh)
pokus = dataS %>% mutate(pokles_Ah=pokles/1000)
head(pokus)
# pozor! pokud výsledek s nový sloupcem nikam neuložíme, tak se pouze vypíše a zmizí

# *** summarise - generuje souhrnné charakteristiky různých proměnných ####


# Výpočet průměru a mediánu všech hodnot proměnné kap5
dataS %>% summarise(prum=mean(kap5),median=median(kap5))

# *** arrange - seřadí řádky podle zvolené proměnné ####


# Vzestupné a sestupné seřazení řádků podle hodnoty poklesu
dataS %>% arrange(pokles)

dataS %>% arrange(desc(pokles))

# *** group_by - seskupí hodnoty do skupin podle zvolené proměnné ####


# tabulka je "virtuálně" rozdělená na skupiny pro pozdější zpracování např. summarise
dataS %>% group_by(vyrobce)

# Ideální pro spočítání sumárních charakteristik pro každého výrobce zvlášť, např. průměru
dataS %>%
  group_by(vyrobce) %>% 
  summarise(prum=mean(kap5), "směrodatná odchylka"=sd(kap5))

# **Závěrečná poznámka k dplyr (kterou je dobré dočíst až do konce...)
# Některé operace mohou vyhodit objekt typu "tibble".
# Jedná se o modernější data.frame, nicméně v některých funkcích může dělat problémy a
# způsobovat chybová hlášení!
# Jednoduše lze tento "tibble" objekt převést na typ data.frame pomocí
# as.data.frame().**


#  5. Převod dat do standardního datového formátu (u dvou nejčastějších formátu dat) ####
# * Z dat ve formátu Datová matice ####


data_DM = read_excel("./data/datova_matice.xlsx")
head(data_DM)

data_DM = data_DM[,-1]
colnames(data_DM) = c("A22", "A5", "B22", "B5", "C22", "C5", "D22", "D5")
head(data_DM)

# ** Funkce reshape ####
# Její parametry:
# - **data** - data k převedení musí být fe formátu data.frame (as.data.frame(data))
# - **direction** - kterým směrem chceme transformaci udělat
#     - "long" - do standardního formátu
#     - "wide" - zpátky do datové matice
# - **varying** - názvy sloupců, které označují stejná data pro různé kategorie
#     - je to list vektorů
#     - každá položka listu je jedno měření
#     - každý vektor je pak seznam sloupců
# - **v.names** - názvy sloupců ve st. dat. formátu
#     - počet názvů musí sedět na počet vektorů v varying
# - **times** - názvy jednotlivých kategorií
#     - POZOR!! musí být ve stejném pořadí jako u proměné varying
# - **timevar** - název sloupce s kategoriemi


data_DM_S=reshape(data=as.data.frame(data_DM),
                  direction="long",
                  varying=list(c("A5", "B5", "C5", "D5"),
                               c("A22","B22","C22","D22")),
                  v.names=c("5 C","22  C"),   
                  times=c("Amber","Bright","Clear","Dim"),  
                  timevar="vyrobce")
head(data_DM_S)

#help(reshape)

# a pokud bychom chtěli, můžeme převést data zpět
data_DM_2=reshape(data=data_DM_S,
                  direction="wide",
                  varying=list(c("A5", "B5", "C5", "D5"),
                               c("A22","B22","C22","D22")),
                  v.names=c("5 C","22  C"),   
                  times=c("Amber","Bright","Clear","Dim"),  
                  timevar="vyrobce")
head(data_DM_2)

# * Z datového souboru, kde jsou kategorie v jednotlivých listech excelu ####


data_A = read_excel("./data/po_listech.xlsx", sheet=1)
head(data_A)
data_B = read_excel("./data/po_listech.xlsx", sheet=2)
data_C = read_excel("./data/po_listech.xlsx", sheet=3)
data_D = read_excel("./data/po_listech.xlsx", sheet=4)

data_A$vyrobce = "Amber"
data_B$vyrobce = "Bright"
data_C$vyrobce = "Clear"
data_D$vyrobce = "Dim"
head(data_A)

data_PL_S = rbind(data_A, data_B, data_C, data_D)
data_PL_S

#  6. Explorační analýza a vizualizace kategoriální proměnné ####
# 
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


# Tabulka absolutních četností kategoriální proměnné výrobce...
cetnosti=table(dataS$vyrobce)
cetnosti #výpis - objekt typu "table" - většinou vhodnější, ale těžší převedení do typu data.frame

#...a pomocí funkcí z dplyr (složitější)
abs.cetnosti = dataS %>%
                  group_by(vyrobce) %>%
                  summarise(cetnost = n())  # počet výrobků pro každého výrobce

abs.cetnosti #výpis - objekt typu "tibble" - hodí se, když potřebujeme jednoduše převést na typ data.frame

# ** Tabulka relativních četností ####


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
t(tabulka_abs_rel)

# U všech tabulek je potřeba pohlídat zaokrouhlení a s ním spojené riziko zaokrouhlovací chyby.
# Postup pro rel.cetnosti a rel.cetnosti2 je stejný.
rel.cetnosti=round(rel.cetnosti,digits=1) # zaokrouhlení na 1 desetinné místo
rel.cetnosti[4]=100-sum(rel.cetnosti[1:3]) # ohlídání zaokrouhlovací chyby
rel.cetnosti

# Postup pro tabulka_abs_rel je jiný, a to kvůli jinému formátu (tibble)
tabulka_abs_rel[4,3]=100-sum((tabulka_abs_rel[1:3,3]))
tabulka_abs_rel

# *** Vytvoření tabulky s absolutními i rel. četnostmi (bez dplyr). Máme: ####


cetnosti

rel.cetnosti

tabulka=cbind(cetnosti,rel.cetnosti)  # sloučení tabulek
colnames(tabulka)=c("četnost","rel.četnost (%)") # změna názvů sloupců
tabulka

# *** Uložení tabulky do csv souboru ####


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


#  7. Explorační analýza a vizualizace kvantitativní proměnné ####


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

skewness(a5)

kurtosis(a5)-3

# Chceme-li spočítat danou charakteristiku pro proměnnou kapacita po 5 cyklech 
# podle výrobců, můžeme použít funkci tapply
tapply(dataS$kap5, dataS$vyrobce, mean, na.rm=TRUE)

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

# ** Krabicový graf ####
# **Vykreslujeme pro originální data, můžeme doplnit i vykreslení pro data bez OP.**


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

# ** Histogram ####
# **Vykreslujeme vždy pro data bez odlehlých pozorování!!**


# Jednoduché a rychlé vykreslení
hist(a5)

hist(a5,breaks=20) # Co dělají různé hodnoty parametru breaks s grafem?

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
     freq=FALSE)          # změna měřítka na ose y --> f(x)
lines(density(a5))        # připojí graf odhadu hustoty pravděpodobnosti
# Generování hustoty normálního rozdělení a přidání k histogramu
xfit=seq(min(a5), max(a5), length=40)     # generování hodnot pro osu x
yfit=dnorm(xfit, mean=mean(a5), sd=sd(a5))  # generování hodnot pro osu y
lines(xfit, yfit, col="black", lwd=2)    # do posledního grafu přidání křivky na základě výše vygenerovaných hodnot
# Takto kombinovaný graf může posloužit k vizuálnímu posouzení normality.

# **Využijte předešlého kódu a vytvořte si histogram podle sebe.**




# ** QQ-graf ####
# **Vykreslujeme vždy pro data bez odlehlých pozorování!!**


# Jednoduché a velmi rychlé vykreslení...
qqnorm(a5)
qqline(a5)

# ... s úpravou popisků os...
qqnorm(a5, 
       xlab="Teoretické kvantily",
       ylab="Výběrové kvantily",
       main="QQ-graf, kapacita po 5 cyklech, výrobce A")
qqline(a5)



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

#  8. Vnitřní hradby a identifikace odlehlých pozorování ####
# * Ruční odstranění pomocí napočítání vnitřních hradeb ####


# separace datového sloupce pro výrobce A
data_A_kap5 = dataS$kap5[dataS$vyrobce == "A"]
data_A_kap5

dolni_kvartil = quantile(data_A_kap5,0.25,na.rm=T)
horni_kvartil = quantile(data_A_kap5,0.75,na.rm=T)
IQR = horni_kvartil - dolni_kvartil  # mezikvartilové rozpěti
dolni_mez = dolni_kvartil - 1.5*IQR  # výpočet dolní mezi vnitřních hradeb
horni_mez = horni_kvartil + 1.5*IQR  # výpočet horní mezi vnitřních hradeb
dolni_mez
horni_mez

data_A_kap5_bezOP = data_A_kap5
# nastavíme hodnoty které jsou mimo meze na NA 
data_A_kap5_bezOP[data_A_kap5>=horni_mez | data_A_kap5<=dolni_mez] = NA
data_A_kap5_bezOP

# můžeme hondoty NA smazat
data_A_kap5_bezOP = na.omit(data_A_kap5_bezOP)

# * Automatické odstranění dle box-plotu ####


pom = boxplot(data_A_kap5)

pom

data_A_kap5_bezOP = data_A_kap5
data_A_kap5_bezOP[data_A_kap5 %in% pom$out] = NA
data_A_kap5_bezOP

# ** Jak to udělat pro data ve standardním formátu s více kategoriemi? ####


head(data5S)

data5S$id = 1:length(data5S$kap5)
head(data5S)

boxplot(data5S$kap5 ~ data5S$vyrobce)

library(rstatix)

op_kap5 = 
  data5S %>% 
  group_by(vyrobce) %>% 
  identify_outliers(kap5)
op_kap5

data5S$kap5_bez_OP = ifelse(data5S$id %in% op_kap5$id, NA, data5S$kap5) 

boxplot(data5S$kap5_bez_OP ~ data5S$vyrobce)

# **Analytik může vždy říct, že odlehlá pozorování odstraňovat nebude, ale tuto
# informaci musí do zápisu o analýze uvést!**


#  9. pravidlo 3 $\sigma$ a Čebyševova nerovnost ####
# * Empirické ověření normality ####
# **Vycházíme z dat po odstranění odlehlých pozorování:**


data_A_kap5_bezOP = as.list(data5S %>% filter(vyrobce=="A") %>% select(kap5_bez_OP))
head(data_A_kap5_bezOP)

# použijeme data z ukázky odstranění op
data_A_kap5_bezOP = na.omit(data_A_kap5_bezOP)

# Vykreslíme QQ graf a spočteme šikmost a špičatost:


qqnorm(data_A_kap5_bezOP)
qqline(data_A_kap5_bezOP)

moments::skewness(data_A_kap5_bezOP)
moments::kurtosis(data_A_kap5_bezOP) - 3 # jiná definice posunutá o 3

# - tečky v QQ grafu musí ležet přibližně na čáře - tzn. kvantily odpovídají přibližně
# kvantilům normálního rozdělení
# - šikmost (skewness) musí ležet v intervalu <-2, 2>
# - špočatost (kurtosis) musí ležet v intervalu <-2,2>
#  - pozor výsledek Rkové funkce musíme ponížit o 3
#  
# **Je-li splněna normalita dat -> pravidlo 3σ**
# σ:  P(µ − σ < X < µ + σ) = 0,6827
# 2σ: P(µ − 2σ < X < µ + 2σ) = 0,9545
# 3σ: P(µ − 3σ < X < µ + 3σ) = 0,9973
# 
# **Není-li splněna normalita dat -> Čebyševova nerovnost**
# σ:  P(µ − σ < X < µ + σ) = 0
# 2σ: P(µ − 2σ < X < µ + 2σ) = 0,75
# 3σ: P(µ − 3σ < X < µ + 3σ) = 0,8889


mu = mean(data_A_kap5_bezOP)
sigma = sd(data_A_kap5_bezOP)
paste0("<", mu - sigma, ", ", mu + sigma, ">")
paste0("<", mu - 2*sigma, ", ", mu + 2*sigma, ">")
paste0("<", mu - 3*sigma, ", ", mu + 3*sigma, ">")

#  10. Zaokrouhlování ####
# vše potřebné k zaokrouhlování naleznete na LMS v dokumento zaokrouhlování.
# https://lms.vsb.cz/pluginfile.php/1298954/mod_folder/content/0
# /Leg%C3%A1ln%C3%AD%20tah%C3%A1ky/zaokrouhlovani.pdf 
# To nejdůležitější:
# - směrodatnou odchylku zaokrouhlujeme na předepsaný počet cifer nahoru (ceiling)
#  - velikost datového souboru = <2,10> -> 1 platná cifra
#  - velikost datového souboru = (10,30> -> 2 platné cifry
#  - velikost datového souboru = (30,2000> -> 3 platné cifry
# - míry polohy (průměry, kvantily, ...) pak zaokrouhlujeme klasicky (round) na stejnou
# platnou cifru jako směrodatnou odchylku


length(data_A_kap5_bezOP)
smer_odch = sd(data_A_kap5_bezOP)
smer_odch

ceiling(smer_odch*10)/10

prumer = mean(data_A_kap5_bezOP)
prumer

round(prumer,digits=1)

max(data_A_kap5_bezOP)



