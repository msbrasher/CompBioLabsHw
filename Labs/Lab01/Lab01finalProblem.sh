## Lab01 Script

# Remove Row Names

cut -f 2-4 -d , PredPreyData.csv > cutPredPrey.csv

# View last 10 lines

tail cutPredPrey.csv

# Put last 10 lines and header row into a new file

grep time cutPredPrey.csv > endPredPrey.csv
tail cutPredPrey.csv >> endPredPrey.csv
