library(shinydashboard)
library(leaflet)
library(shinycssloaders)

header <- dashboardHeader(
  title = "Indicateurs OSOL France Métropolitaine"
)

body <- dashboardBody(
  fluidRow(
    column(width = 9,
           box(width = NULL, solidHeader = TRUE,
               withSpinner(leafletOutput("indicateurmap",height=700))
           )#,
           # box(width = NULL,
           #     uiOutput("table")
           # )
    ),
    column(width = 3,
           box(width = NULL, status = "warning",
               uiOutput("indicateurSelect")
               ),
           box(width = NULL, status = "warning",
               uiOutput("simplification")
           )
    )
  )
)

dashboardPage(
  header,
  dashboardSidebar(disable = TRUE),
  body
)

