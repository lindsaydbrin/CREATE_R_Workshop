# Scripting Challenge

___

* [What, and why?](#motivation) 
* [Your mission](#mission)


___

# Why, and what? {#motivation}

Let's put together everything you've learned!  This lesson will give you practice with the contents of the lessons so far, and give you an example of the kind of R script that you might write for your own work.

___

# Your mission {#mission}

The data file `Fundybirds.csv` contains data on bird species counted in Fundy National Park during the Audubon Society's annual [Christmas Bird Count](http://www.audubon.org/conservation/science/christmas-bird-count).  Your goal is to write a new R script that does a basic analysis of these data.  
`Fundybirds.csv` is a list of birds that were sighted during the bird count. Each observation (row) in `Fundybirds.csv` represents one bird sighting. The dataset contains the following variables:

**Column**      | **Description**
----------------|----------------------
CommonName      | Common name for the observed bird 
ScientificName  | Scientific name for the observed bird
Hour            | Hour during which the bird was counted

Your script should do the following:

* Read in the file `Fundybirds.csv`.

* Look at the structure of the data.

* Create data frames that answer the following questions: (Hint: Use `dplyr` functions!)

	+ How many times was each type of bird counted?
	
	+ Which birds were counted more than 10 times?

* Make a table that shows how many birds were counted each hour.

* Plot this table using a barplot.

Be sure to begin the script with commented lines with the file name, your name, the date, and a description of the script, and also comment liberally throughout the script to indicate what your code does!
