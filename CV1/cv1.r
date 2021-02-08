# # Úvod do R a implementace kombinatorických funkcí
# 
# Nejprve si projdeme některé základy Rka a naimplementujeme si některé kombinatorické funkce.
# 
# ## Krátký úvod do R

# jednoduché početní operace
2+4
5/2

# POZOR na závorky! Pro počítání se používají pouze kulaté! 
# Hranaté a složené mají v R jinou funkci!
(((10+2)*(340-33))-2)/3

## kombinační číslo, faktoriály
choose(10,2)
factorial(4)

# datové typy -> numeric, character, logical, (complex)
# funkcí class zjišťujeme typ objektu
a=2+3
class(a)

b="pismenko"
class(b)

c=(1>3)
class(c)

d=3+1i
class(d)

# ### datové struktury v R
# 
# - vector (rozumíme sloupcový vektor)
# - factor (speciální případ vektoru)
# - matrix (matice s rozměry n x m)
# - data.frame (datový rámec s rozměry n x p)
# - list (seznam)

## definování vektoru (sloupcový=column)
a = c(3,4,6,7)
a <- c(3,4,6,7)
a[2]

#další možnosti
rep(1,4) # vytvoří vektor se čtyřmi jedničkami

seq(1,10,2) #posloupnost od 1 do 10 s krokem 2

1:10  #posloupnost od 1 do 10 s krokem 1

b=c("A","B","C","D")
b

class(b)

#předefinování objektu na jiný typ - např. as.vector, as.matrix, as.factor,...
b=as.factor(b)
b

#práce s vektory - slučování podle sloupců/řádků
cbind(a,b)

rbind(a,b)

c(a,b)

## definování matice
A=matrix(c(3,4,6,7,3,2),nrow=2,ncol=3)
B=matrix(c(3,4,6,7,3,2),nrow=2,ncol=3,byrow=TRUE)
C=matrix(c(3,4,6,7,3,2),nrow=3,ncol=2)

B

B[1,3]

A[1,]

A[,2:3]

#diagonální matice
diag(4)

diag(4,2)

## operace s maticemi - pozor na maticové násobení -> %*%
A+B

A-B

A*B

A%*%C

# ## Kombinatorika
# 
# ### Začneme s variacemi.
# 
# V(n,k) - variace bez opakování, první argument bude celkový počet entit, druhý argument velikost výběru

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

# ### Permutace
# 
# P(n)=V(n,n) - permutace

permutace = function(n)
{
  return(variace(n,n))
}

# P*(n1,n2,n3,....,nk) - permutace s opakováním, vstup bude vektor s jednotlivými počty unikátních entit

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

# ### Kombinace
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

# ## Úlohy na cvičení
# 
# ### Příklad 1.
# 
# Které heslo je bezpečnější?
# * Heslo o délce osm znaků složené pouze z číslic.
# * Heslo o délce pět znaků složené pouze z písmen anglické abecedy.

# heslo 1
h1 = variace_opak(n = 10, k = 8)
# heslo 2
h2 = variace_opak(n = 26, k = 5)
h1/h2

# ### Příklad 2.
# 
# Jak dlouho by trvalo vyřešení problému obchodního cestujícího pro n = 10 měst hrubou silou, jestliže vyhodnocení délky každé z možných cest trvá 1 µs?

n = 10
pocet = permutace(n-1)/2
cas = pocet/1000000
cas

# ### Příklad 3.
# 
# Jak rozdělit kořist mezi 2 loupežníky, aby dostali oba věci ve stejné hodnotě (případně co nejbližší hodnotě). Tj. lze rozdělit N zadaných čísel do dvou skupin tak, aby součet čísel v obou skupinách byl stejný?
# 
# **Kolik možností by bylo třeba vyzkoušet, pokud bychom úlohu řešili hrubou silou?**

N = 10
L = 4
variace_opak(n = L, k = N)

# ### Příklad 4.
# 
# Kolik anagramů slova "AUTO" můžeme vytvořit?
# 
# Kolik anagramů slova "AUTOMOBILKA" můžeme vytvořit? Kolik z nich začína na "K"?

permutace(4)
vec = c(2,1,1,2,1,1,1,1,1)
sum(vec)
permutace_opak(vec)

vec = c(2,1,1,2,1,1,1,1)
sum(vec)
permutace_opak(vec)

# ### Příklad 5. 
# 
# V obchodě mají 6 druhů barevných hrníčků. 
# - Kolika různými způsoby můžeme koupit 4 různě-barevné hrníčky?
# - Kolika různými možnostmi můžeme nakoupit 5 hrníčků (pokud nám nevadí více od stejné barvy)?
# - Jak se situace změní, pokud budou mít od každého pouze 4 kusy (a nám nevadí více stejné barvy)?

kombinace(6,4)
kombinace_opak(6,5)
kombinace_opak(6,5) - 6

# ### Příklad 6. (sbírka kap. 1, př. 7,8)
# 
# Z urny se třemi koulemi, dvěma červenými a jednou bílou, budou současně vybrány dvě koule.
# Student a učitel uzavřou sázku. Pokud budou obě koule stejné barvy, vyhraje student. Pokud
# budou mít koule různou barvu, vyhraje učitel. 
# - Je hra férová? Jaké jsou pravděpodobnosti výhry učitele a studenta?
# - Jakou kouli je třeba přidat, aby hra byla férová?

kombinace(3,2)
kombinace(4,2)

# ### Příklad 7.
# 
# V balíčku je 5 různých párů ponožek (levá a pravá ponožka je vždy stejná).
# - Kolik různých dvojic ponožek lze vybrat?
# - Kolika různými způsoby se mohu obout? (tj. záleží na tom co je na které noze) 

kombinace_opak(n = 5,k = 2)
variace_opak(n=5,k=2)
kombinace_opak(n = 5,k = 2)*2 - 5

# ### Příklad 8.
# 
# 
# Mám 12 závaží o hmotnostech 1,2,...,12 kg.
# - Kolika způsoby je mohu rozdělit na 2 hromádky?
# - Kolika způsoby je mohu rozdělit na 3 hromádky?
# - Kolika způsoby je mohu rozdělit na 3 hromádky, má-li na všech být stejný počet závaží?
# - Kolika způsoby je mohu rozdělit na 3 hromádky o stejném počtu závaží, pokud hmotnost žádné z nich nesmí překročit 40 kg? 

variace_opak(2,12)
variace_opak(3,12)
(variace_opak(3,12)-3)/permutace(3)+1
(variace_opak(3,12)-(variace_opak(2,12)-2)*3-3)/permutace(3)
kombinace(12,4)*kombinace(8,4)/permutace(3)
permutace(12)/(permutace(4)*permutace(4)*permutace(4)*permutace(3))
kombinace(12,4)*kombinace(8,4)/permutace(3)-kombinace(8,4)

# ### Příklad 9.
# 
# Mám 20 semínek od každého ze tří druhů zeleniny (mrkev, ředkvička, celer). Bohužel se pomíchala.
# - Do truhlíku zasadím 5 náhodných semínek. Jaká je pravděpodobnost, že mezi nimi budou alespoň tři ředkvičky?
# - Do truhlíku zasadím 5 náhodných semínek. Jaká je pravděpodobnost, že mezi nimi bude více mrkví než celerů? 

(kombinace(20,3)*kombinace(40,2)+kombinace(20,4)*kombinace(40,1)+kombinace(20,5))/kombinace(60,5)



