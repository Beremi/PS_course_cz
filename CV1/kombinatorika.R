# ......................................................................................
#
#  Kombinatorika ####
#
# * Variace ####
#
# V(n,k) - variace bez opakování, první argument bude celkový počet entit, druhý
# argument velikost výběru


# funkce se vytváří příkazem fucntion, je to objekt jehož jméno je dáno až proměnnou
# do které tento objekt přiřadím
variace <- function(n, k) # zde zadávám počet parametrů a jejich jména
{ # celé tělo funkce je uzavřeno mezi závorkami {...}
  citatel <- factorial(n) # faktoriál v originálním Rku existuje tak jej použijeme
  jmenovatel <- factorial(n - k)
  return(citatel / jmenovatel) # to co funkce vrátí se dává do příkazu return(...)
}

# V*(n,k) - variace s opakováním


variace_opak <- function(n, k) {
  return(n^k)
}

# * Permutace ####
#
# P(n)=V(n,n) - permutace


permutace <- function(n) {
  return(variace(n, n))
}

# P*(n1,n2,n3,....,nk) - permutace s opakováním, vstup bude vektor s jednotlivými počty
# unikátních entit


permutace_opak <- function(vec_n) { # vec_n je vektro počtů hodnot př.: vec_n = c(2,2,2,4,3)
  n <- sum(vec_n) # spočteme kolik máme hodnot celkem
  res_temp <- factorial(n) # jejich faktoriál = hodnota v čitateli
  # jednoduchý cyklus začíná příkazem for, pak v závorkách následuje název iterátoru a z
  # jakého seznamu bude brán
  for (pocet in vec_n) # pocet je iterátor a postupně bude nabývat hodnot z vektoru vec_n
  {
    # postupně dělíme faktoriálem každého počtu unikátních entit
    res_temp <- res_temp / factorial(pocet)
  }
  return(res_temp)
}

# * Kombinace ####
#
# C(n,k) - kombinace


kombinace <- function(n, k) {
  return(choose(n, k)) # funkce for kombinace už existuje v Rku a jmenuje se choose
}

# C*(n,k) - kombinace s opakováním


kombinace_opak <- function(n, k) {
  return(choose(n + k - 1, k)) # použijeme známý vzorec
}
