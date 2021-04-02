# Maizy Brasher
# EBIO 4420
# Lab 11

# Set working directory

setwd("C:/Users/maizy/CompBio/CompBioLabsHw/Labs/Lab11")

# Import data

DensityData <- read.csv("GlobalWoodDensityDatabase.csv", stringsAsFactors = F)

head(DensityData)
str(DensityData)

# Rename Density column for convenience 

colnames(DensityData)[4] <- "Density"

# Remove row with missing data

NA_row <- is.na(DensityData$Density)
NA_row

remove_this_row <- which(NA_row) # Row 12150

DensityData <- DensityData[-remove_this_row,]

# Condense species measurements into one average point
# Attempt using dplyr

library("dplyr")
require(dplyr)

AverageDensities1 <- summarise(group_by(DensityData, Family, Binomial, Density),
                              .groups = "drop")

head(AverageDensities1)  # Results in family, binomial, and density listed together, but not average density for each species


AverageDensities2 <- summarise(group_by(DensityData, Family, Binomial, Density),
                              meanDensity = mean(Density),
                              .groups = "drop")

head(AverageDensities2)   # Results in taking the mean of each row individually, not the mean of all rows for a species

AverageDensities3 <- group_by(DensityData, Family, Binomial, Density)
summarise(AverageDensities3, meanDensity = mean(DensityData$Density))  # Results in a mean Density for the whole column, but not by species

head(AverageDensities3)

## I am still pretty stuck on how exactly summarise() works

# Attempt using base R

head(DensityData)

speciesnames <- unique(DensityData$Binomial)
length(speciesnames)

speciescounts <- as.data.frame( table(DensityData$Binomial), stringsAsFactors = F)
speciescounts




