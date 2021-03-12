### Maizy Brasher
### EBIO 4420
### Lab 08

setwd("C:/Users/maizy/CompBio/CompBioLabsHw/Labs/Lab08")

# Use code from Lab04 to create a function to plot discrete-time logistic growth

discretelogGrowth <- function( r, K, numgen, initpop ) {
  
  Time <- seq(1, numgen) # vector for time
  Abundance <- rep (0, numgen) # pre-allocated vector for population
  Abundance[1] <- initpop  # make the first value the starting population
  
  for ( i in 2:numgen ) {
    Abundance[i] <- Abundance[i - 1] + ( r * Abundance[i - 1] * ( K - Abundance[i - 1] ) / K )
  }
  
  plot( Time, Abundance, col = "blue", pch = 16 )
  
  return( Abundance )
  
}

# Call the function with sample parameters 

growthrate <- 1.08
carryingcap <- 5000
numgen <- 20
initpop <- 10

samplepop <- discretelogGrowth(growthrate, carryingcap, numgen, initpop)


# Write data set as file

Generations <- seq(1:numgen)
Abundance <- samplepop

popdata <- cbind(Generations, Abundance)

write.csv(popdata, file = "Lab08_popdata.csv", row.names = FALSE)
