setwd("C:/Users/dk/Desktop/NYU Classes/Semester 2/Big Data/Datastore Project")
df <- read.csv("Sale_Prices_Msa.csv")
transpose <- t(df)

# creating a script to create a long sql query that involves averaging each column and outputting the results to a new table

allStatesQuery <- 'INSERT INTO LinearRegression SELECT '
for(i in 1:ncol(transpose)){
  allStatesQuery <- paste(allStatesQuery,"(c", sep="")
  allStatesQuery <- paste(allStatesQuery,transpose[1,i], sep="")
  allStatesQuery <- paste(allStatesQuery," - (select avg(c", sep="")
  allStatesQuery <- paste(allStatesQuery,transpose[1,i], sep="")
  allStatesQuery <- paste(allStatesQuery,") from uscities)) AS yMINybr", sep="")
  allStatesQuery <- paste(allStatesQuery,i-1, sep="")
  if(i == ncol(transpose)){
    break
  }
  allStatesQuery <- paste(allStatesQuery,", ", sep="")
}
allStatesQuery <- paste(allStatesQuery," FROM uscities where months >= 201612 and months <= 201712;", sep="")
allStatesQuery

#creating a script to create a long sql query that involves multiplying the quantities (x - xbar)(y - ybar) so that a sum can happen to finally get the top portion of the slope

multQuery <- 'INSERT INTO linearRegressionFINALSTEPS SELECT '
for(i in 1:ncol(transpose)){
  multQuery <- paste(multQuery,"(xMINxbr * c", sep="")
  multQuery <- paste(multQuery,transpose[1,i], sep="")
  multQuery <- paste(multQuery,")", sep="")
  if(i == ncol(transpose)){
    break
  }
  multQuery <- paste(multQuery,", ", sep="")
}
multQuery <- paste(multQuery," FROM linearregressionxyminxybar;", sep="")
multQuery

#creating a script to create a long sql query that involves finding the slope of the linear regression for each of the cities that Zillow was in from 2016/12 - 2017/12.
transpose <- t(df)
cityNames <- transpose[2,]
cityNames <- gsub(",(.*)", "", cityNames[1:length(cityNames)]) 
cityNames

slopeQuery <- 'SELECT '
for(i in 1:ncol(transpose)){
  slopeQuery <- paste(slopeQuery,"(SUM(c", sep="")
  slopeQuery <- paste(slopeQuery,transpose[1,i], sep="")
  slopeQuery <- paste(slopeQuery,")/SUM(timePower))", sep="")
  slopeQuery <- paste(slopeQuery," as \'", sep="")
  slopeQuery <- paste(slopeQuery,cityNames[i], sep="")
  slopeQuery <- paste(slopeQuery,"\'", sep="")
  if(i == ncol(transpose)){
    break
  }
  slopeQuery <- paste(slopeQuery,", ", sep="")
}
slopeQuery <- paste(slopeQuery," FROM linearregressionfinalsteps;", sep="")
slopeQuery

