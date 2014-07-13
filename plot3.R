#############################################################################
####                                                                     ####
####                        R Code - plot3.R                             ####
####                        ----------------------                       ####
####                              July 2014                              ####
####                      Author: Dinesh Srivastava                      ####
####                 Script: Exploratory Data Analysis                   ####
####                                                                     ####
#############################################################################

##  GENERAL HOUSKEEPING
#####################################################################
# Set the working directory (WD)
projectWD <- "C:/Users/DKSrivastava/Desktop/R-Prog-Coursera/"
setwd(projectWD)
getwd()

## Note: library(package) and require(package) both load the namespace of the 
## package with name package and attach it on the search list. require is 
## designed for use inside other functions; it returns FALSE and gives a 
## warning (rather than an error as library() does by default) if the package 
## does not exist. Both functions check and update the list of currently 
## attached packages and do not reload a namespace which is already loaded.

if (!require("datasets")) {
        install.packages("data.table")
}
if (!require("data.table")) {
        install.packages("data.table")
}

library("datasets")
library("data.table")


##  DOWNLOADING THE DATA
#####################################################################

# The data file was manually downloaded from given url ("https://d396qusza40orc.
# cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip") in the 
# workdirectory represented by getwd(). The "household_power_consumption.zip" 
# was unzipped in the working directory to create the required input file
# "household_power_consumption.txt".

# Though this step could be automated through R script but was performed 
# manually because it was not a project requirement.

#fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#destfile <- "C:/Users/DKSrivastava/Desktop/R-Prog-Coursera/household_power_consumption.zip"
#download.file(fileUrl, destfile, method = "curl")
#unzip(destfile)
# Creates the "household_power_consumption.txt" file! in working directory


##  LOADING THE DATA
#####################################################################
#When loading the dataset into R, please consider the following:
#The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate
#of how much memory the dataset will require in memory before reading into R.
#Make sure your computer has enough memory (most modern computers should be fine).
        #We will only be using data from the dates 2007-02-01 and 2007-02-02.
        #One alternative is to read the data from just those dates rather than reading
        #in the entire dataset and subsetting to those dates.
#You may find it useful to convert the Date and Time variables to Date/Time
#classes in R using the strptime() and as.Date() functions.
        #Note that in this dataset missing values are coded as ?.

# Read Household power consumption data.
#####################################################################

## Getting full dataset
hpcData <- data.table(read.csv("./household_power_consumption.txt", header=T, sep=";", na.strings="?"))
hpcData$Date <- as.Date(hpcData$Date, format="%d/%m/%Y")

## Subsetting the data
hpcDatasubset <- subset(hpcData, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
#rm(hpcData)

## Converting dates
datetime <- paste(as.Date(hpcDatasubset$Date), hpcDatasubset$Time)
hpcDatasubset$Datetime <- as.POSIXct(datetime)


##  PLOTTING
#####################################################################

## Plot 3 : Energy Sub Metering Vs. Datetime
## +++++++++++++++++++++++++++++++++++++++++++
with(hpcDatasubset, {
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=0.5, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving the plot to a file
dev.copy(png, file="plot3.png", height=480, width=480)

## Closing the graphic device
dev.off()


