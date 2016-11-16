# Data Frames Part 1: Creating and inspecting data frames



___

# Why, and what? {#motivation}

Data frames are the workhorse of R data.  They are the *de facto* data structure for most tabular data, and are what is generally used for statistics and plotting.  In the previous lesson, we read in `trees.csv` and introduced you to the structure of data frames: collections of vectors (data frame columns), each containing a single data type (e.g., character, numeric, factor, logical), with rows representing different observations. In this lesson, we will briefly discuss reading in data and the handling of different data types, then introduce creating data frames.

___

# Reading in data frames

As shown with the `trees` data frame in the previous lesson, the most common way to start to work with a data frame in R is to import tabular data, often in the form of a .csv file. The file extension .csv indicates that the data in the file are separated by commas, i.e., **c**omma **s**eparated **v**alues.

Files can be imported using the functions `read.csv()` or `read.table()`, and can be read from your hard drive or from the web (i.e., with a url rather than a hard drive directory path).  In this class, we will be using `read.csv()`.  If you want to read in a file and assign it to an object, the general structure of the code is as follows:


```r
my_data_file <- read.csv(file = "Data/my_data_file.csv")
```

The object can have any name you choose (subject to the naming guidelines presented earlier), but it is often helpful to give it the same name as the file for clarity.  (Of course, you should do what makes the most sense to you.)  Remember that the file directory is *relative to your working directory* - so remember to set your working directory first!  If you try to read in data and get an error, check your file name in the output in the console.  The most common mistakes are (1) not using the appropriate working directory, and (2) having a typo in your file path or file name.

As we saw in the previous lesson, when reading in data, columns that contain character strings (text) are coerced (converted) into the `factor` data type.  Depending on what you want you want to do with the data later, this might be ideal, or you might want to keep these columns as `character`. To do so, you can use the argument `stringsAsFactors`, which can be set to FALSE.  This also works for `read.table()`, and, as we will see later, can be used when creating data frames manually.


```r
trees <- read.csv(file = "Data/trees.csv", stringsAsFactors = FALSE)
str(trees)
```


```
## 'data.frame':	300 obs. of  5 variables:
##  $ Province: chr  "Ontario" "Ontario" "Ontario" "Ontario" ...
##  $ Site    : chr  "Ottawa" "Ottawa" "Ottawa" "Ottawa" ...
##  $ Plot    : int  1 1 1 1 1 1 2 2 2 2 ...
##  $ Species : chr  "Pinus strobus" "Acer rubrum" "Cornus florida" "Quercus alba" ...
##  $ Count   : int  11 18 28 15 18 30 30 23 37 20 ...
```

Now, the variables `Province`, `Site`, and `Species` are the data type `character` rather than `factor`.

___

# Creating data frames manually

To create a data frame manually, you can use the function `data.frame()`. Within the function, you indicate names for each of the variables (columns) and use the equal sign `=` to assign vectors to each variable name. All vectors must be the same length, and, as with any vector, all elements within a vector should be the same kind of data (or they will be coerced to a single data type).

This function can also take the argument `stringsAsFactors`. Compare the output of these examples, and, in particular, the difference between when the data are being read as `character` and when they are being read as `factor`.  Also, note that you can add line breaks to make your code easier to read, as long as you are still within the parentheses of the function.  (This is true for any function in R.)


```r
example_data <- data.frame(animal = c("dog", "cat", "sea cucumber", "sea urchin"),
													 feel = c("furry", "furry", "squishy", "spiny"),
													 weight = c(45, 8, 1.1, 0.8))
str(example_data)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ animal: Factor w/ 4 levels "cat","dog","sea cucumber",..: 2 1 3 4
##  $ feel  : Factor w/ 3 levels "furry","spiny",..: 1 1 3 2
##  $ weight: num  45 8 1.1 0.8
```



```r
example_data <- data.frame(animal = c("dog", "cat", "sea cucumber", "sea urchin"),
													 feel = c("furry", "furry", "squishy", "spiny"),
													 weight = c(45, 8, 1.1, 0.8),
													 stringsAsFactors = FALSE)
str(example_data)
```

```
## 'data.frame':	4 obs. of  3 variables:
##  $ animal: chr  "dog" "cat" "sea cucumber" "sea urchin"
##  $ feel  : chr  "furry" "furry" "squishy" "spiny"
##  $ weight: num  45 8 1.1 0.8
```

The automatic conversion of data type is sometimes helpful and sometimes annoying. Be aware that it exists, learn the rules, and double-check that the data that you import are of the correct type within your data frame. If not, use it to your advantage to detect mistakes that might have been introduced during data entry, e.g., a letter in a column that should only contain numbers.

### Challenge

1. Find and fix the mistakes in this hand-crafted `data.frame`. Don't hesitate to experiment!

	
	```r
	author_book <- data.frame(author_first = c("Charles", "Ernst", "Theodosius"),
							author_last = c(Darwin, Mayr, Dobzhansky),
							year = c(1942, 1937))
	```

2. Predict the class for each of the columns in the following example, then check your guesses using str(country_climate).

	+ Which data type did you expect for each variable?  Are they what you expected?  Why or why not?
	+ What would have been different if we had added `stringsAsFactors = FALSE` to the function call?
	+ Make the necessary changes to ensure that each column has the correct data type, and check the structure of your new data frame.
	
	
	```r
	country_climate <- data.frame(country = c("Canada", "Panama", "South Africa", "Australia"),
							climate = c("cold", "hot", "temperate", "hot/temperate"),
							temperature = c(10, 30, 18, "15"),
							northern_hemisphere = c(TRUE, TRUE, FALSE, "FALSE"),
							has_kangaroo = c(FALSE, FALSE, FALSE, 1) )
	```

3. We've introduced the `data.frame()` and `read.csv()` functions for creating data frames. What if we are starting with some vectors? The best way to do this is to pass those vectors to the `data.frame()` function, similarly to above.

	
	```r
	color <- c("red", "green", "blue", "yellow")
	counts <- c(50, 60, 65, 82)
	new_dataframe <- data.frame(colors = color, counts = counts)
	str(new_dataframe)
	```
	
	```
	## 'data.frame':	4 obs. of  2 variables:
	##  $ colors: Factor w/ 4 levels "blue","green",..: 3 2 1 4
	##  $ counts: num  50 60 65 82
	```

	Make your own data frame using this approach, i.e. by creating vectors and then putting them together using `data.frame()`. Your data frame should have at least 4 variables and should contain 3 different data types.  Check the class of your data frame with `class()` and examine the data frame using `str()`.



___

# *Attribution*

*This lesson is based on materials from Data Carpentry's Data Analysis and Visualization in R curriculum (as of 11 October 2016), which is licensed under the [Creative Commons CC-BY](https://creativecommons.org/licenses/by/2.0/).  This license allows sharing and adapting materials for any purpose, as long as attribution is given.  Generally, the content, concepts, and flow are similar to the original lesson, but the words and some specific examples differ.*

