# --------- import modules and dataset setup --------------

rm(list = ls())

if (!require(ggplot2)){
  install.packages(ggplot2)
}
if (!require(dplyr)){
  install.packages(dplyr)
}
if (!require(plyr)){
  install.packages(plyr)
}
library(ggplot2)
library(dplyr)
library(plyr)

setwd("C:/Users/'USER'/desktop")
colleges <- read.csv("colleges.csv")
salariesCollegeType <- read.csv("salaries-by-college-type.csv")
salariesCollegeRegion <- read.csv("salaries-by-region.csv")

# --------- Data Cleaning --------------

# Following section gets rid of nicknames ex. (NYU), dashes, commas, and trims the 
# trailing white space from both Salaries datasets in school names so that there can 
# be matching amongst school names when joining datasets. Also gets rid of a stray Washington D.C.
# for American University

salariesCollegeRegion$School.Name <- gsub(" \\(.*\\)","",salariesCollegeRegion$School.Name)
salariesCollegeRegion$School.Name <- gsub("[-] ","",salariesCollegeRegion$School.Name)
salariesCollegeRegion$School.Name <- gsub(",","",salariesCollegeRegion$School.Name)
salariesCollegeRegion$School.Name <- gsub("Washington D.C.","",salariesCollegeRegion$School.Name)
salariesCollegeRegion$School.Name <- trimws(salariesCollegeRegion$School.Name, "r")

salariesCollegeType$School.Name <- gsub(" \\(.*\\)","",salariesCollegeType$School.Name)
salariesCollegeType$School.Name <- gsub("[-] ","",salariesCollegeType$School.Name)
salariesCollegeType$School.Name <- gsub(",","",salariesCollegeType$School.Name)
salariesCollegeType$School.Name <- gsub("Washington D.C.","",salariesCollegeType$School.Name)
salariesCollegeType$School.Name <- trimws(salariesCollegeType$School.Name, "r")

# Following section replaces dashes with spaces in the colleges dataset under school name as well as
# "main campus" strings

colleges$Name <- gsub("-"," ",colleges$Name)
colleges$Name <- gsub(" Main Campus","",colleges$Name)
colleges$Name <- gsub("SUNY College","State University of New York",colleges$Name)

# --------- Analysis  --------------

# ******************************** Q1 ********************************
# Question: Does the region of the college matter to starting or mid career median salary?

# This part of the script does college region analysis and possibly determines what college regions are 
# better to attend in terms of starting/mid career median and average salaries

# subsets and provides summary statistics of the subsets of data based on region
california <- subset(salariesCollegeRegion, salariesCollegeRegion$Region == "California")[,c(1:4)]
midwest <- subset(salariesCollegeRegion, salariesCollegeRegion$Region == "Midwestern")[,c(1:4)]
northeast <- subset(salariesCollegeRegion, salariesCollegeRegion$Region == "Northeastern")[,c(1:4)]
south <- subset(salariesCollegeRegion, salariesCollegeRegion$Region == "Southern")[,c(1:4)]
west <- subset(salariesCollegeRegion, salariesCollegeRegion$Region == "Western")[,c(1:4)]

caliStartAvgAndMed <- summary(california$Starting.Median.Salary)[3:4]
caliMidAvgAndMed <- summary(california$Mid.Career.Median.Salary)[3:4]

midWStartAvgAndMed <- summary(midwest$Starting.Median.Salary)[3:4]
midWMidAvgAndMed <- summary(midwest$Mid.Career.Median.Salary)[3:4]

northEStartAvgAndMed <- summary(northeast$Starting.Median.Salary)[3:4]
northEMidAvgAndMed <- summary(northeast$Mid.Career.Median.Salary)[3:4]

southStartAvgAndMed <- summary(south$Starting.Median.Salary)[3:4]
southMidAvgAndMed <- summary(south$Mid.Career.Median.Salary)[3:4]

westStartAvgAndMed <- summary(west$Starting.Median.Salary)[3:4]
westMidAvgAndMed <- summary(west$Mid.Career.Median.Salary)[3:4]

#creates and orders all the data into 2 compiled dataframes based on starting and mid career salaries
summaryStart <- data.frame(rbind(caliStart = caliStartAvgAndMed, midWStart = midWStartAvgAndMed, northEStart = northEStartAvgAndMed, southStart = southStartAvgAndMed, westStart = westStartAvgAndMed))
summaryMid <- data.frame(rbind(caliMid = caliMidAvgAndMed, midWMid = midWMidAvgAndMed, northEMid = northEMidAvgAndMed, southMid = southMidAvgAndMed, westMid = westMidAvgAndMed))
summaryStart <- summaryStart[order(-summaryStart$Median),] 
summaryMid <- summaryMid[order(-summaryMid$Median),]

#adds name to the region column, also renaming the others
summaryStart <- setNames(cbind(rownames(summaryStart), summaryStart, row.names = NULL),c("Region","Med", "Avg"))
summaryMid <- setNames(cbind(rownames(summaryMid), summaryMid, row.names = NULL),c("Region","Med", "Avg"))

#conclusion is that californian and northeastern regions are most "profitable" in terms of salary when attending colleges in those regions
#2nd conclusion is that southern mid career salary is apparently more profitable than the west, so maybe biting the bullet and getting education there could be a better choice for some, Even the starting average salary for the southern schools was higher than the western schools' starting average.

#converts the Region columns as factor to preserve order in the ggplot graphs
summaryStart$Region <- factor(summaryStart$Region, levels = summaryStart$Region)
summaryMid$Region <- factor(summaryMid$Region, levels = summaryMid$Region)

startingGraphics <- ggplot(summaryStart, aes(Region, Med, fill = Region)) + geom_col(color = "black") + ggtitle("Starting Career Salary By Median")
midGraphics <- ggplot(summaryMid, aes(Region, Med, fill = Region)) + geom_col(color = "black") + ggtitle("Mid Career Salary By Median")

#final outputs
summaryStart
summaryMid
startingGraphics
midGraphics

# ******************************** Q2 ********************************

# Within the regions, does a certain college stand out in terms of college type for starting/mid career earnings?

#following subsets into different college types  
engineering <- subset(salariesCollegeType, salariesCollegeType$School.Type == "Engineering")[,c(1:4)]
party <- subset(salariesCollegeType, salariesCollegeType$School.Type == "Party")[,c(1:4)]
liberalArts <- subset(salariesCollegeType, salariesCollegeType$School.Type == "Liberal Arts")[,c(1:4)]
ivyLeague <- subset(salariesCollegeType, salariesCollegeType$School.Type == "Ivy League")[,c(1:4)]
state <- subset(salariesCollegeType, salariesCollegeType$School.Type == "State")[,c(1:4)]

#subsets further by using dplyr's left join by the school names, and filtering by the region
engCali <- na.omit(left_join(engineering, california, by = "School.Name"))[1:5]
engMW <- na.omit(left_join(engineering, midwest, by = "School.Name"))[1:5]
engNE <- na.omit(left_join(engineering, northeast, by = "School.Name"))[1:5]
engS <- na.omit(left_join(engineering, south, by = "School.Name"))[1:5]
engW <- na.omit(left_join(engineering, west, by = "School.Name"))[1:5]

partyCali <- na.omit(left_join(party, california, by = "School.Name"))[1:5]
partyMW <- na.omit(left_join(party, midwest, by = "School.Name"))[1:5]
partyNE <- na.omit(left_join(party, northeast, by = "School.Name"))[1:5]
partyS <- na.omit(left_join(party, south, by = "School.Name"))[1:5]
partyW <- na.omit(left_join(party, west, by = "School.Name"))[1:5]

libCali <- na.omit(left_join(liberalArts, california, by = "School.Name"))[1:5]
libMW <- na.omit(left_join(liberalArts, midwest, by = "School.Name"))[1:5]
libNE <- na.omit(left_join(liberalArts, northeast, by = "School.Name"))[1:5]
libS <- na.omit(left_join(liberalArts, south, by = "School.Name"))[1:5]
libW <- na.omit(left_join(liberalArts, west, by = "School.Name"))[1:5]

ivyNE <- na.omit(left_join(ivyLeague, northeast, by = "School.Name"))[1:5]

stateCali <- na.omit(left_join(state, california, by = "School.Name"))[1:5]
stateMW <- na.omit(left_join(state, midwest, by = "School.Name"))[1:5]
stateNE <- na.omit(left_join(state, northeast, by = "School.Name"))[1:5]
stateS <- na.omit(left_join(state, south, by = "School.Name"))[1:5]
stateW <- na.omit(left_join(state, west, by = "School.Name"))[1:5]


#max starting median for each type and region of school
allSchoolSubsets <- as.vector(list(engCali, engMW, engNE, engS, engW, partyCali, partyMW, partyNE, partyS, partyW, libCali, libMW, libNE, libS, libW, ivyNE, stateCali, stateMW, stateNE, stateS, stateW))
maxStartSchools <- data.frame() #empty dataframe for appending output of forloop to for max starting salaries
maxMedSchools <- data.frame() #empty dataframe for appending output of forloop to for max median salaries

#appends max starting median career salaries
for(schoolRegType in allSchoolSubsets){
  maxStartSchools <- data.frame(rbind(maxStartSchools, schoolRegType[which.max(schoolRegType$Starting.Median.Salary),]))
}
#appends max mid median career salaries
for(schoolRegType in allSchoolSubsets){
  maxMedSchools <- data.frame(rbind(maxMedSchools, schoolRegType[which.max(schoolRegType$Mid.Career.Median.Salary),]))
}

#top 10 schools of every region from starting and median salaries ordered in descending starting/mid career 
#salaries and ascending regions
startMed <- (maxStartSchools[order(-maxStartSchools[,3],maxStartSchools[,5]),][-4])[1:10,]
midMed <- (maxMedSchools[order(-maxMedSchools[,4],maxMedSchools[,5]),][-3])[1:10,]

#uses plyr count function to count the number of occurrrences of each Region or Type for both 
#start and mid career salaries
startMedCountRegion <- count(startMed, 'Region')
startMedCountType <- count(startMed, 'School.Type')
midMedCountRegion <- count(midMed, 'Region')
midMedCountType <- count(midMed, 'School.Type')

# Conclusion: for start median salary, it probably pays off to study at one of the northeastern schools (MIT or Princeton being the highest 2) or 
# an engineering type school (CalTech and  MIT). For Mid Career, better to study at a Liberal Arts or Engineering school
# (Bucknell/MIT/Caltech) and/or institutions in California/Northeast (Dartmouth, Caltech being the highest of them)

# ******************************** Q3 ********************************

#Does the competitiveness of a school (calculated as ratio of school Admissions to Applicants)
#correlate with the expected salary?

#Calculate the ratio of Admissions to Applicants and store in column added to colleges df
colleges$AdmissionRatio <-colleges$Admissions.total/colleges$Applicants.total

#Merge college data with salary data
collegeAndSalariesCollege <- merge(colleges, salariesCollegeType, by.x="Name", by.y = "School.Name")
View(collegeAndSalariesCollege)

#Calculate the correlation coefficient between the Admission Ratio and Mid Career Median Salary
cor(collegeAndSalariesCollege$AdmissionRatio, collegeAndSalariesCollege$Mid.Career.Median.Salary, use = "complete.obs")

#Calculate the individual correlation coefficients for the different school types:
#Engineering, Ivy League, Liberal Arts, Party, State
cor(subset(collegeAndSalariesCollege, School.Type == "Engineering")$AdmissionRatio,subset(collegeAndSalariesCollege, School.Type == "Engineering")$Mid.Career.Median.Salary, use = "complete.obs")
cor(subset(collegeAndSalariesCollege, School.Type == "Ivy League")$AdmissionRatio,subset(collegeAndSalariesCollege, School.Type == "Ivy League")$Mid.Career.Median.Salary, use = "complete.obs")
cor(subset(collegeAndSalariesCollege, School.Type == "Liberal Arts")$AdmissionRatio,subset(collegeAndSalariesCollege, School.Type == "Liberal Arts")$Mid.Career.Median.Salary, use = "complete.obs")
cor(subset(collegeAndSalariesCollege, School.Type == "Party")$AdmissionRatio,subset(collegeAndSalariesCollege, School.Type == "Party")$Mid.Career.Median.Salary, use = "complete.obs")
cor(subset(collegeAndSalariesCollege, School.Type == "State")$AdmissionRatio,subset(collegeAndSalariesCollege, School.Type == "State")$Mid.Career.Median.Salary, use = "complete.obs")

#Group the college data by school type and individually calculate statistics in the groups
summaryInfo <- collegeAndSalariesCollege %>% dplyr::group_by(School.Type) %>% dplyr::summarize(avgSalary=mean(Mid.Career.Median.Salary, na.rm=TRUE), n=n(Mid.Career.Median.Salary, na.rm=TRUE), avgAcceptRate=mean(AdmissionRatio, na.rm=TRUE), sdSalary=sd(Mid.Career.Median.Salary, na.rm=TRUE),sdAdmission=sd(AdmissionRatio, na.rm=TRUE))
View(summaryInfo)


#Plot the data points for all schools
ggplot(collegeAndSalariesCollege)+
  geom_point(aes(x=AdmissionRatio,y=Mid.Career.Median.Salary, colour=School.Type))+
  ggtitle("All schools")

#Plot the data points for the most correlated school type (Engineering) and 
# least correlated school type (State)
ggplot(subset(collegeAndSalariesCollege, School.Type == "Engineering"))+
  geom_point(aes(x=AdmissionRatio,y=Mid.Career.Median.Salary))+
  ggtitle("Engineering Schools")

ggplot(subset(collegeAndSalariesCollege, School.Type == "State"))+
  geom_point(aes(x=AdmissionRatio,y=Mid.Career.Median.Salary))+
  ggtitle("State Schools")

#Perform a box plot on the salaries to examine outlier values
boxplot(collegeAndSalariesCollege$Mid.Career.Median.Salary, main="Salary")

#Determine the outlier values
boxplot.stats(collegeAndSalariesCollege$Mid.Career.Median.Salary)$out

#Based off that data, we filter out salary values >=43900 and <=122000
cor(subset(collegeAndSalariesCollege, Mid.Career.Median.Salary>43900 & Mid.Career.Median.Salary<122000)$AdmissionRatio,subset(collegeAndSalariesCollege, Mid.Career.Median.Salary>43900 & Mid.Career.Median.Salary<122000)$Mid.Career.Median.Salary, use = "complete.obs")

#Conclusion: There is a strong relationship between salary and school competitiveness.
#Therefore it does pay to work hard to get into a good school.
#The correlation is strongest for Engineering schools, and weakest for State schools.
#Even discounting a lot of the outlier values, the correlation is still classified between a
#moderate and strong correlation.

# ******************************** Q4 ********************************

#Does the price of college correlate with salary?

#Calculate the correlation coefficient between the Admission Ratio and Mid Career Median Salary
#names(collegeAndSalariesCollege)
cor(collegeAndSalariesCollege$Tuition.and.fees..2013.14, collegeAndSalariesCollege$Mid.Career.Median.Salary, use = "complete.obs")

#Calculate the individual correlation coefficients for the different school types:
#Engineering, Ivy League, Liberal Arts, Party, State
cor(subset(collegeAndSalariesCollege, School.Type == "Engineering")$Tuition.and.fees..2013.14,subset(collegeAndSalariesCollege, School.Type == "Engineering")$Mid.Career.Median.Salary, use = "complete.obs")
cor(subset(collegeAndSalariesCollege, School.Type == "Ivy League")$Tuition.and.fees..2013.14,subset(collegeAndSalariesCollege, School.Type == "Ivy League")$Mid.Career.Median.Salary, use = "complete.obs")
cor(subset(collegeAndSalariesCollege, School.Type == "Liberal Arts")$Tuition.and.fees..2013.14,subset(collegeAndSalariesCollege, School.Type == "Liberal Arts")$Mid.Career.Median.Salary, use = "complete.obs")
cor(subset(collegeAndSalariesCollege, School.Type == "Party")$Tuition.and.fees..2013.14,subset(collegeAndSalariesCollege, School.Type == "Party")$Mid.Career.Median.Salary, use = "complete.obs")
cor(subset(collegeAndSalariesCollege, School.Type == "State")$Tuition.and.fees..2013.14,subset(collegeAndSalariesCollege, School.Type == "State")$Mid.Career.Median.Salary, use = "complete.obs")

#Conclusion: There is a weak correlation between the cost of your education and the
#salary you will make. The correlation is only between semi and strongly
#statistically significant for Engineering schools.

# ******************************** Q5 ********************************

#Do demographics in students differ between most competitive and least competitive schools?

topTenMostCompetitive <- collegeAndSalariesCollege[order(collegeAndSalariesCollege$AdmissionRatio),]
topTenMostCompetitive <- topTenMostCompetitive[1:10,]
colnames(topTenMostCompetitive)[colnames(topTenMostCompetitive)=="Percent.of.total.enrollment.that.are.American.Indian.or.Alaska.Native"] <- "AmerIndian.AlaskaNative"
colnames(topTenMostCompetitive)[colnames(topTenMostCompetitive)=="Percent.of.total.enrollment.that.are.Asian"] <- "Asian"
colnames(topTenMostCompetitive)[colnames(topTenMostCompetitive)=="Percent.of.total.enrollment.that.are.Black.or.African.American"] <- "Black.AfricanAmer"
colnames(topTenMostCompetitive)[colnames(topTenMostCompetitive)=="Percent.of.total.enrollment.that.are.Hispanic.Latino"] <- "Hispanic.Latino"
colnames(topTenMostCompetitive)[colnames(topTenMostCompetitive)=="Percent.of.total.enrollment.that.are.Native.Hawaiian.or.Other.Pacific.Islander"] <- "NativeHawaiian.PacificIsland"
colnames(topTenMostCompetitive)[colnames(topTenMostCompetitive)=="Percent.of.total.enrollment.that.are.White"] <- "White"
colnames(topTenMostCompetitive)[colnames(topTenMostCompetitive)=="Percent.of.total.enrollment.that.are.two.or.more.races"] <- "Mixed"
colnames(topTenMostCompetitive)[colnames(topTenMostCompetitive)=="Percent.of.total.enrollment.that.are.women"] <- "Women"

summaryInfoTenMostCompet <- topTenMostCompetitive %>% summarize(AmerIndianAlaskaNativeAvg=mean(AmerIndian.AlaskaNative), AsianAvg=mean(Asian),BlackAfricanAmerAverage=mean(Black.AfricanAmer),HispanicLatinAvg=mean(Hispanic.Latino),NativeHawaiiPacificAvg=mean(NativeHawaiian.PacificIsland),WhiteAvg=mean(White),MixedAvg=mean(Mixed),WomenAvg=mean(Women))
summaryInfoTenMostCompet$Competition <- 'MostCompetitive'

topTenLeastCompetitive <- collegeAndSalariesCollege[order(-collegeAndSalariesCollege$AdmissionRatio),]
topTenLeastCompetitive <- topTenLeastCompetitive[1:10,]
colnames(topTenLeastCompetitive)[colnames(topTenLeastCompetitive)=="Percent.of.total.enrollment.that.are.American.Indian.or.Alaska.Native"] <- "AmerIndian.AlaskaNative"
colnames(topTenLeastCompetitive)[colnames(topTenLeastCompetitive)=="Percent.of.total.enrollment.that.are.Asian"] <- "Asian"
colnames(topTenLeastCompetitive)[colnames(topTenLeastCompetitive)=="Percent.of.total.enrollment.that.are.Black.or.African.American"] <- "Black.AfricanAmer"
colnames(topTenLeastCompetitive)[colnames(topTenLeastCompetitive)=="Percent.of.total.enrollment.that.are.Hispanic.Latino"] <- "Hispanic.Latino"
colnames(topTenLeastCompetitive)[colnames(topTenLeastCompetitive)=="Percent.of.total.enrollment.that.are.Native.Hawaiian.or.Other.Pacific.Islander"] <- "NativeHawaiian.PacificIsland"
colnames(topTenLeastCompetitive)[colnames(topTenLeastCompetitive)=="Percent.of.total.enrollment.that.are.White"] <- "White"
colnames(topTenLeastCompetitive)[colnames(topTenLeastCompetitive)=="Percent.of.total.enrollment.that.are.two.or.more.races"] <- "Mixed"
colnames(topTenLeastCompetitive)[colnames(topTenLeastCompetitive)=="Percent.of.total.enrollment.that.are.women"] <- "Women"
summaryInfoTenLeastCompet <- topTenLeastCompetitive %>% summarize(AmerIndianAlaskaNativeAvg=mean(AmerIndian.AlaskaNative), AsianAvg=mean(Asian),BlackAfricanAmerAverage=mean(Black.AfricanAmer),HispanicLatinAvg=mean(Hispanic.Latino),NativeHawaiiPacificAvg=mean(NativeHawaiian.PacificIsland),WhiteAvg=mean(White),MixedAvg=mean(Mixed),WomenAvg=mean(Women))
summaryInfoTenLeastCompet$Competition <- 'LeastCompetitive'

allCompetition <- rbind(summaryInfoTenMostCompet,summaryInfoTenLeastCompet)
View(allCompetition)

#Conclusion: across Most competitive schools, there tends to be more diversity in demographics
#than in less competitive schools.