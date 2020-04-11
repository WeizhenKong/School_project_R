library(shiny)
library(dplyr)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$datatable <- renderTable({
        data = input$csvInput
        dataPath = data$datapath[1]
        
        if (!is.null(dataPath)){
            football = read.csv(dataPath)
            table_df <- football %>% filter(practiceormatch == input$mop, goal == input$yon)
            table_df
        }else{}
    })
    
    output$distPlot <- renderPlot({

        data = input$csvInput
        dataPath = data$datapath[1]
        if(!is.null(dataPath)){
            result = read.csv(dataPath)
            plot_df <- result %>% filter(practiceormatch == input$mop,goal == input$yon)
            ggplot(plot_df,aes(x=yards)) + geom_bar() + labs(x="yards", y="count")
        } else {}

    })

})
