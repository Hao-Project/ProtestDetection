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
        cline <- gsub("^.*?��","",cline) 
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

dict <- c('����','����','����','����','����','����','����','����'
          ,'ͬʱ','��ʼ','����','�Ѿ�','����','Ŀǰ','֮��','֮ǰ','�ղ�','һֱ'
          ,'����','����','��Щ','���','��Щ','����','�Ǹ�','���'
          ,'����','ʲô','��ô','��ô','��ô'
          ,'����','����','����','����','����','���','�Լ�','����'
          ,'һ��','��Щ','һЩ','����','����','�ֳ�'         
          ,'û��','��Ϊ','����','����','����','�ٴ�','Ϊ��','��Ȼ'
          ,'�Ѿ�','����','Ϊʲô','��Ȼ','���','����','����','����'
          ,'һ��','����','һ��','����','ȫ��','ȫ��','����'
          ,'����','����','����','����','����'
          ,'����','����','����','����','����','����')
wordList <- wordList[!wordList %in% dict]

head(wordList)
sum(nchar(wordList))

sorted <- sort(table(wordList), decreasing=TRUE)
sorted[1:100]

save(word,wordList, sorted, file = "SegmentedWord.RData")

