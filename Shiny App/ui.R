shinyUI(pageWithSidebar(
    headerPanel("Protests in China: Summary Statitics"),
    sidebarPanel(
        h2("Choose Dates:"),
        dateRangeInput("dateRange", "Date range", start = "2014-01-01", min = "2014-01-01", end = "2015-08-16", max = "2015-08-16")
    ),
    mainPanel(
        h2('Statistics'),
        textOutput('dateDisplay'),
        textOutput('meanDisplay'),
        h2('Trend'),        
        plotOutput('trendplot'),
        h3('Introduction to the Data: '),
        p('Data collected by Lu Yuyu, a Chinese grassroot activist.'),
        HTML('His twitter: <a href = "https://twitter.com/wickedonnaa">@wickedonnaa</a>, 
            his blog: <a href = http://newsworthknowingcn.blogspot.jp/>http://newsworthknowingcn.blogspot.jp</a>. <br> <br> 
            See this Foreign Policy <a href ="http://foreignpolicy.com/2014/04/03/meet-chinas-protest-archivist"> article </a>
            for a report of Lu and his dataset. The dataset is downloadable at '),
        a('https://drive.google.com/folderview?id=0B0uuBN7M-RpXZ1NndXBPNmRobEU')
    )
))