## Lab01 Script

cut -f 2-4 -d , PredPreyData.csv > cutPredPrey.csv
tail cutPredPrey.csv
grep time cutPredPrey.csv > endPredPrey.csv
tail cutPredPrey.csv >> endPredPrey.csv
