library(ggplot2)

load("data/countData.RData")

shinyServer(
    function(input, output){

        # Draw Graph        
        output$trendplot <- renderPlot({
            # Subset Data according to the date range
            dataUse <- countData[countData$date >= input$dateRange[1] & countData$date <= input$dateRange[2] ,]
            
            # Draw the trend of number of protests per day. 
            p <- ggplot(dataUse, aes(date, nEvents)) + geom_point() + geom_smooth() + 
                labs(title = 'Number of protests in China reported on Social Media', x = 'Date', y = 'Number of protests')
            print(p)
        })
        
        # Show dates        
        output$dateDisplay <- renderText({
            paste0('Between ', input$dateRange[1], ' and ', input$dateRange[2],',')
        })
        
        # Show Mean
        output$meanDisplay <- renderText({
            dataUse <- countData[countData$date >= input$dateRange[1] & countData$date <= input$dateRange[2] ,]
            m <- mean(dataUse$nEvents,na.rm = TRUE)          
            paste0("the average number of protests per day is ", format(m,digits = 1,nsmall = 1))
        })
    }
)
