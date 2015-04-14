# Read text data and return segmented words in lines of social media posts
# Cannot run in R 3.1.2 or higher version. Works in R 3.0.2
library(Rwordseg)

setwd("C:/Dropbox/Programming/R/Project")
load("TextData.RData")

# Close recognition of Chinese names
# segmentCN(doc,recognition=F)

# Returns the whole list of 
word <- replicate(numDays,as.character())


for (i in 1:numDays){        
  if(!data$missing[i]){   
    j = 3    
    k = 0
    l <- data$textLength[i]    
    while (j <= l) {
      line <- textData[[i]][j]      
      if( nchar(line) >= 8){
        cline <- gsub("[0-9]","",line)                
        cline <- gsub("[A-z]","",cline)                                
        cline <- gsub("^.*?】","",cline) 
        cline <- gsub("/","",cline)
        if( nchar(cline) >= 8){
          Encoding(cline) <- "UTF-8"
          cline <- iconv(cline, "UTF-8", "UTF-8",sub='') ## replace any non UTF-8 by ''  
          wordSeg <- segmentCN(cline)    
          k = k + 1
          word[[i]] <- append(word[[i]], wordSeg)        
        }
      }
      j = j + 1 
    }
    data$nPosts <- k
  }
  if (i %% 50 == 0){
    print(paste(as.character(10 * i%/% 50)," % finished!"),sep = "")
  }
}

sum(data$nPosts)

# Save the segmented textdata to file
wordList <- as.character()
for (i in 1:numDays){
  wordList <- append(wordList, word[[i]])
}

sum(nchar(wordList))

wordList <- wordList[nchar(wordList) >= 2]

dict <- c('今天','晚上','白天','上午','下午','中午','昨天','早上'
          ,'同时','开始','现在','已经','今日','目前','之后','之前','刚才','一直'
          ,'这里','这样','这些','这个','那些','那样','那个','这边'
          ,'何在','什么','这么','那么','怎么'
          ,'我们','他们','你们','她们','它们','大家','自己','有人'
          ,'一个','有些','一些','附近','当地','现场'         
          ,'没有','因为','所以','但是','甚至','再次','为了','虽然'
          ,'已经','可以','为什么','居然','如果','还是','或者','由于'
          ,'一起','所有','一下','几个','全部','全体','还有'
          ,'问题','过程','东西','多少','基本'
          ,'发生','引起','进行','可以','事情','不能')
wordList <- wordList[!wordList %in% dict]

head(wordList)
sum(nchar(wordList))

sorted <- sort(table(wordList), decreasing=TRUE)
sorted[1:100]

save(word,wordList, sorted, file = "SegmentedWord.RData")


