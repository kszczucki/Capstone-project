shinyUI(fluidPage(
        
        
        titlePanel("Capstone Project - next word prediction"),
                
        sidebarLayout(
                sidebarPanel(
                        helpText("Type a phrase in the input box and press SUBMIT do get a prediction of a single word."),
                        textInput('textInput', "Text Input"),
                        actionButton("action", "SUBMIT", icon("paper-plane"), 
                                style="color: #fff; background-color: #337ab7; border-color: #2e6da4"),
                        helpText("At the first use, you will have to wait a while due to the loading of the model, after it
                                 the application should react faster"),
                        tags$head(tags$style("#text1{color: red;
                                 font-size: 20px;
                                 font-style: italic;
                                 }")),
                        tags$head(tags$style("#textOutput{color: black;
                                 font-size: 20px;
                                 font-style: solid;
                                 }")),
                        hr()
                ),
                               
                mainPanel(
                        tabsetPanel(
                                tabPanel("Prediction", verticalLayout(
                                        hr(),
                                        verbatimTextOutput("text1"),
                                        hr(),
                                        verbatimTextOutput("textOutput")),
                                        hr()
                                ),
                                tabPanel("Instructions",verticalLayout(
                                        h3("Main instructions:"),
                                        br(),
                                        p("* Type a phrase (",strong("in english"),") in the input box and press", span("SUBMIT",style = "color:blue"), "do get a prediction of a single word."),
                                        p("* At the first use, you will have to wait a while due to the loading of the model, after it
                                 the application should react faster"),
                                        
                                        h3("About prediction algorithm:"),
                                        p("*  Based on the Katz backoff algorithm and the full set of {2,3,4}-grams."),
                                        p("* According to wikipedia definition Katz back-off is a generative n-gram language model that estimates the conditional probability of a word given its history in the n-gram. It accomplishes this estimation 
                                          by “backing-off” to models with smaller histories under certain conditions."),
                                        p("*  Using author's function for cleaning data"),
                                        p("*  User input sentence is truncate to the last 1 to 4 words"),
                                        br(),
                                        br(),
                                        p("*  Code can be found ", a("here", 
                                                                    href = "https://github.com/kszczucki?tab=repositories"))
                                        ))
                                )
                        )
                )
        ))