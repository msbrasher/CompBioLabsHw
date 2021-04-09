# Maizy Brasher
# EBIO 4420
# Lab 12

# Set working directory

setwd("C:/Users/maizy/CompBio/CompBioLabsHw/Labs/Lab12")

# Import Data

stateStatsData <- read.csv("C:/Users/maizy/CompBio/compBioSandbox/CompBio_on_git/Datasets/COVID-19/CDPHE_Data/CDPHE_Data_Portal/DailyStateStats2/CDPHE_COVID19_Daily_State_Statistics_2_2021-04-02.csv", 
                           stringsAsFactors = F)
str(stateStatsData)

colnames(stateStatsData)[1] <- "Name"

# Lab Part 1: cleaning up the data with a pipeline

require(dplyr)
dt <- as.POSIXlt("2020-05-15")

ColoradoData <- stateStatsData %>% 
  filter( Name == "Colorado") %>% 
  select(Date, Cases, Deaths) %>%
  mutate( Date = strptime( Date, format = "%m/%d/%Y", tz = "")) %>% 
  arrange(Date) %>% 
  filter( Date < dt )

str(ColoradoData)

ColoradoData$Date <- as.POSIXct(ColoradoData$Date)  # message from ggplot that Date column had to be POSIXct



# Lab Part 2: Create two plots

require(ggplot2)

# Plot cases by date
CasesPlot <- ggplot(ColoradoData, aes( x = Date , y = Cases)) + geom_line(size = 2) + scale_y_log10()

# Plot deaths by date
DeathsPlot <- ggplot(ColoradoData, aes( x = Date , y = Deaths)) + geom_line(size = 2) + scale_y_log10()


# Lab Part 3: Add doubling times as reference 

# Doublingtimes will be 2, 3, 5, 7, 10

addDoublingTimeRefLines <- function( myPlot, Doublingtimes, startfrom ) {
  
  TimeZero <- min(ColoradoData$Date)
  ninit <- startfrom
  EndTime <- max(ColoradoData$Date)
  Doublingtimes <- Doublingtimes * 86400 # gives number of seconds in the given number of days
                                         # I am sure there is a better way to do this, but I am not sure what that would be
  
  for (i in 1:length(Doublingtimes)) {
    
    Times <- seq(from = TimeZero, 
                 to = EndTime,
                 by = Doublingtimes[i])
    doublingEvents <- 0:(length(Times) -1)
    DoublingNums <- (2^(doublingEvents)) * ninit
    
    ReferenceData <- data.frame(Times, DoublingNums)
    
    colors <- c("red", "blue", "green", "purple", "maroon")
    
    myPlot <- myPlot + geom_line(data = ReferenceData, mapping = aes(x = Times, y = DoublingNums), color = colors[i], linetype = "dashed")
    
  }
  
  myPlot
  
}

# Call function for both plots

addDoublingTimeRefLines(CasesPlot, Doublingtimes <- c(2, 3, 5, 7, 10), startfrom = ColoradoData$Cases[ColoradoData$Date == TimeZero])    

# I was getting an error message for vectors of different lengths
# The "Times" vector was going from minimum time to maximum time by
# the doubling time in seconds, not in days! 
# I fixed it, but not in the most graceful way

addDoublingTimeRefLines(DeathsPlot, Doublingtimes <- c(2, 3, 5, 7, 10), startfrom = ColoradoData$Deaths[ColoradoData$Date == TimeZero])

