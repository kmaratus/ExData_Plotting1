##read data header into R
filename<-"household_power_consumption.txt"
header<-read.table(filename,header=TRUE,sep=";",na.strings = "?",nrow=1)
columnnames<-names(header)
ncolumn<-length(columnnames)

##read first column to find start and end date number rows
data<-read.table(filename,header=TRUE,sep=";",na.strings = "?",colClasses = c(NA,rep("NULL",ncolumn-1)))
dataDate<-as.Date(data$Date,"%d/%m/%Y")
nstart<-which.max(dataDate=="2007-02-01")
nend<-which.max(dataDate=="2007-02-03")-1

##read data into R for the given dates
data<-read.table(filename,header=TRUE,sep=";",na.strings = "?",col.names = columnnames,skip = nstart-1,nrows = nend-nstart+1)

##make a plot and save it into PNG file
png(filename = "plot3.png",width = 480,height = 480,bg="transparent")
##combine date and time into one variable
DateTime<-as.POSIXct(paste(data$Date,as.character(data$Time)),format="%d/%m/%Y %H:%M:%S")

plot(DateTime,data$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(DateTime,data$Sub_metering_1,col="black")
lines(DateTime,data$Sub_metering_2,col="red")
lines(DateTime,data$Sub_metering_3,col="blue")
legend("topright",lty = c(1,1,1),col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()