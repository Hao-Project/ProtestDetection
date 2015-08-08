# ProtestDetection
The goal of this project is to develop an online protest post detector for Chinese social media using text mining and NLP techniques. 

My text classification model uses data collected by a Chinese activist, Lu Yuyu. The link to the original data is:  https://drive.google.com/folderview?id=0B0uuBN7M-RpXZ1NndXBPNmRobEU See http://foreignpolicy.com/2014/04/03/meet-chinas-protest-archivist/ for a report of Lu and his dataset. 

Until April 13th, 2015, the dataset includes 505 text files. These text files include a total of 130,795 social media posts that contain information about 27,608 protests happened between Nov 2013 to Apr 2015 (54.7 protests per day).

# Description of the files: 
## downLoad.R, readText.R 
downloads and reads the text data 

## readKeyWords.R
separates the Chinese words and collects the Top 100 keywords.

## transWord 
translates the Chinese keywords into English with Google Translator API

## drawTimeTrend.R
draws the time trend of the number of events per day in protestTrend.png. 

## drawWordCloud.R 
draws a word cloud of the keywords in wordcloud.png. 
