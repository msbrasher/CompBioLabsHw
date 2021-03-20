# Maizy Brasher
# EBIO 4420
# Lab 09

# Set working directory

setwd("C:/Users/maizy/CompBio/CompBioLabsHw/Labs/Lab09")

# Initial import data

camData <- read.csv("Cusack_et_al_random_versus_trail_camera_trap_data_Ruaha_2013_14.csv", stringsAsFactors = F)

str(camData)  ## Can see DateTime listed as characters
head(camData)

# Create small test vector

testvec <- camData$DateTime[1:5]



### Attempts at Lab Problem 1

as.Date(testvec[1], format='%d/%m/%Y')   # Results in date, but not time

as.Date('19/09/2013 16:29', format='%d/%m/%Y')  # Results in date, but not time

as.Date(testvec[1], format='%d/%m/%Y %H/%M')   # Results in NA


strptime(testvec[1], format='%d/%m/%Y')   # Results in date but not time

strptime(testvec[1], format='%d/%m/%Y %H:%M')   # Results in date and time in MDT

strptime('19/09/2013 16:29', format='%d/%m/%Y %H:%M', tz = "GMT")  # Date and time in GMT (need to adjust for Tanzania time zone)

strptime(testvec, format='%d/%m/%Y %H:%M', tz = "GMT")  # Vector of five dates and times 

testvec <- strptime(testvec, format='%d/%m/%Y %H:%M', tz = "GMT")
class(testvec)    # Class POSIXlt and POSIXt (is it supposed to be both?)

# Test seems to work, apply to whole vector

newDatesTimes <- strptime(camData$DateTime, format='%d/%m/%Y %H:%M', tz = "GMT")
class(newDatesTimes)   # POSIXlt and POSIXt


## Lab Problem 2

camData$DateTime[500]   ## Found an example row to look at how the two-digit years look after strptime()
newDatesTimes[500]

sub('/13 ','/2013 ', camData$DateTime[500] )  ## sub() and gsub() found on https://www.dummies.com/programming/r/how-to-substitute-text-in-r/
                                              ## My idea is to find and replace "/13 " with "/2013 " , but I am not sure how to get around the "/" special character
                                              ## This seems to work for find and replace using one sample entry

gsub('/13 ','/2013 ', camData$DateTime )   ## Based on visual inspection, this seems to work for the whole column
gsub('/14 ','/2014 ', camData$DateTime )

## The above steps might work better before changing the character dates into real dates and times in R, but gsub() could probably be used the same way to find and replace within the dates/times after

