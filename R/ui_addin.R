library(shiny)
library(miniUI)

# Supporting functions
create_image_div <- function(id, url, img_size) {
  div(style = "display:inline-block;margin:5px;",
    tags$img(src = url, width = img_size, height = img_size),
    p(id),
    actionButton(paste0("button",id), "+", style = "margin:1px;")
  )
}

# Main addin function
nounAddin <- function() {
  
  ui <- miniPage(
    gadgetTitleBar("Noun Project Icons Search"),
    miniContentPanel(
      div(style = "display:inline-block",
          textInput("search", "What icon do you want to find?")),
      div(style = "display:inline-block",
          actionButton("searchButton", "Search")),
      div(uiOutput("images"), id = "imagesFrame"),
      div(p("Selected icons:"),
          verbatimTextOutput("selection", placeholder = TRUE),
          actionButton("clear", "Clear selection"))
    )
  )
  
  server <- function(input, output, session) {
    img_size = "60px"
    obs_list <- list()
    icons_selection <- c()

    observeEvent(input$done, {
      timeText <- paste0("\"", as.character(Sys.time()), "\"")
      #rstudioapi::insertText(timeText)
      rstudioapi::sendToConsole(paste(icons_selection, collapse=","),
                                execute = F)
      stopApp()
    })
    observeEvent(input$cancel, {
      stopApp(NULL)
    })

    observeEvent(input$searchButton, {
      imlist <- tryCatch({
        get_icon_by_term(input$search, 20)
      }, error = function(e) {
        NULL
      })
      
      imurls <- get_icons_urls(imlist)

      output$images <- renderUI({
        validate(
          need(length(imurls) != 0, message = paste0("A problem with search occured!\n",
                                                     "Try searching for a different term.\n")
               )
        )
        
        lapply(imurls,
               function(x) {
                 btn_name <- paste0("button", x$id)
                 obs_list[[btn_name]] <<- observeEvent(input[[btn_name]], {
                   icons_selection <<- c(icons_selection, x$id)
                   output$selection <- renderText({ icons_selection })
                 })
                 create_image_div(x$id, x$url, img_size)
                }
        )
      })
    })
    observeEvent(input$clear, {
      icons_selection <<- c()
      output$selection <- renderText({ "" })
    })
  }
  viewer <- paneViewer(300)
  runGadget(ui, server, viewer = viewer)
}
