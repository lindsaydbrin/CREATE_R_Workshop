# Day 1 Scripting Challenge Solution
CRI R Workshop  
___

* [Your original mission](#mission)
* [A solution: Sample script](#solution)

___

# Your original mission {#mission}

The data file `Fundybirds.csv` contains data on bird species counted in Fundy National Park during the Audubon Society's annual [Christmas Bird Count](http://www.audubon.org/conservation/science/christmas-bird-count).  Your goal is to write a new R script that does a basic analysis of these data.  

Be sure to begin the script with commented lines with the file name, your name, the date, and a description of the script, and also comment liberally throughout the script to indicate what your code does!

Your script should do the following:

* Read in the file `Fundybirds.csv`

* Look at the structure of the data

* Create data frames that answer the following questions: (Hint: Use `dplyr` functions!)

	+ How many times was each type of bird counted?
	
	+ Which birds were counted more than 10 times?

* Make a table that shows how many species were counted each hour

* Plot this table using a barplot

___

# A solution: Sample script {#solution}

<br>


```r
## ScriptingChallenge.R
## LDBrin
## September 2016
##
## This script analyzes bird count data from the 2015 Audubon Society Christmas Bird Count.
## It assesses the number of times that each type of bird was counted, as well as how many were counted each hour.
##

## Load required packages
	library(dplyr)

# Read in the file
	Fundybirds <- read.csv(file="~/Documents/R/CREATE_R_Workshop/Data/Fundybirds.csv")

# Look at the structure
	str(Fundybirds)

# How many times was each bird counted, and which birds were counted more than 10 times?
	Fundybirds %>% group_by(CommonName) %>% summarize(Count=length(CommonName))
	Fundybirds %>% group_by(CommonName) %>% summarize(Count=length(CommonName)) %>% filter(Count>10)

# How many birds were counted in each hour?  Make a table and a barplot.
	Fundybirds$Hour %>% table
	Fundybirds$Hour %>% table %>% barplot(las=1, ylab="Count", xlab="Hour")
```

```
## 'data.frame':	608 obs. of  3 variables:
##  $ CommonName    : Factor w/ 41 levels "American Crow",..: 6 14 1 17 22 15 35 7 7 20 ...
##  $ ScientificName: Factor w/ 41 levels "Accipitridae sp.",..: 31 20 10 38 21 27 9 12 12 28 ...
##  $ Hour          : int  6 6 6 6 6 6 6 6 6 6 ...
## Source: local data frame [41 x 2]
## 
##                    CommonName Count
##                        (fctr) (int)
## 1               American Crow    46
## 2          American Goldfinch    14
## 3              American Robin    12
## 4       American Tree Sparrow     5
## 5                  Bald Eagle     3
## 6      Black-capped Chickadee   180
## 7                    Blue Jay    50
## 8            Boreal Chickadee    18
## 9               Brown Creeper     1
## 10 Bullock's/Baltimore Oriole     1
## ..                        ...   ...
## Source: local data frame [16 x 2]
## 
##                         CommonName Count
##                             (fctr) (int)
## 1                    American Crow    46
## 2               American Goldfinch    14
## 3                   American Robin    12
## 4           Black-capped Chickadee   180
## 5                         Blue Jay    50
## 6                 Boreal Chickadee    18
## 7                     Common Raven    11
## 8  Dark-eyed Junco (Slate-colored)    20
## 9                 Downy Woodpecker    11
## 10               European Starling    22
## 11          Golden-crowned Kinglet    22
## 12                    Herring Gull    56
## 13                   Mourning Dove    12
## 14           Red-breasted Nuthatch    16
## 15      Rock Pigeon (Feral Pigeon)    17
## 16                   Ruffed Grouse    25
## .
##  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 
## 74 53 48 32 28 19 33 21 24 21 28 31 31 48 56 61
```

![](Lesson_-_Day_1_Scripting_Challenge_Solution_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

