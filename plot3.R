## =======================================================================================
## plot3.R
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
## numbers. This selection is determined by visual inspection of the raw data file
## (using the Notepad++ utility). The starting row for Feb. 1/2007 00:00:00 is #66637
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
## Plot3 - plot of 3 sets of submetering values over the required period of
##         February 1st - 2nd, 2007
##
## Open a png device to accept the plot
##
png("plot3.png", width=480, height=480)
##
## Plot the 3 sets of sub-metering values versus the actual Date/Time
##
plot(feb0102Pwr$DateTime,feb0102Pwr$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering")
lines(feb0102Pwr$DateTime,feb0102Pwr$Sub_metering_2,col="red")
lines(feb0102Pwr$DateTime,feb0102Pwr$Sub_metering_3,col="blue")
##
##
## Add the legend with appropriate labels and colours
##
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty="solid")
##
## Close the png image file by turning off the device
##
dev.off()
##
## EOF