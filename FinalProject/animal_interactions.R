# Maizy Brasher
# EBIO 4420
# Independent Project

# Set working directory

setwd("C:/Users/maizy/CompBio/CompBioLabsHw/FinalProject")   # Edit this line appropriately for your computer



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

# Pull out control data. Controls are all children that do not have any interactions with livestock

controlData <- filter(finalData, feeding1 == 0 & milking1 == 0 & herding1 == 0 & slaughtering1 == 0 & caring1 == 0 & marketing1 == 0 & cleaning1 == 0 & otherrole1 == 0)  
# There is probably a more efficient way to specify all of these columns, but I could not figure it out



### Visualize Data ###

require(ggplot2)

# Create box plot for 1 of the variables to test
# I am not sure why, but the x data has to be a factor in order for the discrete axis and labels to work 

feedingplot <- ggplot(finalData, aes( x = as.factor(feeding1), y = unfiltered_de_novo_otu_count, fill = as.factor(feeding1))) + 
  geom_boxplot() + 
  # Add in control data. 3 is used for x so that the control sits to the right of the yes/no data on the plot
  geom_boxplot(data = controlData, mapping = aes(x = as.factor(3), y = unfiltered_de_novo_otu_count, fill = as.factor(3))) +  
  scale_x_discrete(name = "Feeding", labels = c("No", "Yes", "Control")) +
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
    geom_boxplot(data = controlData, mapping = aes(x = as.factor(3), y = unfiltered_de_novo_otu_count, fill = as.factor(3))) +
    scale_x_discrete(name = xlabs[i], labels = c("No", "Yes", "Control")) +
    ylab( "OTU Count") +
    theme_bw() +
    theme(legend.position = "none")
   
  # print(temp_plot)  # prints out as a plot in the console 
  # ggsave(temp_plot, file=paste(xlabs[i], "plot.png", sep = ""))  # saves plot as a file in working directory
   
  assign(paste(interactionNames[i],"plot", sep = ""), temp_plot)  # assigns each plot a unique variable
  
}



# This could also be done with a function that could called for each column or put into a loop

# OTUplot <- function( df, column, xlabel) {
# 
#   ggplot(df, aes_string( x = column, y = df$unfiltered_de_novo_otu_count, group = column, 1, fill = column)) + 
#    geom_boxplot() +
#    geom_boxplot(data = controlData, mapping = aes(x = as.factor(3), y = unfiltered_de_novo_otu_count, fill = as.factor(3))) +
#    scale_x_discrete(name = xlabel, breaks = c(0, 1), labels = c("No", "Yes")) +
#    ylab( "OTU Count") +
#    theme_bw() +
#    theme(legend.position = "none")
# }

# Call the function:

# OTUplot( finalData, "feeding1", "Feeding")



## Visualize all boxplots on one page ##

# install.packages("gridExtra")  # run this line if gridExtra is not already installed

require(gridExtra)

grid.arrange(feeding1plot, milking1plot, herding1plot, slaughtering1plot, caring1plot, marketing1plot, cleaning1plot, otherrole1plot, nrow = 2, ncol = 4)
# final product visualization yay!



### Statistical Analysis ###

colNums <- c(2:9)  # interaction columns are #2 - #9
interactionNames <- colnames(finalData[2:9])

for (i in colNums) {
  
  t <- t.test(finalData$unfiltered_de_novo_otu_count~finalData[,i])
  assign(paste(interactionNames[i - 1], "t_test", sep = ""), t[3] )   # This is so specific values can be accessed
                                                                      # individually later on 
  if(t[3] < .05) {
    print(paste("Difference is significant for", interactionNames[i - 1]))
    
  }
}

# I also tried to compare the means to the control data, but since the lengths are different, it was not working
# I added the control kind of last minute, so I did not have time to problem solve this and I really would have liked to compare to the control

#  for (i in colNums) {
  
#  t <- t.test(controlData$unfiltered_de_novo_otu_count~finalData[,i])
#  assign(paste(interactionNames[i - 1], "t_test", sep = ""), t[3] )   # This is so specific values can be accessed
                                                                      # individually later on 
#  if(t[3] < .05) {
#    print(paste("Difference is significant for", interactionNames[i - 1]))
    
#  }
#}




### Compare with filtered OTU counts###

# create plots

interactionNames <- colnames(finalData[2:9])
xlabs <- c("Feeding", "Milking", "Herding", "Slaughtering", "Caring", "Marketing", "Cleaning", "Other Roles")

for (i in 1:length(interactionNames)) {
  
  temp_plot <- ggplot(finalData, aes_string( x = interactionNames[i], y = finalData$filtered_de_novo_otu_count, group = interactionNames[i], 1, fill = interactionNames[i])) + 
    geom_boxplot() +
    geom_boxplot(data = controlData, mapping = aes(x = as.factor(3), y = filtered_de_novo_otu_count, fill = as.factor(3))) +
    scale_x_discrete(name = xlabs[i], labels = c("No", "Yes", "Control")) +
    ylab( "OTU Count") +
    theme_bw() +
    theme(legend.position = "none")
  
  # print(temp_plot)  # prints out as a plot in the console 
  # ggsave(temp_plot, file=paste(xlabs[i], "plot.png", sep = ""))  # saves plot as a file in working directory
  
  assign(paste(interactionNames[i],"filteredplot", sep = ""), temp_plot)  # assigns each plot a unique variable
  
}

# Put all plots together

grid.arrange(feeding1filteredplot, milking1filteredplot, herding1filteredplot, slaughtering1filteredplot, caring1filteredplot, marketing1filteredplot, cleaning1filteredplot, otherrole1filteredplot, nrow = 2, ncol = 4)

# T-test 

for (i in colNums) {
  
  t <- t.test(finalData$filtered_de_novo_otu_count~finalData[,i])
  assign(paste(interactionNames[i - 1], "t_test", sep = ""), t[3] )   # This is so specific values can be accessed
  # individually later on 
  if(t[3] < .05) {
    print(paste("Difference is significant for", interactionNames[i - 1]))
    
  }
}


