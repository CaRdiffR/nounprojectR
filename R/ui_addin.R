library(shiny)
library(miniUI)

nounAddin <- function() {
  
  ui <- miniPage(
    gadgetTitleBar("nounprojectIcons"),
    miniContentPanel(
      div(style = "display:inline-block",
          textInput("search", "Some icon name")),
      div(style = "display:inline-block",
          actionButton("searchButton", "Search")),
      div(uiOutput("images"))
    )
  )
  
  server <- function(input, output, session) {
    img_size = "60px"
    observeEvent(input$done, {
      timeText <- paste0("\"", as.character(Sys.time()), "\"")
      # rstudioapi::insertText(timeText)
      stopApp()
    })
    observeEvent(input$cancel, {
      stopApp(NULL)
    })
    observeEvent(input$searchButton, {
      imlist <- get_icon_by_term(input$search)
      imurls <- get_icons_urls(imlist)
      print(imurls)
      output$images <- renderUI({
        lapply(as.list(imurls),
               function(x) tags$img(src = x, width = img_size, height = img_size)
        )
      })
    })

  }
  viewer <- paneViewer(300)
  runGadget(ui, server, viewer = viewer)
  
}

nounAddin()
