# ......................................................................................
# ..............................Cvičení 2 - Pravděpodobnost.............................
# ..................Adéla Vrtková, Michal Béreš, Martina Litschmannová .................
# ......................................................................................

# Nezobrazuje-li se vám text korektně, nastavte File \ Reopen with Encoding... na UTF-8
# Pro zobrazení obsahu skriptu použijte CTRL+SHIFT+O
# Pro spouštění příkazů v jednotlivých řádcích použijte CTRL+ENTER

# V tomto cvičení projdeme úvod do pravděpodobnosti. Předpokládáme znalosti z přednášky,
# především pojmy: **definice pravděpodobnosti, podmíněná pravděpodobnost, věta o úplné
# pravděpodobnosti, Bayesova věta**.
# 
#  Pomocné funkce ####
# 
# * Úplná pravděpodobnost ####
# $P(A)=\sum_{i=1}^{n}P(B_i)P(A|B_i)$


# spočítání pravděpodobnosti P(A) - věta o úplné pravděpodobnosti
uplna_pravdepodobnost = function(P_B, P_AB)
{   # uvažujeme P_B jako vektor hodnot P(B_i) a P_BA jako vektor hodnot P(A|B_i)
    P_A = 0
    for (i in 1:length(P_B))
    {
        P_A = P_A + P_B[i]*P_AB[i]
    }
    return(P_A)
}

# * Bayesova věta ####
# $P(B_k|A)=\frac{P(B_k)P(A|B_k)}{\sum_{i=1}^{n}P(B_i)P(A|B_i)}$


# spočítání podmíněné pravděpodobnosti P(B_k|A) - Bayesova věta
bayes = function(P_B, P_AB, k)
{   # uvažujeme P_B jako vektor hodnot P(B_i), P_BA jako vektor hodnot P(A|B_i)
    P_A = uplna_pravdepodobnost(P_B, P_AB)
    P_BkA = P_B[k]*P_AB[k]/P_A
    return(P_BkA)
} 

# **Přidáme funkce z munulého cvičení pro počítání kombinatorických výběrů, jsou v
# skriptu kombinatorika.R**


source('kombinatorika.R')

#  Příklady ####
# * Příklad 1. ####
# Určete pravděpodobnost, že při hodu 20stěnnou spravedlivou (férovou) kostkou padne
# číslo větší než 14.


omega = 1:20
A = c(15,16,17,18,19,20)
# pravděpodobnost jako podíl příznivých ku všem 
length(A)/length(omega)

# * Příklad 2. ####
# Určete pravděpodobnost, že při hodu 20stěnnou kostkou padne číslo větší než 14,
# víte-li, že sudá čísla padají 2x častěji než lichá.


p_liche = 1/(20+10)
p_sude = 2*p_liche
pravd = c(p_liche, p_sude, p_liche, p_sude, p_liche, p_sude, p_liche, p_sude, 
          p_liche, p_sude, p_liche, p_sude, p_liche, p_sude, p_liche, p_sude, 
          p_liche, p_sude, p_liche, p_sude)
pravd
#pravdepodobnost je
sum(pravd[15:20])

# * Příklad 3. ####
# Určete pravděpodobnost, že ve sportce uhodnete 4 čísla. (Ve sportce se losuje 6 čísel
# ze 49.)


(kombinace(6,4)*kombinace(43,2))/kombinace(49,6)

# * Příklad 4. ####
# Z abecedního seznamu studentů zapsaných na dané cvičení vybere učitel prvních 12 a
# nabídne jim sázku: „Pokud se každý z Vás narodil v jiném znamení zvěrokruhu, dám
# každému z Vás 100 Kč. Pokud jsou však mezi Vámi alespoň dva studenti, kteří se
# narodili ve stejném znamení, dá mi každý z Vás 100 Kč.“ Vyplatí se studentům sázku
# přijmout? S jakou pravděpodobností studenti vyhrají?


permutace(12)/variace_opak(12,12)

# * Příklad 5. ####
# Spočtěte pravděpodobnost toho, že z bodu 1 do bodu 2 bude protékat elektrický proud,
# je-li část el. obvodu včetně pravděpodobnosti poruch jednotlivých součástek vyznačen
# na následujícím obrázku. (Poruchy jednotlivých součástek jsou na sobě nezávislé.)
# Obrázek viz sbírka úloh.


# rozdělíme na bloky I=(A,B) a II=(C,D,E)
PI = 1 - (1 - 0.1)*(1 - 0.3)
PI
PII = 0.2*0.3*0.2
PII
# výsledek
(1 - PI)*(1-PII)

# * Příklad 6. ####
# Ohrada má obdélníkový tvar, východní a západní stěna mají délku 40 m, jižní a severní
# pak 100 m. V této ohradě běhá kůň. Jaká je pravděpodobnost, že je k jižní stěně blíž
# než ke zbývajícím třem?


# geometrická pravděpodobnost
ohrada = 40*100
#blize k jihu
blize_J = 20*60 + 20*20
#pravdepodobnosti
blize_J/ohrada

# * Příklad 7. ####
# U pacienta je podezření na jednu ze čtyř vzájemně se vylučujících nemocí - N1, N2, N3,
# N4 s pravděpodobností výskytu P(N1)=0,1; P(N2)=0,2; P(N3)=0,4; P(N4)=0,3. Laboratorní
# zkouška A je pozitivní v případě první nemoci v 50 % případů, u druhé nemoci v 75 %
# případů, u třetí nemoci v 15 % případů a u čtvrté v 20 % případů. Jaká je
# pravděpodobnost, že výsledek laboratorní zkoušky bude pozitivní?


# věta o úplné pravděpodobnosti
P_N = c(0.1,0.2,0.4,0.3) # P(N1), P(N2), ...
P_PN = c(0.5,0.75,0.15,0.2) # P(P|N1), P(P|N2), ... 
P_P = uplna_pravdepodobnost(P_B = P_N, P_AB = P_PN) # P(P)
P_P

# * Příklad 8. ####
# Telegrafické znaky se skládají ze signálů „tečka“, „čárka“. Je statisticky zjištěno,
# že se zkomolí 25 % sdělení „tečka“ a 20 % signálů „čárka“. Dále je známo, že signály
# se používají v poměru 3:2. Určete pravděpodobnost, že byl přijat správně signál,
# jestliže byl přijat signál „tečka“.


# Bayesova věta
P_O = c(0.6, 0.4)   #    P(O.),    P(O-)
P_PO = c(0.75, 0.2) # P(P.|O.), P(P.|O-)
bayes(P_B = P_O, P_AB = P_PO, k = 1) # k = 1 protože správně = O.

# * Příklad 9. ####
# V jednom městě jezdí 85 % zelených taxíků a 15 % modrých. Svědek dopravní nehody
# vypověděl, že nehodu zavinil řidič modrého taxíku, který pak ujel. Testy provedené za
# obdobných světelných podmínek ukázaly, že svědek dobře identifikuje barvu taxíku v 80
# % případů a ve 20 % případů se mýlí.
#  - Jaká je pravděpodobnost, že viník nehody skutečně řídil modrý taxík?
#  - Následně byl nalezen další nezávislý svědek, který rovněž tvrdí, že taxík byl
# modrý. Jaká je nyní pravděpodobnost, že viník nehody skutečně řídil modrý taxík?
#  - Ovlivní pravděpodobnost, že viník nehody skutečně řídil modrý taxík to, zda dva
# výše
# zmínění svědci vypovídali postupně nebo najednou?


# a) opět Bayesova věta
P_B = c(0.85, 0.15)  #    P(Z),    P(M) 
P_SB = c(0.20, 0.80) # P(SM|Z), P(SM|M) 
bayes(P_B = P_B, P_AB = P_SB, k = 2) # modrý je druhý

# b) první možnost - druhý průchod Bayesem
P_M = bayes(P_B = P_B, P_AB = P_SB, k = 2)
P_B = c(1 - P_M, P_M)  #     P(Z),     P(M) 
P_SB = c(0.20, 0.80)   # P(S2M|Z), P(S2M|M) 
bayes(P_B = P_B, P_AB = P_SB, k = 2)

# c) nebo odpověděli najednou 
P_B = c(0.85, 0.15)      #         P(Z),         P(M) 
P_SB = c(0.20^2, 0.80^2) # P(S1M&S2M|Z), P(S1M&S2M|M) 
bayes(P_B = P_B, P_AB = P_SB, k = 2)

# * Příklad 10. ####
# Potřebujeme zjistit odpověď na určitou citlivou otázku. Jak odhadnout, kolik procent
# dotazovaných na otázku odpoví ANO a přitom všem respondentům zaručit naprostou
# anonymitu? Jedním z řešení je tzv. dvojitě anonymní anketa:
# Necháme respondenty hodit korunou a dvojkorunou a ti, kterým padl na koruně líc
# napíšou na lísteček odpověď (ANO/NE) na citlivou otázku. Ostatní respondenti napíší,
# zda jim padl na dvojkoruně líc (ANO/NE). Jakým způsobem určíme podíl studentů, kteří
# na citlivou otázku odpověděli ANO?
# Předpokládejme, že respondenti byli dotazování, zda podváděli u zkoušky. Z anketních
# lístků se zjistilo, že „ANO“ odpovědělo 120 respondentů a „NE“ odpovědělo 200
# respondentů. Kolik procent studentů podvádělo u zkoušky?


# věta o úplné pravděpodobnosti 
# P(A) = P(K_lic)*P(A|K_lic)+P(K_rub)*P(D_lic|K_rub)
# rovnice 120/320=0.5*x+0.5*0.5
(120/320-0.5^2)/0.5

# * Bonus - Monty Hall Problem ####
# 
# Začneme s vygenerováním n instancí soutěže - cena bude náhodný index dveří (1,2,3) za
# kterými se může nacházet cena


n = 10000 # počet pokusů
cena = sample.int(n = 3, size = n, replace = TRUE) # náhdný výběr dveří
head(cena) # head vykresli prvních 6 prvků/řádků

# Totéž pro naši původní volbu - náhodný index dveří.


volba_orig = sample.int(n = 3, size = n, replace = TRUE) # původní volba
head(volba_orig)

# V prvním kole moderátor jedny prázdné dveře otevře, takto se to dá nasimulovat:


otevrene_dvere = rep(0, n) # inicializace vektoru
dvere_c = 1:3 # pomocná proměnná - identifikátory dveří
for (i in 1:n){
    dvere_k_otevereni = c(TRUE, TRUE, TRUE) # inicializace 
    dvere_k_otevereni[cena[i]] = FALSE # nesmíme otevřít dveře s cenou
    dvere_k_otevereni[volba_orig[i]] = FALSE # ani naše vybrané dveře
    # ve zbytku jsou buď 2 (pokud jsme se trefili) nebo 1 dveře (pokud ne)
    idx_dvere = dvere_c[dvere_k_otevereni]
    if (length(idx_dvere) == 1){
        otevrene_dvere[i] = idx_dvere # pokud jedny otevřeme je
    } else { # pokud 2 tak jedny náhodně vybereme a otevřeme je
        otevrene_dvere[i] = sample(x = idx_dvere, size = 1)
    }
}
head(otevrene_dvere)

# Naše nová volba pokud se tak rozhodneme - součet indexů je 1+2+3=6 takže pokud my máme
# vybraný nějaký index, dále nějaký index se otevře, tak do zbytku 6 jsou ty třetí =
# naše nová volba.


nova_volba = 6 - (volba_orig + otevrene_dvere)
head(nova_volba)

# Úspěšnost při originální volbě:


p_orig = sum(cena == volba_orig)/n
p_orig

# Úspěšnost při výměně:


p_zmena = sum(cena == nova_volba)/n
p_zmena

p_orig + p_zmena



