## Microbiomes and Livestock

#### Introduction

The human microbiome has been a recently trendy topic of study in the world of biology, as researchers try to untangle the relationships between the human microbiome and different aspects of health. Studies have suggested connections between the microbiome and everything from digestion to immune response (Shreiner et al, 2015). Additionally, the make up of the microbiome is believed to be influenced by many factors including diet, age, and environment (Xu & Knight, 2015). 

The main objectives of this independent investigation are to consider how human interactions with common livestock animals, specifically cows and chickens, can affect the gut microbiome. If interactions with animals can alter the diversity of the microbiome, then further questions are raised about animal interactions and their effect on human health as a whole. Through this investigation, I also want to challenge my own computational abilities by using a variety of tools and skills to answer biological questions. As an additional challenge, I want to emphasize the use of `tidyverse` packages in the organization and visualization of the data, since these are less comfortable for me than some base R functions. 

My driving question for this project is:

 _How do different types of interactions with livestock affect the microbiome diversity of young children?_

#### Summary of Data

The data that I will be using comes from the paper _"Microbiome sharing between children, livestock and household surfaces in western Kenya"_ by Emily Mosites et al. The goal of the original investigation was to compare the gut microbiomes of children, livestock, and living areas in rural Kenya. The study aimed to determine if interactions with livestock led to higher similarities between the microbiomes of children and animals. Additionally, they investigated what factors, such as wealth and antibiotic use, contributed to microbiome diversity in children. 

The original study collected stool samples children and cows, cloacal swabs from chickens, and swabs of living spaces from 158 households in western Kenya. DNA was extracted from the samples and PCR amplified in order to identify the taxonomic makeup of the microorganisms in the microbiome of each sample. The diversity and makeup of the microbiomes was compared between species and households to determine if microbiomes are affected by environment and cross-species interactions. 

The original data is posted on Dryad as a collection of Excel sheets. There is also a README file, but it only contains contact info for the original authors. The metadata is mostly on one of the Excel sheets, which is a full "Data Dictionary" with explanations of all of the variables that were used in the original study. In the data collection, there is one sheet with interview data, such as how the different members of the household interact, and one sheet with biome data, including taxonomic diversity. I saved both Excel sheets as CSV files, which were 13 KB with 144 lines (interview data) and 47 KB with 410 lines (biome data). For the most part, the data is well organized and clear, but there may be some issues that arise from the use of special characters within the data entries, most notably, **%** symbols. There are also some missing data entries that will likely have to be removed before analysis. 

#### Independent Analysis

_Goal:_ Investigate how different types of interactions with livestock affect the gut microbiome diversity of young children

_Steps:_

1. Clean up the original data
* Use shell commands ( `sed` and `tr`) to investigate and correct any formatting issues caused by the use of special characters
* Correct any additional issues that may be preventing smooth import into R
2. Subset data
* Pull out columns that will be used in the analysis
* Important columns: 
	* all _Child Activity_ columns from interview data
	* OTU (Operational Taxonomic Unit) counts from biome data
    * **Challenge:** There are three different methods for OTU counts. I have not decided if I should compare all three, take an average, or choose one to use.
3. Organize Data for visualization
* Group data by activity
	* Possibly use `dplyr`, `summarise()`, and `group_by()`
* Form data frame with all entries of microbiome diversity organized by different activities
* Possibly use children with no interaction with livestock as a control for comparison
* **Challenge:** How should I deal with children who are interacting with livestock in multiple ways? Include them in all activity categories? Leave them out?
4. Visualize Data
*  Create a series of boxplots that show the spread of microbiome diversity for children who interact with livestock through each different activity
* Use `ggplot` for easy and aesthetic data visualization
5. Analyze results
* Compare ranges and medians using box plots
* T-test comparing means or medians of each category
* Compare to a control: children with no interaction with livestock
		

#### References

Mosites, Emily et al. (2018), Data from: Microbiome sharing between children, livestock and household surfaces in western Kenya, Dryad, Dataset, [https://doi.org/10.5061/dryad.f7tp6](https://doi.org/10.5061/dryad.f7tp6)

Mosites et al., “Microbiome Sharing between Children, Livestock and Household Surfaces in Western Kenya," [https://doi.org/10.1371/journal.pone.0171017](https://doi.org/10.1371/journal.pone.0171017)

Shreiner, A. B., Kao, J. Y., & Young, V. B. (2015). The gut microbiome in health and in disease. _Current opinion in gastroenterology_, _31_(1), 69–75. [https://doi.org/10.1097/MOG.0000000000000139](https://doi.org/10.1097/MOG.0000000000000139) 

Xu, Z., & Knight, R. (2015). Dietary effects on human gut microbiome diversity. _British Journal of Nutrition,_  _113_(S1), S1-S5. [doi:10.1017/S0007114514004127](doi:10.1017/S0007114514004127)


> Written with [StackEdit](https://stackedit.io/).
