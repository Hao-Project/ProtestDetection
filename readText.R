# Read Protest data from text files
setwd("C:/Dropbox/Programming/R/Project/RData")
load("data.RData")
setwd(saveFolder)

destFile <- paste(saveFolder,data$sDate,".txt",sep = "")

# textData is a list of length of numDays, with each element contains the lines of that day's text Data
textData <- replicate(numDays,as.character())

# data$firstline contains the first line of text Data
data$firstline <- character(numDays)  
# data$nEvents contains the number of protests in that day
data$nEvents <- numeric(numDays) 
# data$textLength contains the number of lines in that day's text data
data$textLength <- numeric(numDays)

for (i in 1:numDays) {
for (i in 55) {    
  if(!data$missing[i]){
    textData[[i]] <- readLines(destFile[i], encoding = 'UTF-8')    
    data$firstline[i] <- textData[[i]]   
    data$textLength[i] <- length(textData[[i]])
  }
}

summary(data$textLength)
data$date[data$textLength < 10]

data$nEvents <- numeric(numDays)

for (i in 1:numDays) {
  if(!data$missing[i]){    
    # Split the number in the first line of the document    
    numlist <- strsplit(data$firstline[i],"[^0-9]+")
    num <- numlist[[1]][2]
    if (!is.na(num))
      data$nEvents[i] <- as.numeric(num)
    else
      data$nEvents[i] <- as.numeric(numlist[[1]][1])    
  }else{
    data$nEvents[i] <- NA
  }
}

save(data,textData,numDays,saveFolder,file = "TextData.RData")


