## Metadata for Lab08

#### Goals for this Lab:
* Write a function for discrete-time logistic growth
* Call the function for a set of parameters
* Write out the data set as a file

#### Script Information
The [Brasher_Lab08.R](https://github.com/msbrasher/CompBioLabsHw/blob/main/Labs/Lab08/Brasher_Lab08.R) file includes the code used to create and call a function for discrete-time logistic growth, called `discretelogGrowth()`. The function calculates population abundance in the given number of generations and plots the abundance over time (example below).

![plot of population abundance](https://github.com/msbrasher/CompBioLabsHw/blob/main/Labs/Lab08/plot_abundance.png?raw=true)

The function uses the discrete-time logistic growth equation (shown below), which is often used to model population growth over time. In the equation, `r` is the intrinsic growth rate of a population, `K` is the carrying capacity of the environment, and `n[t]` is the population abundance at time `t`. 

`n[t] <- n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )`

#### Output File

The output csv file includes two columns of data, `Generations` and `Abundance`. The values for population abundance were calculated using the parameters:
``` 
growthrate <- 1.08
carryingcap <- 5000
numgen <- 20
initpop <- 10
```
_The parameters used to call the function were created arbitrarily in order to test the function._

> Written with [StackEdit](https://stackedit.io/).
