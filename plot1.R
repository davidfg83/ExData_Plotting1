#check if data exists; otherwise download, unzip
if(!file.exists("./household_power_consumption.txt")){
        #download data in zip format
        fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileUrl, destfile = "rawdata.zip")
        #unzip the data;
        unzip("rawdata.zip")
}

#read data; choose read.csv2 because data separated by ";" and headers in first row
db <- read.csv2("./household_power_consumption.txt", na = "?")

# correctly format dates, time variables
db$Date <- as.Date(db$Date, "%d/%m/%Y")
db$Time <- strptime(paste(db$Date, db$Time), "%d/%m/%Y %H:%M:%S")

#subset relevant data
mydata <- subset(db, db$Date >= "2007-02-01" & db$Date <= "2007-02-02")

#convert measured variables from character to numeric (I don't do it to whole database to save processing time)
mydata[, 3:9] <- apply(mydata[, 3:9],2, as.numeric)

##HISTOGRAM 
#open png file
png(filename = "plot1.png")
# set margins
par(mar = c(4, 4, 2, 0))
#create histogram (Background = "#DADADA"; letters = "#131F24"; red = "#F53446"; blue = "#459DE0")
hist(mydata$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylim = c(0, 1200) , col = "#459DE0", col.axis = "#131F24", col.lab = "#131F24", col.main = "#131F24")
dev.off()