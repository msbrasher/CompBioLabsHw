# Maizy Brasher
# EBIO 4420
# Lab 04

# Lab Step 1: write a loop that prints "hi" ten times

for ( i in 1:10 ) {
  print( "hi" )
}

# Lab Step 2: write a loop for Tim's bank account balance

piggyBank <- 10  # dollars
allowance <- 5   # dollars per week
gumcost <- 2 * 1.34  # cost of two packs of gum
weeks <- 8   # length of time

for ( i in 1:weeks ) {
  piggyBank <- piggyBank + allowance - gumcost
  print( piggyBank )
}

# Lab Step 3: write a loop for the biologist

current_pop <- 2000 # number of individuals
growth_rate <- 0.95  # decrease of 5% per year
years <- 7  # length of time

for ( i in 1:years ) {
  current_pop <- current_pop * growth_rate 
  print( current_pop )
}

# Lab Step 4: write a loop for the logistic growth of a population

current_pop <- 2500  # current population, beginning at n[1]
carrying_cap <- 10000 # max population supported by environment
growth_rate <- 0.8   # growth rate of population
time <- 12   # amount of time, n[12]

for ( i in 1:time ) {
  current_pop <- current_pop + ( growth_rate * current_pop * ( carrying_cap - current_pop ) / carrying_cap )
  print( current_pop )
}

# Lab Step 5a: make a vector with 18 zeros

firstvec <- rep (0, 18)

# Lab Step 5b: make a loop that stores values in the vector

for ( i in 1:18 ) {
  firstvec[i] <- 3 * i
}

# Lab Step 5c: make a vector and make the first value 1

newvec <- rep (0, 18)

newvec[1] <- 1

# Lab Step 5d: write a loop where each entry is 1 + two times the previous entry

for ( i in seq(2,18) ) {
  newvec[i] <- 1 + 2 * newvec[i - 1]
}

# Lab Step 6: create a vector of the first 20 Fibonacci numbers

fibvec <- rep (0, 20)
fibvec[2] <- 1

for ( i in seq(3, 20) ) {
  fibvec[i] <- fibvec[i - 1] + fibvec[i - 2]
}

# Lab Step 7: redo question 4 and store the data

current_pop <- 2500  # current population, beginning at time = 1
carrying_cap <- 10000 # max population supported by environment
growth_rate <- 0.8   # growth rate of population

time <- seq (1, 12)  # vector for time
abundance <- rep (0, 12) # pre-allocated vector for population
abundance[1] <- current_pop  # make the first value the starting population

for ( i in time[2:12] ) {
  abundance[i] <- abundance[i - 1] + ( growth_rate * abundance[i - 1] * ( carrying_cap - abundance[i - 1] ) / carrying_cap )
}

# Plot the results

plot( time, abundance, col = "blue", pch = 16 )
