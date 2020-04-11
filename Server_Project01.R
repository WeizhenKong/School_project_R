#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readxl)
library(ggplot2)
library(tm)
library(wordcloud)
library(memoise)
library(SnowballC)
library(RColorBrewer)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$description <- renderText({
        
        "The Forbes Global 2000 is an annual ranking of the top 2,000 public companies in the world by Forbes magazine. The ranking is based on a mix of four metrics: sales, profit, assets and market value. The list has been published since 2003.  The Forbes Global 2000 is a useful indicator of which are the leading public companies in the world, but it is only an interpretation, as only public companies are listed. The results are not definitive; any change to the criteria would produce a different list."
    })

    
    
    output$distPlot<- renderPlot({
        data = input$csvInput
        dataPath = data$datapath[1]
        if(!is.null(dataPath)){
            result = read.csv(dataPath)

            g <- ggplot(result, aes(x = country, fill = category)) + geom_bar() +
                xlab('Country') +
                ylab('Category') + 
                guides(fill=guide_legend(title="Type of companies"))
            g
        } else {}
    })
    
    output$interactive<- renderPlot({
        data = input$csvInput
        dataPath = data$datapath[1]
        if(!is.null(dataPath)){
            result = read.csv(dataPath)
            plot_df <- result %>% filter(country == input$country,category == input$category)
            #ggplot(plot_df,aes(x=marketvalue)) + geom_bar() + labs(x="name", y="count")
            
            ggplot(plot_df, aes(x=assets, y=marketvalue,color=name)) +
                geom_point(size = 5) +
                labs(title="Market value vs assets")
        } else {}
        
        
    })
    
    output$datatable<- renderTable({
        data = input$csvInput
        dataPath = data$datapath[1]
        
        if (!is.null(dataPath)){
            result = read.csv(dataPath)
            table_df <- result %>% filter(country == input$country,category == input$category)
            table_df
        }else{}
    })
    output$plot <- renderPlot({
        filePath <- "http://www.sthda.com/sthda/RDoc/example-files/martin-luther-king-i-have-a-dream-speech.txt"
        text <- readLines(filePath)
        docs <- Corpus(VectorSource(text))
        inspect(docs)
        toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
        docs <- tm_map(docs, toSpace, "/")
        docs <- tm_map(docs, toSpace, "@")
        docs <- tm_map(docs, toSpace, "\\|")
        # Convert the text to lower case
        docs <- tm_map(docs, content_transformer(tolower))
        # Remove numbers
        docs <- tm_map(docs, removeNumbers)
        # Remove english common stopwords
        docs <- tm_map(docs, removeWords, stopwords("english"))
        # Remove your own stop word
        # specify your stopwords as a character vector
        docs <- tm_map(docs, removeWords, c("blabla1", "blabla2")) 
        # Remove punctuations
        docs <- tm_map(docs, removePunctuation)
        # Eliminate extra white spaces
        docs <- tm_map(docs, stripWhitespace)
        dtm <- TermDocumentMatrix(docs)
        m <- as.matrix(dtm)
        v <- sort(rowSums(m),decreasing=TRUE)
        d <- data.frame(word = names(v),freq=v)
        head(d, 10)
        set.seed(1234)
        wordcloud(words = d$word, freq = d$freq, min.freq = input$freq,
                  max.words=input$max, random.order=FALSE, rot.per=0.35, 
                  colors=brewer.pal(8, "Dark2"))
        
})
})
