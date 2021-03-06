# Maizy Brasher
# EBIO 4420
# Lab 03 

# Lab Step 3:  make variables for the number of bags of chips to start and the number of guests

chips <- 5
guests <- 8

# Lab Step 5: make a variable for the expected average number of chip bags per guest

avg <- 0.4

# Lab Step 7: calculate expected leftover chips

chips - (avg * guests + avg)

# Lab Step 8: make a vector containing each persons movie rankings

me <- c(7, 9, 8, 1, 2, 3, 4, 6, 5)
penny <- c(5, 9, 8, 3, 1, 2, 4, 7, 6)
lenny <- c(6, 5, 4, 9, 8, 7, 3, 2, 1)
stewie <- c(1, 9, 5, 6, 8, 7, 2, 3, 4)

# Lab Step 9: use indexing to make a variable for episode IV

pennyIV <- penny[4]
lennyIV <- lenny[4]

# Lab Step 10: concatenate all four vectors

com_rank <- cbind(me, penny, lenny, stewie)

# Lab Step 11: examine the new data

str(com_rank)
str(pennyIV)
str(penny)

# the str command shows information about what is in all three objects. The combined ranking shows what was put together (individual rankings) and it shows that it is a 9 x 4 vector. All three are numerical.

# Lab Step 12: create a data frame 

ranking_data <- data.frame(me, penny, lenny, stewie)

# or...

ranking_data2 <- as.data.frame(com_rank)

# Lab Step 13: describe differences between the objects from steps 10 and 12

dim(com_rank)
dim(ranking_data)

# The dim command shows the dimensions of an object, the two items have the same dimensions: 9 by 4

str(com_rank)
str(ranking_data)

# The str command gives a summary of the structure of an object. The object from step 10 is a numerical vector with dimensions 9 by 4, except for the names, which are characters. The data frame from step 12 is listed as a set of observations of different numerical variables. 

com_rank == ranking_data

# The == logical asks if each item in a vector is equal to the same positions in another vector. These two items contain the same entries (movie rankings) so all of the results from the logical are true. 

typeof(com_rank)
typeof(ranking_data)

# The typeof command lists what type of object R is storing an item as. The object from step 10 is being stored as a "double" and the data frame is being stored as a "list".

# Lab Step 14: create a vector of roman numerals

episodes <- c("I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX")

# Lab Step 15: add row names to the data

row.names(ranking_data) <- episodes
row.names(com_rank) <- episodes

# Lab Step 16: access the third row of combined data

com_rank[3,]

# Lab Step 17: access the fourth column of the data frame

ranking_data[,4]

# Lab Step 18: access your ranking for Episode V

ranking_data[5,1]

# Lab step 19: access Penny's ranking for Episode II

ranking_data[2,2]

# Lab Step 20: access all rankings for episodes IV - VI

ranking_data[4:6,]

# Lab Step 21: access all rankings for episodes II, V, and VII

ranking_data[c("II", "V", "VII"), ]

#Lab Step 22: access Penny and Stewie episodes IV and VI

ranking_data[c("IV","VI"), c("penny", "stewie")]

# Lab Step 23: switch Lenny's ranking II and V

lennyII <- ranking_data[2,3]
lennyV <- ranking_data[5,3]

ranking_data[2,3] <- lennyV
ranking_data[5,3] <- lennyII

# Lab Step 24: test in matrix and data frame

ranking_data["III", "penny"]
com_rank["III", "penny"]

# Lab Step 25: undo switch from step 23

lennynewII <- ranking_data["II", "lenny"]
ranking_data["II", "lenny"] <- ranking_data["V", "lenny"]
ranking_data["V", "lenny"] <- lennynewII

# Lab Step 26: redo switch from step 23 using variables

lennyII <- ranking_data[2,3]
ranking_data$lenny[2] <- ranking_data$lenny[5]
ranking_data$lenny[5] <- lennyII
