# Maizy Brasher
# EBIO 4420
# Independent Project

# Set working directory

setwd("C:/Users/maizy/CompBio/CompBioLabsHw/FinalProject")



### Initial data import and investigation ###


# Microbiome Data
biomeData <- read.csv("cleanedBiomes.csv", stringsAsFactors = F)
str(biomeData)  # All OTU columns are integers, which is good!

# Interview Data
intData <- read.csv("Mosites_Microbiome_Sharing_Interviews.csv", stringsAsFactors = F)
str(intData)    # All interactions columns are also integers, which is good!



### Subset Relevant Data ###

require("dplyr")

# Pull out necessary columns

biomeColumns <- select(biomeData, c("hhidde", "Sample_Type", "unfiltered_de_novo_otu_count", "filtered_de_novo_otu_count"))

intColumns <- select(intData, c("hhidde", "feeding1":"otherrole1"))   ## The select() function makes this so easy, I love it!

# Remove non-human biome data

humanBiomes <- filter(biomeColumns, Sample_Type == "Human")



### Combine all Columns into 1 data frame ###

# Sorted by ID number for visual comparison purposes

sortedhumanBiomes <- arrange(humanBiomes, hhidde)
sortedint <- arrange(intColumns, hhidde)

# Join two data frames

combinedData <- full_join( x = sortedint, y = sortedhumanBiomes, by = "hhidde")

# Remove rows with all missing biome data or all missing interview data

require(tidyr)

# I am pretty sure that if the unfiltered OTU count column is Na, then the filtered one is too. To check that:

which(is.na(combinedData$unfiltered_de_novo_otu_count)) == which(is.na(combinedData$filtered_de_novo_otu_count))
# These match, so I only need to specify dropping rows that are missing unfiltered OTU counts

# some rows have NA for all interview questions, but there are no stand-alone Nas. If one column is missing, they are all missing

finalData <- drop_na(combinedData, unfiltered_de_novo_otu_count, feeding1)       



### Visualize Data ###

require(ggplot2)

# Create box plot for 1 of the variables to test
# I am not sure why, but the x data has to be a factor in order for the discrete axis and labels to work 

feedingplot <- ggplot(finalData, aes( x = as.factor(feeding1), y = unfiltered_de_novo_otu_count, fill = as.factor(feeding1))) + 
  geom_boxplot() + 
  scale_x_discrete(name = "Feeding", labels = c("No", "Yes")) +
  ylab( "OTU Count") +
  theme_bw() +
  theme(legend.position = "none")

feedingplot   # this is what I want the plot for each variable to look like

# Change all interaction columns to factors

colNums <- c(2:9)  # interaction columns are #2 - #9

for (i in colNums) {
  
  finalData[,i] <- as.factor(finalData[,i])
  
}

str(finalData)  # check to make sure it worked, it did!

# Create a loop to create box plots for all variables

interactionNames <- colnames(finalData[2:9])
xlabs <- c("Feeding", "Milking", "Herding", "Slaughtering", "Caring", "Marketing", "Cleaning", "Other Roles")

for (i in 1:length(interactionNames)) {
  
  temp_plot <- ggplot(finalData, aes_string( x = interactionNames[i], y = finalData$unfiltered_de_novo_otu_count, group = interactionNames[i], 1, fill = interactionNames[i])) + 
    geom_boxplot() +
    scale_x_discrete(name = xlabs[i], breaks = c(0, 1), labels = c("No", "Yes")) +
    ylab( "OTU Count") +
    theme_bw() +
    theme(legend.position = "none")
   
  print(temp_plot)  # prints out as a plot in the console 
  # ggsave(temp_plot, file=paste(xlabs[i], "plot.png"))  # saves plot as a file in working directory
  assign(paste(interactionNames[i],"plot"), temp_plot)  # assigns each plot as a unique variable 
  
}



# This could also be done with a function that could called for each column or put into a loop

# OTUplot <- function( df, column, xlabel) {
# 
#   ggplot(df, aes_string( x = column, y = df$unfiltered_de_novo_otu_count, group = column, 1, fill = column)) + 
#    geom_boxplot() +
#    scale_x_discrete(name = xlabel, breaks = c(0, 1), labels = c("No", "Yes")) +
#    ylab( "OTU Count") +
#    theme_bw() +
#    theme(legend.position = "none")
# }

# Call the function:

# OTUplot( finalData, "feeding1", "Feeding")



### Combine boxplots for final visualization ###

install.packages("ggpubr")
