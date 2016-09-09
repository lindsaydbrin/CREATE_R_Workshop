## Fake Data Setup.R
## 2016 Aug 31
## LDBrin
##
## Make some fake data for the R workshop
##

# Tree data: How many trees of each species in plots at multiple sites per province?
# Province: "Ontario", "Quebec", "New Brunswick"
# Site: "Ottawa", "Kingston", "Toronto", "Sudbury", "Montreal", "Quebec", "Saint-Louis-du-Ha! Ha!", "Fredericton", "Moncton", "Saint John"
# Plot: 
# Species: "Pinus strobus","Acer rubrum", "Cornus florida", "Quercus alba", "Liriodendrum tulipifera"
# Count: Between 500 and 2500: round(rnorm(80, mean=1400, sd=500), 0)

trees <- data.frame(Province=c(rep("Ontario",4*6*5), rep("Quebec",3*6*5), rep("New Brunswick",3*6*5) )
										,Site=rep(c("Ottawa", "Kingston", "Toronto", "Sudbury", "Montreal", "Quebec", "Saint-Louis-du-Ha! Ha!", "Fredericton", "Moncton", "Saint John"), each=6*5)
										,Plot=rep(rep(c(1:5), each=6), 10)
										,Species=rep(c("Pinus strobus","Acer rubrum", "Cornus florida", "Quercus alba", "Liriodendrum tulipifera","Tsuga canadensis"),50)
										,Count=abs(round(rnorm(n=300, mean=20, sd=10),0))
										)
write.csv(trees, file="~/Documents/R/CREATE_R_Workshop/Data/trees.csv",row.names=FALSE)

## Data sets to convert between wide and long formats
## Make nutrients_messy appropriate for the function separate

nutrients_messy <- read.csv(file="Data/Experiment_nutrients_messy.csv")
nutrients_messy %>% gather(key="Nutrient_Rep", value="Concentration", -Treatment) %>% write.csv(file="~/Documents/R/CREATE_R_Workshop/Data/nutrients_dbl.csv", row.names=FALSE)


## Data to practice joins

	## Add data to the `trees` data set: info on mean annual temperature and precipitation for each location.
		climates <- data.frame(Site=c("Ottawa", "Kingston", "Toronto", "Sudbury"
																	, "Montreal", "Quebec", "Saint-Louis-du-Ha! Ha!"
																	, "Fredericton", "Moncton", "Saint John")
													 , MAT=c(6.6, 7.8, 9.4, 4.1
													 				,6.8, 4.2, 3.6
													 				,5.6, 6.1, 5.2)  # degrees C; data from Environment Canada Climate Normals (1981-2010)
													 , MAP=c(919.5, 951.4, 831.1, 903.3
													 				,1000.3, 1189.7, 1011.0
													 				,1077.7, 1124.0, 1295.5) ) # mm precipitation; data from Environment Canada Climate Normals (1981-2010)
		write.csv(climates, file="~/Documents/R/CREATE_R_Workshop/Data/climates.csv",row.names=FALSE)

	## For a full join especially, but also a left join
	## Both data frames: Site
	## One data frame: Abundance of different N cycling genes
	## Second data frame: Concentrations of different contaminants in the soil
	## Some sites in both data sets, some sites only in one
		genes <- data.frame(Site=c("Fredericton", "Quebec", "Ottawa", "Charlottetown", "Truro")
												,nirS = c(1.2e5, 6.3e5, 0.4e5, 3.5e5, 8.3e5)
												,nirK = c(4.0e8, 6.1e8, 4.5e8, 9.5e8, 3.4e8)
												,nosZ = c(5.7e6, 1.1e6, 5.3e6, 2.9e6, 3.9e6)  )
		metals <- data.frame(Site=c("Fredericton", "Quebec", "Charlottetown", "Truro", "Agassiz", "Lethbridge")
												 ,Pb=abs(round(rnorm(6, mean=25, sd=18),1))  # Fake data in ppm
												 ,Cu=abs(round(rnorm(6, mean=30, sd=18),1))  # Fake data in ppm
												 ,Fe=abs(round(rnorm(6, mean=300, sd=120),1)) )  # Fake data in ppt 

		write.csv(genes, file="~/Documents/R/CREATE_R_Workshop/Data/genes.csv",row.names=FALSE)	
		write.csv(metals, file="~/Documents/R/CREATE_R_Workshop/Data/metals.csv",row.names=FALSE)	


## Data for Day 1 Scripting Challenge
##
## I want the end product to be a table that counts reps of different treatments or observations
##
## Data: Audubon Christmas Bird Count data from Fundy National Park, 2015
##
	## Data downloaded from website
		Aud <- read.csv(file="~/Documents/R/CREATE_R_Workshop/Data/Audubon Christmas Bird Count 2015 - Fundy NP.csv")
	## Repeat each common name and scientific name the number of times it was observed
	## Then randomize order: Random numbers from 1:total rows, to re-order Fundybirds
	## Add fake times
	## And add back the common names
		Fundybirds <- data.frame(ScientificName = rep(Aud$ScientificName, Aud$Number)[order(rnorm(sum(Aud$Number), mean=100, sd=20))]
														 ,Hour = rep(6:21,c(74,53,48,32,28,19,33,21,24,21,28,31,31,48,56,61)) )
		Fundybirds <- left_join(Fundybirds, select(Aud,CommonName,ScientificName), by="ScientificName") %>% 
												select(CommonName, ScientificName, Hour)
		
		write.csv(Fundybirds, file="~/Documents/R/CREATE_R_Workshop/Data/Fundybirds.csv",row.names=FALSE)	

		# How many of each species?  Make a barplot.
			Fundybirds$ScientificName %>% table %>% barplot(las=2)

		# How many birds were counted in each hour?  Make a barplot.
			Fundybirds$Hour %>% table %>% barplot

		# How many times was each bird counted, and which birds were counted more than 10 times?
			Fundybirds %>% group_by(CommonName) %>% summarize(Count=length(CommonName))
			Fundybirds %>% group_by(CommonName) %>% summarize(Count=length(CommonName)) %>% filter(Count>10)

##			
## Data for for loops
##
	## Several data sets with column names "SpeciesNames"
		birdspecies <- unique(Fundybirds$ScientificName)
		birds_jan <- data.frame(SpeciesNames=birdspecies[sample(1:41, replace=FALSE)[1:24]]  # 24 randomly selected bird species (randomize order of all 41, then select first 24)
														, Count = round(runif(24,min=1, max=60),0)) 								 # Random counts of each
		birds_feb <- data.frame(SpeciesNames=birdspecies[sample(1:41, replace=FALSE)[1:28]]  # 28 randomly selected bird species 
														, Count = round(runif(28,min=1, max=60),0))
		birds_mar <- data.frame(SpeciesNames=birdspecies[sample(1:41, replace=FALSE)[1:31]]  # 31 randomly selected bird species 
														, Count = round(runif(31,min=1, max=60),0))
		birds_apr <- data.frame(SpeciesNames=birdspecies[sample(1:41, replace=FALSE)[1:37]]  # 37 randomly selected bird species 
														, Count = round(runif(37,min=1, max=60),0))

		write.csv(birds_jan, file="~/Documents/R/CREATE_R_Workshop/Data/birds_jan.csv",row.names=FALSE)	
		write.csv(birds_feb, file="~/Documents/R/CREATE_R_Workshop/Data/birds_feb.csv",row.names=FALSE)	
		write.csv(birds_mar, file="~/Documents/R/CREATE_R_Workshop/Data/birds_mar.csv",row.names=FALSE)	
		write.csv(birds_apr, file="~/Documents/R/CREATE_R_Workshop/Data/birds_apr.csv",row.names=FALSE)	
##
## Same data for ANOVA
##
		allbirds <- left_join(rename(birds_jan, Jan = Count),rename(birds_feb, Feb = Count), by="SpeciesNames") %>% 
			left_join(rename(birds_mar, Mar = Count), by="SpeciesNames") %>%
			left_join(rename(birds_apr, Apr = Count), by="SpeciesNames")
		allbirds$Feb[is.na(allbirds$Feb)] <- abs(rnorm( length(which(is.na(allbirds$Feb)==TRUE)) , mean=20, sd=5))
		allbirds$Mar[is.na(allbirds$Mar)] <- abs(rnorm( length(which(is.na(allbirds$Mar)==TRUE)) , mean=20, sd=5))
		allbirds$Apr[is.na(allbirds$Apr)] <- abs(rnorm( length(which(is.na(allbirds$Apr)==TRUE)) , mean=20, sd=5))
		allbirds <- allbirds %>% gather(key="Month", value="Count", -SpeciesNames) %>%
			mutate(Count=round(Count,0)) %>%
			rename(Species=SpeciesNames)
		write.csv(allbirds, file="~/Documents/R/CREATE_R_Workshop/Data/allbirds.csv",row.names=FALSE)	

##
## Data for plotting
##
		# Apple height in cm, generally increasing but with some scatter
			appleHeight <- jitter(seq(7, 8.5, length.out=100), amount=0.4)

		# Apple weight in g	
			appleWeight <- jitter(seq(80, 100, length.out=100), amount=0.4)
		
		# Apple and pear data
			fruitData <- data.frame(fruitHeight = c(appleHeight, jitter(seq(8, 9, length.out=100), amount=0.4)),
							fruitWeight = c(appleWeight, jitter(seq(115, 125, length.out=100), amount=0.4)),
							fruitType = c(rep("Apple", 100), rep("Pear", 100))
							)
			
		write.csv(fruitData, file="~/Documents/R/CREATE_R_Workshop/Data/fruitData.csv",row.names=FALSE)	
		