source("BuildLoadModel.R")


predict <- function(inputText) {
                
                getPred(inputText)
                
        } 


shinyServer(
        
        
        function(input, output) {
                inputText <- eventReactive(input$action, {
                        input$textInput
                })
                
                output$textOutput <- renderText({
                        prediction = predict(inputText())
                        paste0("Our prediction: ", prediction, sep="", collapse="")
                })
                
                output$text1 <- renderText({ 
                        paste("Your phrase:", input$textInput)
                })
        }
)