# Maizy Brasher
# EBIO 4420
# Lab 05

# Lab Step 1: assign a value to the variable x and write an if-else statement

x <- 19
threshold <- 5

if (x > threshold) {
  print(paste( "x is larger than", threshold ) )
} else {
  print(paste( "x is less than or equal to", threshold ) )
}

# Lab Step 2: Import data file and optionally create a vector of the data

setwd("C:/Users/maizy/CompBio/CompBioLabsHw/Labs/Lab05")

exampledata <- read.csv("ExampleData.csv")

str(exampledata)

datavec <- exampledata$x

str(datavec)

# Lab Step 2a: Use a for() loop to change negative values to NA

threshold2 <- 0

for ( i in 1:length(datavec) ) {
  if (datavec[i] < threshold2) {
    datavec[i] <- NA
  } 
}

# Lab Step 2b: Use logical indexing to change all NA values to NaN

nalogicals <- is.na(datavec)

datavec[nalogicals] <- NaN 

# Lab Step 2c: Use which() to change all NaN values to zero

NaNpositions <- which(is.nan(datavec))

datavec[NaNpositions] <- 0

# Lab Step 2d: Determine how many values are between 50 and 100. 

lowerlimit <- 50
upperlimit <- 100

rangelogicals <- datavec >= lowerlimit & datavec <= upperlimit

length( rangelogicals[rangelogicals == TRUE] )  # found how to add to arguments in length() function on https://intellipaat.com/community/5004/how-to-count-true-values-in-r

# Lab Step 2e: Create a new vector that includes the values between 50 and 100

FiftyToOneHundred <- datavec[rangelogicals]

# Lab Step 2f: Save vector as a csv

write.csv(x = FiftyToOneHundred, file = "FiftyToOneHundred.csv")


# Lab Step 3: Import CO2 data    

CO2data <- read.csv("CO2_data_cut_paste.csv")
str(CO2data)          

# Lab Step 3a: What was the first year for which "Gas" emissions were non-zero?      

# Goal: vector of years with gas above 0, view first value in that vector

gaspositions <- which( CO2data$Gas != 0 )
      
gasyears <- CO2data$Year[gaspositions]

gasyears[1]   # 1885 = first non-zero gas emissions year

# Lab Step 3b: During which years were "Total" emissions between 200 and 300 million metric tons of carbon?

# Goal: vector of years with Total between 200 and 300

lowerlimit2 <- 200
upperlimit2 <- 300

totalpositions <- which( CO2data$Total >= lowerlimit2 & CO2data$Total <= upperlimit2 )

totalyears <- CO2data$Year[totalpositions]

# Lab Part 2



    