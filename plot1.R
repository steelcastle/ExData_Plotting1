## =======================================================================================
## plot1.R
## =======================================================================================
## Perform setup tasks which are common to all plotting exercises 1-4.
##
##
## Check if raw data file exists in current working directory
## - if not, then download and unzip it.
##
if(!file.exists("household_power_consumption.txt"))
{
        ePwrConUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2)Fhousehold_power_consumption.zip"
        download.file(ePwrConUrl,destfile="household_power_consumption.zip")
        unzip("household_power_consumption.zip")
}
##
## Read 1st row to get column names and save for future use
##
pwrNames<-read.table("household_power_consumption.txt",header=F,sep=";",stringsAsFactors=F,nrows=1)
##
## In order to speed up the exploratory analysis process we will only
## read a subset of records from the raw data file based on selected row
## numbers. This selection is determined by calculating the time difference between the first observation record in the file
## and the first observation for Feb. 1 2007. This time difference is then multiplied by 24 hours and then 
## 60 since there are 60 observations per hour (one per minute). This yields the starting row number
## for Feb 1st, 2007 which happens to be 66637 + 1 (accounting for header row).
## 
## One can also use visual inspection of the raw data file
## (using the Notepad++ utility) to determine that the starting row for Feb. 1/2007 00:00:00 is #66638
## and we will read the subsequent 2880 observations to cover the required 2 days
## (one observation every minute x 60 minutes/hr. x 48 hours)
## 
feb0102Pwr<-read.table("household_power_consumption.txt",header=F,sep=";",stringsAsFactors=F,skip=66637,nrows=2880,na.strings="?")
##
## Reassign column names to our new subset of observations
##
names(feb0102Pwr)<-unlist(pwrNames)
##
## Convert the column named "Date" to an actual Date format
##
feb0102Pwr$Date<-as.Date(feb0102Pwr$Date,"%d/%m/%Y")
##
## Now we create a new column which will contain the associated date/time
## value in a date and time format. The converted date column from above is
## concatenated with the Time column and converted to a Date/Time class.
## 
feb0102Pwr$DateTime<-strptime(paste(feb0102Pwr$Date,feb0102Pwr$Time),"%Y-%m-%d %H:%M:%S")
##
## =======================================================================================
##
## Plot1 - histogram of global active power over the required period of
##         February 1st - 2nd, 2007
##
## Open a png device to accept the plot
##
png("plot1.png", width=480, height=480)
##
## Plot the frequency histogram for the Global Active Power column
##
hist(feb0102Pwr$Global_active_power,col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
##
## Close the png image file by turning off the device
##
dev.off()
##
## EOF