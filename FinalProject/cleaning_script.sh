#!/bin/bash

# Script to clean up data for import into R


# Remove percentages that are listed along with OTU counts

# commands used:
# sed 's/ ([0-9]*\.[0-9]*%)//g'
# sed 's/ ([0-9]*%)//g'

# All as a pipeline

cat Mosites_Microbiome_Sharing_Biomes.csv | sed 's/ ([0-9]*\.[0-9]*%)//g' | sed 's/ ([0-9]*%)//g' > cleanedBiomes.csv

