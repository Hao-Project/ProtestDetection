# Draw time trend graph of daily protest

library(ggplot2)
library(RColorBrewer)

setwd("C:/Dropbox/Programming/R/Project/RData")
load("Textdata.RData")

spFest14 <- as.Date("2014-1-31")
spFest15 <- as.Date("2015-2-19")

data$day <- weekdays(data$date)
sumDay <- tapply(data$nEvents, data$day, sum,na.rm= TRUE)
countDay <- tapply(!data$missing, data$day, sum,na.rm= TRUE)
averageDay <- sumDay/ countDay
averageDay

pal <- brewer.pal(7, "Set1")

png("protestTrend.png", width=1280,height=800)
p <- ggplot(data = data, aes (x=date, y=nEvents), points)
p <- p + geom_point(aes(color = data$day)) 
p <- p + geom_vline(xintercept = as.numeric(spFest14),linetype=4)
p <- p + geom_vline(xintercept = as.numeric(spFest15),linetype=4)
p <- p + ylab("Number of Protests") + xlab("Time")
p <- p + ggtitle("Number of Protests per Day in China Collected from Social Media")
p <- p + theme(plot.title = element_text(lineheight=4.5, face="bold", size = 20))
p <- p + annotate("text", label = "Chinese New Year", x = spFest14 + 4, y = 400, size = 6)
p <- p + annotate("text", label = "Chinese New Year", x = spFest15 + 4, y = 400, size = 6)
p <- p + geom_smooth(method = "lm")
print(p)
dev.off()


