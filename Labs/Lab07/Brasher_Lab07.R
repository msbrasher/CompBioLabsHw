### Maizy Brasher
### EBIO 4420
### Lab 07

### Lab Problem 1: Write a function that calculates the area of a triangle given its base and height

triangleArea <- function ( base, height ){
  
  return( 0.5 * base * height) ## 0.5 comes from the standard formula for the area of a triangle: 0.5*b*h
  
} 

# Call the function for a triangle with a base of 10 and a height of 9

triangleArea(10, 9) ## result = 45, as expected


### Lab Problem 2: create a new absolute value function

myAbs <- function( x ) {
  
  if (x < 0) {
   
    x <- x * -1
    
  }
  
  return( x )
  
}

# Test the function with given values

myAbs(5) ## Result = 5 as expected
myAbs(-2.3)  ## Result = 2.3 as expected

# Revise the function to work for vectors

myAbs <- function( Vec ) {
  
  negatives <- which(Vec < 0)
  Vec[negatives] <- Vec[negatives] * -1
  
  return( Vec )
  
}

# Test the function with the given vector

myVec <- c(1.1, 2, 0, -4.3, 9, -12)

myAbsVec <- myAbs(myVec)



### Lab Problem 3: create a function for n terms of the Fibonacci Sequence 

fibonacci <- function( n, start ) {
  
  fibVec <- rep(1, n)
  fibVec[1] <- start
  
  
  for ( i in 3:n ) {
    fibVec[i] <- fibVec[i - 1] + fibVec[i - 2]
  }
  
  return(fibVec)
  
}

### Lab Problem 4a: create a function that returns the square of the difference between two numbers

diffsquared <- function( x, y ) {
  
  return( (x - y) ^ 2)
  
}

# Test the function with the given numbers and vectors

diffsquared( 3, 5) ## Result = 4 as expected

diffsquared( c(2, 4, 6), 4) ## Result = 4, 0, 4 as expected



### Lab Problem 4b: create a new function to calculate the average of a vector of numbers

newmean <- function( vec ) {
  
  return( sum( vec ) / length( vec ) )
  
}

# Test the function with the given vector

newmean( c(5, 15, 10) )  ## Result = 10 as expected

# Test the function with the given data file

setwd( "C:/Users/maizy/CompBio/CompBioLabsHw/Labs/Lab07" )

DataLab7 <- read.csv("DataForLab07.csv")

str(DataLab7)  # view a summary of the data 

DataLab7 <- DataLab7$x  # Convert data frame to vector

newmean( DataLab7 )  # test function
                     # Result = 108.9457 as expected



### Lab Problem 4c: write a function for the sum of squares

sumsquares <- function( vec ) {
  
  mean <- newmean( vec )
  
  squarediffs <- diffsquared( vec, mean )
  
  total <- sum( squarediffs )
  
  return( total )
  
}

# Test the function using the provided data

sumsquares( DataLab7 )  ## Result = 179442.4 as expected 
 
