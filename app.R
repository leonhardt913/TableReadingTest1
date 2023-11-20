library(shiny)
library(shinycssloaders)



ui <- fluidPage(
  navbarPage(title = "PPI tool",

             #==============================Main page================================#
             tabPanel("Home",

                      titlePanel(h1("Welcome ",align="center",style="color: skyblue")),

             ),


             #==============================Analysis page================================#
             tabPanel("Analysis",

                      fluidRow(


                        sidebarLayout(
                          sidebarPanel(


                            #输入主要data
                            fileInput("file1", "Choose CSV file", accept = ".csv"),

                          ),

                          mainPanel(

                            tabsetPanel(

                              #loading effect withspinner()
                              tabPanel("List",withSpinner(tableOutput("contents"))),

                            )
                          ),

                        )

                      )
             ),

             #==============================Documentation================================#

             tabPanel("Documentation",
                      mainPanel(

                        h2("Preparation of data sheet"),


                      )
             ),

             #==============================About===============================#

             tabPanel("About",
                      mainPanel(

                        p("by Wu and Zhang Ph.D"),
                        br(),


                      )
             )

  )
)

#################################################################################################
#=======================================   Server   ============================================#
#################################################################################################

server <- function(input, output) {

  getData1 <- reactive({

    file <- input$file1
    ext <- tools::file_ext(file$datapath)

    req(file)
    validate(need(ext == "csv", "Please upload a csv file"))

    #------------------读取数据后开始处理数据---------------#

    data1 <- read.csv(file$datapath, header = T)

    data1

  })


  output$contents  <-  renderTable({

    data <- getData1()

    data

  })




}



shinyApp(ui, server)
