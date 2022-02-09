# ......................................................................................
# ...............................Cvičení 1 - Kombinatorika..............................
# ..................Adéla Vrtková, Michal Béreš, Martina Litschmannová..................
# ......................................................................................

# Nezobrazuje-li se vám text korektně, nastavte File \ Reopen with Encoding... na UTF-8
# Pro zobrazení obsahu skriptu použijte CTRL+SHIFT+O
# Pro spouštění příkazů v jednotlivých řádcích použijte CTRL+ENTER

# * Variace ####
# 
# V(n,k) - variace bez opakování, první argument bude celkový počet entit, druhý
# argument velikost výběru


# funkce se vytváří příkazem fucntion, je to objekt jehož jméno je dáno až proměnnou  
# do které tento objekt přiřadím
variace = function(n,k) # zde zadávám počet parametrů a jejich jména
{ # celé tělo funkce je uzavřeno mezi závorkami {...}
    citatel = factorial(n)  # faktoriál v originálním Rku existuje tak jej použijeme
    jmenovatel = factorial(n-k)
    return(citatel/jmenovatel)    # to co funkce vrátí se dává do příkazu return(...)
}

# V*(n,k) - variace s opakováním


variace_opak = function(n,k)
{
  return(n^k)
}

# * Permutace ####
# 
# P(n)=V(n,n) - permutace


permutace = function(n)
{
  return(variace(n,n))
}

# P*(n1,n2,n3,....,nk) - permutace s opakováním, vstup bude vektor s jednotlivými počty
# unikátních entit


permutace_opak = function(vec_n) # vec_n je vektro počtů hodnot př.: vec_n = c(2,2,2,4,3)
{
    n = sum(vec_n) # spočteme kolik máme hodnot celkem
    res_temp=factorial(n) #jejich faktoriál = hodnota v čitateli
    # jednoduchý cyklus začíná příkazem for, pak v závorkách následuje název iterátoru a z 
    # jakého seznamu bude brán
    for(pocet in vec_n) # pocet je iterátor a postupně bude nabývat hodnot z vektoru vec_n
    {
        # postupně dělíme faktoriálem každého počtu unikátních entit
        res_temp=res_temp/factorial(pocet) 
    }
    return(res_temp)
}

# * Kombinace ####
# 
# C(n,k) - kombinace


kombinace = function(n,k)
{
  return(choose(n,k)) # funkce for kombinace už existuje v Rku a jmenuje se choose
}

# C*(n,k) - kombinace s opakováním


kombinace_opak = function(n,k)
{
  return(choose(n+k-1,k)) # použijeme známý vzorec
}

#  Úlohy na cvičení ####
# 
# * Příklad 1. ####
# 
# V prodejně mají k dispozici tři typy zámků. Pro otevření prvního
# zámku je nutno zmáčknout čtyři z deseti tlačítek označených číslicemi 0 až 9. (Na
# pořadí nezáleží - tlačítka zůstávají zmáčknuta.)
# Druhý zámek se otevře pokud zmáčkneme šest tlačítek z deseti.
# Pro otevření třetího zámku je nutno nastavit správnou kombinaci
# na čtyřech kotoučích. Který z těchto zámků nejlépé chrání před
# zloději?


z1=kombinace(10,4)
z2=kombinace(10,6)
z3=variace_opak(10,4)
paste("pocet kombinaci: ",z1,",",z2,",",z3)
paste("pradvedepodobnost nahodnehootevreni: ",1/z1,",",1/z2,",",1/z3)

# * Příklad 2. ####
# 
# V prodejně nabízejí dva druhy zamykání kufříku. První kufřík se zamyká šifrou, která
# se skládá
# z šesti číslic. Druhý kufřík se zamyká dvěma zámky, které se otevírají současně. Šifra
# každého
# z nich se skládá ze tří číslic. Určete pro každý kufřík pravděpodobnost otevření
# zlodějem při
# prvním pokusu. Který typ zámku je bezpečnější?


z1=variace_opak(10,6);
z2=variace_opak(10,3)*variace_opak(10,3);
z2_v2=variace_opak(10,3)+variace_opak(10,3);
paste("pocet kombinaci: ",z1,",",z2,",druha varianta - ",z2_v2)

# * Příklad 3. ####
# 
# V urně je 40 koulí - 2 červené a 38 bílých. Z urny náhodně vytáhneme 2 koule. S jakou
# pravděpodobností budou obě červené?


poc_moz=kombinace(40,2);
poc_priz=kombinace(2,2);
prob=poc_priz/poc_moz;
paste("pravdepodobnost je: ",prob)

# * Příklad 4. ####
# 
# Student si měl ke zkoušce připravit odpovědi na 40 otázek. Na dvě otázky, které mu dal
# zkoušející, neuměl odpovědět a tak řekl „To mám smůlu! To jsou jediné dvě otázky, na
# které neumím odpovědět.“ S jakou pravděpodobností mluví pravdu?




# * Příklad 5.  ####
# 
# Test z chemie žák složí, pokud v seznamu 40 chemických sloučenin podtrhne jediné dva
# aldehydy, které v seznamu jsou. Jaká je pravděpodobnost, že test složí žák, který
# provede výběr
# sloučenin náhodně?




# * Příklad 6. ####
# 
# Ze zahraničí se vracela skupina 40 turistů a mezi nimi byli 2 pašeráci. Na hranici
# celník 2 turisty
# vyzval k osobní prohlídce a ukázalo se, že oba dva jsou pašeráci. Zbylí turisté na to
# reagovali:
# „Celník měl opravdu štěstí!“, „Pašeráky někdo udal!“, . . .. Jak se postavit k těmto
# výrokům?
# Je oprávněné podezření, že pašeráky někdo udal?




# * Příklad 7. ####
# 
# Z urny se třemi koulemi, dvěma červenými a jednou bílou, budou současně vybrány dvě
# koule.
# Student a učitel uzavřou sázku. Pokud budou obě koule stejné barvy, vyhraje student.
# Pokud
# budou mít koule různou barvu, vyhraje učitel. Je hra férová? Jaké jsou
# pravděpodobnosti výhry
# učitele a studenta?


# funkce combn vyrobí kombinace o předepsané velikosti - první parametr je vektor hodnot, druhý velikost výběru
combn(c('cerna','cerna','cervena'),2)

# * Příklad 8. ####
# 
# 
# Hra popsaná v příkladu 7 nebyla férová. Jakou kouli (červenou nebo bílou) musíme do
# urny přidat, aby hra férová byla?


combn(c('cerna','cerna','cerna','cervena'),2)
combn(c('cerna','cerna','cervena','cervena'),2)

# * Příklad 9. ####
# 
# Chcete hrát Člověče nezlob se, ale ztratila se hrací kostka. Čím a jak lze nahradit
# hrací kostku,
# máte-li k dispozici hrací karty (balíček 32 karet) a 4 různobarevné kuličky?




# * Příklad 10. ####
# 
# Chcete hrát Člověče nezlob se, ale ztratila se hrací kostka. Jak lze nahradit hrací
# kostku, máte-li
# k dispozici 3 různobarevné kuličky?




# * Příklad 11. ####
# 
# V prodejně vozů Škoda mají v měsíci únoru prodejní akci. Ke standardnímu vybavení
# nabízejí
# 3 položky z nadstandardní výbavy zdarma. Nadstandardní výbava zahrnuje 7 položek:
# - tempomat, vyhřívání sedadel, zadní airbagy, xenonová světla, stropní okénko,
# bezpečnostní
# zámek převodovky, speciální odolný metalízový lak.
# 
# Kolik možností má zákazník, jak zvolit 3 položky z nadstandardní výbavy?


kombinace(7,3)

# * Příklad 12. ####
# 
#  Při zkoušce si do 5. řady sedlo 12 studentů. Zkoušející chce určit sám, jak tyto
# studenty v řadě
# rozesadit.
# - Kolik je možností jak studenty rozesadit?
# - Student Brahý žádá, aby mohl sedět na kraji a odejít dříve, aby stihl vlak. Kolik je
# možností jak studenty rozesadit, chce-li zkoušející vyhovět požadavku studenta
# Brahého?
# - Kolik je možností jak studenty rozesadit, nesmějí-li Pažout a Horáček sedět vedle
# sebe?


#a
permutace(12)
prazdnych_sedadel=8
permutace_opak(c(1,1,1,1,1,1,1,1,1,1,1,1,prazdnych_sedadel))
#b
1*permutace(11)+permutace(11)*1
#c
vedle_sebe=permutace(11)+permutace(11)
permutace(12)-vedle_sebe

# * Příklad 13. ####
# 
# Kolik anagramů lze vytvořit ze slova STATISTIKA?


statistika=c(2,3,2,2,1)
permutace_opak(statistika)

# * Příklad 14. ####
# 
# V Tescu dostali nové zboží – 6 druhů chlapeckých trik. Od každého druhu mají alespoň 7
# kusů.
# Maminka chce synovi koupit 4 trika. Kolik je možností, jak je vybrat
# - mají-li být všechna různá?
# - připouští-li, že mohou být všechna stejná?


#a
kombinace(6,4)
#b
kombinace_opak(6,4)

# * Příklad 15. ####
# Kolik hesel délky 5 můžeme vytvořit ze znaků abecedy
# - nejsou-li rozlišována velká a malá písmena?
# - jsou-li rozlišována velká a malá písmena?


#a
variace_opak(26,5)
#b
variace_opak(52,5)



