# Download Lu Yuyu's daily protest data to local text files
# Read Google Document address from .gdoc files and download them from Google Drive
gFileFolder <- "C:/Google Drive/每日统计/"
saveFolder <- "C:/Dropbox/Programming/R/Project/TextData/"

date <- seq(as.Date("2013-11-21"), as.Date("2015-04-09"), by="+1 day")
numDays <- length(date)
data <- data.frame(date)

data$missing <- logical(numDays)

# Download data from Google Doc files
data$sDate <- as.character(data$date)
year <- substr(data$sDate, 1, 4)
gFileName <- paste(gFileFolder, year, "/", data$sDate,".gdoc",sep = "")   
data$destFile <- paste(saveFolder,data$sDate,".txt",sep = "")
start <- match("2013-12-12", data$sDate)

for (i in start:numDays) {
  if( !file.exists(gFileName[i]) & data$sDate！="2014-07-19" ){
    data$missing[i] <- TRUE
  }
  else{
    temp <- read.table(gFileName[i])
    fileId <- toString(temp$V6)
    url <- paste("http://docs.google.com/document/d/", fileId,"/export?format=txt",sep = "")  
    download.file(url, data$destFile[i], mode = "wb")      
  }
}

sum(data$missing)
data$date[data$missing]

setwd("C:/Dropbox/Programming/R/Project/RData")
save(data,numDays,saveFolder,file = "data.RData")
