# Translate most frequent words to prepare for wordcloud graph

library(jsonlite)

setwd("C:/Dropbox/Programming/R/Project/RData")
load("SegmentedWord.RData")

# Translate Chinese key words to English and create a word cloud
gapi <- 'AIzaSyA-3S8z1TOrUbCuQK4BbvssoDFlOwJhB-0'
setInternet2(use = TRUE)

translateS <- function (x,gapi){
  base <- 'https://www.googleapis.com/language/translate/v2?'
  key.str <- paste('key=', gapi, sep = '')
  query <- paste('&q=', x , sep = '')
  st.str <- paste('&source=zh-CN&target=en', sep = '')  
  url <- paste(base, key.str, query, st.str, sep = '')
  
  t <- fromJSON(url)$data$translations[[1]]
  return(t)
}


translate <- function (contents, gapi){
  t <- unname(
    unlist(
      lapply(contents, function(x) translateS(x, gapi))
    )
  )  
  return(t)    
}

length(wordList)

sorted1000 <- sorted[1:1000]
chNames <- names(sorted1000)
enNames <- translate(chNames,gapi) 

save(sorted1000, chNames, enNames, file = "wordCloud.RData")

