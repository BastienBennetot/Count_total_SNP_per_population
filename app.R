library(shiny)
library(DT)
library(tidyverse)
options(shiny.maxRequestSize=3000*1024^2)
# Define UI for data upload app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel(title = h1("Count SNP present in a subset of sample :", align = "center")),
  tabsetPanel(tabPanel("Input and Results", fluid = TRUE,
  # Sidebar layout with input and output definitions ----
        sidebarLayout(
    # Sidebar panel for inputs ----
            mainPanel(
      # Input: Select a file ----
                fileInput("uploaded_file", "Import your VCF File here (vcf.gz)",
                    multiple = F,
                    accept = c("vcf.gz","vcf")),
      # Horizontal line ----
                tags$hr(),
      # Select variables to display ----
                uiOutput("checkbox")
      ),
    
    # Main panel for displaying outputs ----
          sidebarPanel("Number of SNP within these sample(s):",
                       helpText("It may take a moment to be refreshed. Refreshed counts will appear in black font"),
                       actionButton("go", "Go"),
                       textOutput("count")
                       )
    )
  ),
  tabPanel("Do it with name stored in population file", fluid = TRUE,helpText("Follow this link https://github.com/BastienBennetot/Count_total_SNP_per_population/blob/main/Fast_bash_command_to_count_SNP_for_one_population"))))

# Define server logic to read selected file ----
server <- function(input, output, session) {
  # Dynamically generate UI input when data is uploaded ----
  output$checkbox <- renderUI({
                      checkboxGroupInput(inputId = "select_var", 
                                         label = "Select variables", 
                                         inline = TRUE,
                                         choices = (system(paste0("bcftools query -l ",req(input$uploaded_file$datapath)),intern = T)))
                              })
  
  #Once button pressed calculate the number of snp
  output$count <-eventReactive(input$go,{
    pop=paste(req(input$select_var),collapse = ",")#Collapse the sample list
    system(paste0("bcftools view -s ",pop ," ",req(input$uploaded_file$datapath),"|bcftools +fill-tags  -- -t AF |bcftools query -f '%AF\n'  -i'GT=\"alt\"'|grep \"\\.\"| wc -l"),intern = T)
  }) 

}
# Create Shiny app ----
shinyApp(ui, server)
