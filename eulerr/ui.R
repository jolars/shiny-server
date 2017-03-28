library(shiny)
library(eulerr)

shinyUI(
  navbarPage(
    "eulerr",
    inverse = TRUE,
    tabPanel(
      "App",
      fluidPage(
        fluidRow(
          column(
            3,
            wellPanel(
              p("String together combinations by joining them
                with an ampersand (&)."),
              radioButtons(
                "input_type",
                "Type of relationships",
                c("Disjoint combinations" = "disjoint", "Unions" = "union")
              ),
              splitLayout(
                cellWidths = c("70%", "30%"),
                textInput("combo_1", NULL, "A"),
                numericInput("size_1", NULL, 5, min = 0)
              ),
              splitLayout(
                cellWidths = c("70%", "30%"),
                textInput("combo_2", NULL, "B"),
                numericInput("size_2", NULL, 3, min = 0)
              ),
              splitLayout(
                cellWidths = c("70%", "30%"),
                textInput("combo_3", NULL, "A&B"),
                numericInput("size_3", NULL, 2, min = 0)
              ),

              tags$div(id = "placeholder"),

              splitLayout(
                actionButton("insert_set", "Insert", width = "100%"),
                actionButton("remove_set", "Remove", width = "100%")
              )
              ),
            wellPanel(
              fluidRow(
                column(
                  6,
                  strong("Stress"),
                  textOutput("stress")
                ),
                column(
                  6,
                  strong("Diag error"),
                  textOutput("diag_error")
                )
              )
            ),
            tableOutput("table")
          ),
          column(
            6,
            plotOutput("euler_diagram", height = "500px")
          ),
          column(
            3,
            textInput("title", "Title", width = "100%"),
            strong("Colors"),
            em(p("A comma-separated list of ", a(href = "https://stat.columbia.edu/~tzheng/files/Rcolor.pdf", "x11"),
              "or", a(href = "https://en.wikipedia.org/wiki/Web_colors#Hex_triplet", "hex colors."))),
            textInput(
              inputId = "fill",
              label = NULL,
              value = "",
              placeholder = "steelblue4, #CD5555",
              width = "100%"
            ),
            sliderInput("opacity", "Opacity", min = 0, max = 1, value = 0.4,
                        width = "100%"),
            checkboxInput("counts", "Show counts"),
            fluidRow(
              column(
                4,
                checkboxInput("key", "Key")
              ),
              column(
                8,
                conditionalPanel(
                  condition = "input.key == true",
                  selectInput("key_space", NULL, width = "100%",
                              list("top", "bottom", "left", "right"))
                )
              )
            ),
            radioButtons(
              "fontface",
              "Font face",
              list("Plain", "Bold", "Italic", "Bold italic"),
              inline = TRUE
            ),
            radioButtons(
              "borders",
              "Borders",
              list("Solid", "Varying", "None"),
              inline = TRUE
            ),

            hr(),
            fluidRow(
              column(
                6,
                downloadButton("download_plot", "Save plot")
              ),
              column(
                6,
                radioButtons(
                  "savetype",
                  NULL,
                  list("pdf", "png"),
                  inline = TRUE
                )
              )
            )
          )
        )
      )
    ),
    tabPanel(
      "Information",
      fluidPage(
        fluidRow(
          column(
            6,
            offset = 3,
            wellPanel(
              h3("Area-proportional diagrams with eulerr"),
              p("This", a(href = "https://shiny.rstudio.com/", "shiny"),
                "app is based on an",
                a(href = "www.r-project.org", "R"),
                "package that I have developed called eulerr. It generates
                area-proportional euler diagrams using some rather groovy algorithms
                and optimization routines written in", code("R"), "and", code("C++.")),
              p(a(href = "https://en.wikipedia.org/wiki/Euler_diagram",
                  "euler diagrams"),
                "are generalized venn diagrams for which the requirement that all
                intersections be present is relaxed. They are constructed from
                a specification of set relationships but may sometimes fail
                to display these appropriately. For instance, try giving the
                app the specification",
                code("A = 5, B = 3, C = 1, A&B = 2,AB&C = 2"),
                "to see what I mean."),
              p("When this happens, eulerr tries to give an indication of how
                badly the diagram fits the data through the metrics",
                em("stress"), "and", em("diag error"), ". The latter of these
                show the largest difference in percentage points between the specification
                of any one set combination and its resulting fit. It is the
                maximum value of", em("region error"), ", which is given for
                each combination. This metric has been adopted from",
                a(href = "https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0101717", "a paper by
                Micallef and Peter Rodgers."), "Stress is more difficult to
                explain, but I advise the interested reader to read",
                a(href = "https://www.cs.uic.edu/~wilkinson/Publications/venneuler.pdf",
                  "Leland Wilkinson's excellent paper"), "for a proper brief."),
              p("I have listed some links on the right if you are keen on
                learning more about eulerr, perhaps even to contribute to its
                development. Finally, I owe a great deal to the
                aforementioned Wilkinson as well as",
                a(href = "http://www.benfrederickson.com/", "Ben Frederickson"),
                "whose work eulerr is built upon."),
              br(),
              p("Johan Larsson")
            )
          ),
          column(
            2,
            wellPanel(
              p(strong(a(href = "https://CRAN.R-project.org/package=eulerr", "eulerr on the R package repository CRAN"))),
              p(strong(a(href = "http://larssonjohan.com", "My personal website"))),
              p(strong(a(href = "https://github.com/jolars/eulerr", "The Github repository for the r package"))),
              p(strong(a(href = "https://github.com/jolars/eulerr_shiny", "The Github repository for the shiny app")))
            )
          )
        )
      )
    )
  )
)




