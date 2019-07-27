library(shiny)
library(tablerDash)
library(MASS)
library(shinyWidgets)
library(DT)
library(shinyjs)
# library(glmnet)
library(gmailr)

pg_title <- "Variable Selection"

intro <- h1("Introduction", style = "font-size:300%;")

intro_text <- HTML("<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>")

profileCard <- tablerProfileCard(
  width = 12, 
  title = intro,
  subtitle = intro_text,
  background = "images/ipb_university_card.jpg",
  src = "images/logoipb.png"
)

team <- function(name, src, job, fb = "", twitter = ""){
  sprintf('<div class="card-body text-center">
              <img src="%s" class="card-profile-img">
            </div>
            <div class="media">
              <div class="media-body">
                <h4 class="m-0">%s</h4>
                <p class="text-muted mb-0">%s</p>
              </div>
            </div>', 
          # Parameter
          src, name, job, fb, twitter)
}

bagusco <- team(name = "Bagus Sartono", 
                src = "images/bagusco.png", 
                job = "IPB University", 
                fb = "https://facebook.com/bagusco")

farit <- team(name = "Farit M. Afendi", 
              src = "images/farit.jpg",
              job = "IPB University")

agus <- team(name = "Agus Salim", 
              src = "images/agus-salim.jpg",
              job = "La Trobe University")

anisa <- team(name = "Rahma Anisa", 
              src = "images/rahma-anisa.jpg", 
              job = "IPB University", 
              fb = "https://facebook.com/rahma.anisa")

aep <- team(name = "Aep Hidayatuloh", 
            src = "images/aeph.jpg", 
            job = "Starcore Analytics", 
            fb = "https://web.facebook.com/aephidayatuloh09", 
            twitter = "https://twitter.com/aephidayatuloh")

gerry <- team(name = "Gerry Alfa Dito", 
              src = "images/gerry.jpg", 
              job = "IPB University",
              twitter = "https://twitter.com/rhjmulianto")

# app
shiny::shinyApp(
  ui = tablerDashPage(
    navbar = tablerDashNav(
      id = "mymenu",
      # src = "images/logoipb.png",
      navMenu = tablerNavMenu(
        tablerNavMenuItem(
          tabName = "Home",
          icon = "home",
          "Home"
        ),
        tablerNavMenuItem(
          tabName = "Data",
          icon = "upload-cloud",
          "Upload Data"
        ),
        tablerNavMenuItem(
          tabName = "Setting",
          icon = "settings",
          "Method's Setting"
        ),
        tablerNavMenuItem(
          tabName = "Result",
          icon = "layers",
          "Results"
        ),
        tablerNavMenuItem(
          tabName = "Help",
          icon = "help-circle",
          "Help"
        ),
        tablerNavMenuItem(
          tabName = "About",
          icon = "book-open",
          "About"
        ),
        tablerNavMenuItem(
          tabName = "Contact",
          icon = "mail",
          "Contact"
        )
      )
    ),
    footer = tablerDashFooter(
      p(style = "text-align:left;", HTML('Theme by <a href="https://github.com/RinteRface/tablerDash" target="_blank">tablerDash</a>. Powered by <a href="https://shiny.rstudio.com/" target="_blank">RStudio Shinyapps</a>.')),
      copyrights = p(HTML("Copyright &copy; 2019 Aep Hidayatuloh"))
    ),
    enable_preloader = TRUE, loading_duration = 0.3,
    title = pg_title,
    body = tablerDashBody(
      useShinyjs(),
      tags$head(
        tags$style(HTML(".shiny-input-container:not(.shiny-input-container-inline) {
                          width: 100%;
                        }")),
        tags$meta(name="viewport", content="width=device-width, initial-scale=1.0"),
        tags$link(rel = "stylesheet", type = "text/css", href = "css/dashboard.css"),
        tags$link(rel = "shortcut icon", href = "images/favicon.png"),
        tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",
                            function(message) {
                              eval(message.code);
                            }
                          );
                        '))
      ),
      # chooseSliderSkin("Nice"),
      tablerTabItems(
        tablerTabItem(
          tabName = "Home",
          fluidRow(
            profileCard
            ),
          fluidRow(
            tablerCard(width = 12,
                       div(style="display:flex;justify-content:center;", 
                            h1("Our Team", style = "font-size:300%;")
                       ),
                       h4("Principal Researcher", style="text-align:center;padding-bottom:8%;"),
                       div(class="principal",#style="display:inline-block;vertical-align:top;width:25%;text-align:center;",
                             HTML(bagusco)
                           ),
                       h4("Researchers", style="text-align:center;padding-bottom:8%;"),
                       div(class="row researcher-container",
                         column(width = 4,
                                div(class="researcher",
                                    HTML(farit)
                                    )
                                ),
                         column(width = 4,
                                div(class="researcher",
                                    HTML(agus)
                                )
                         ),
                         column(width = 4,
                                div(class="researcher",
                                    HTML(anisa)
                                )
                         )
                         
                      ),
                      h4("Developer and Programmer", style="text-align:center;padding-top:5%;padding-bottom:8%;"),
                      div(class="row dev-container",
                          column(width = 6,
                                 div(class="dev",
                                     HTML(aep)
                                 )
                          ),
                          column(width = 6,
                                 div(class="dev",
                                     HTML(gerry)
                                 )
                          )
                      )
                       
            )
            )
          ),
        tablerTabItem(
          tabName = "Data",
          fluidRow(
            column(
              width = 6,
              tablerCard(width = 12,
                       h4("Upload Data"),
                       fileInput("data", label = NULL, multiple = FALSE,
                                 accept = c(
                                   "text/csv",
                                   "text/comma-separated-values,text/plain",
                                   ".csv"),
                                 width = "100%"),
                       div(style="display:inline-block;vertical-align:top;width:47%;",
                           switchInput(
                             inputId = "headerData",
                             label = "First Row Header",
                             value = TRUE,
                             onStatus = "primary",
                             offStatus = "danger", 
                             onLabel = "Yes", 
                             offLabel = "No", 
                             size = "small", labelWidth = 100
                           )
                           # HTML('<div class="form-group shiny-input-container">
                           #      <label class="custom-switch">
                           #        <input id="headerData" type="checkbox" name="custom-switch-checkbox" class="custom-switch-input" checked>
                           #        <span class="custom-switch-indicator"></span>
                           #        <span class="custom-switch-description">First Row Header</span>
                           #      </label>
                           #    </div>')
                       ),
                       # div(style="display:inline-block;vertical-align:top;width:47%;",
                       #     HTML('<div class="form-group shiny-input-container">
                       #          <label class="custom-switch">
                       #            <input id="stringfactor" type="checkbox" name="custom-switch-checkbox" class="custom-switch-input" checked>
                       #            <span class="custom-switch-indicator"></span>
                       #            <span class="custom-switch-description">String As Factor</span>
                       #          </label>
                       #        </div>')
                       # ),
                       br(),
                       h4("Delimiter"),
                       HTML('<div id="delimData" class="form-group shiny-input-radiogroup shiny-input-container" width="100%">
                                <div class="custom-controls-stacked shiny-options-group shiny-input-container shiny-input-container-inline">
                                  <label class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" class="custom-control-input" name="delimData" value=" "  checked="checked">
                                    <span class="custom-control-label">Space</span>
                                  </label>
                                  <label class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" class="custom-control-input" name="delimData" value=",">
                                    <span class="custom-control-label">Comma</span>
                                  </label>
                                  <label class="custom-control custom-radio custom-control-inline">
                                    <input type="radio" class="custom-control-input" name="delimData" value=";">
                                    <span class="custom-control-label">Semicolon</span>
                                  </label>
                                </div>
                            </div>'),
                       div(style="width:100%;display:inline-block;vertical-align:bottom;",
                           h4("Select Target Variable")
                       ),
                       div(style="width:100%;display:inline-block;vertical-align:bottom;margin-right:0",
                           selectInput("col_y", label = NULL, choices = NULL, width = "100%")
                       ),
                       shinyjs::hidden(
                         div(style="width:100%;display:inline-block;vertical-align:bottom;",
                             h4("Select Factor Variable (optional)")
                             ),
                         div(style="width:100%;display:inline-block;vertical-align:bottom;margin-right:0",
                             selectInput("col_factor", label = NULL, choices = NULL, multiple = TRUE, width = "100%")
                             )
                         ),
                       div(style="width:29%;display:inline-block;vertical-align:top;color:primary;margin-left:0",
                           actionButton("submit_target", label = "Submit", icon = icon("cogs"), style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
                       )
              )
            ),
            column(width = 6,
                   # tablerCard(
                   #   width = 12,
                   #   div(style="width:100%;display:inline-block;vertical-align:bottom;",
                   #       h4("Select Target Variable")
                   #       ),
                   #   div(style="width:70%;display:inline-block;vertical-align:bottom;margin-right:0",
                   #       selectInput("col_y", label = NULL, choices = NULL, multiple = FALSE, width = "100%")
                   #       ),
                   #   div(style="width:29%;display:inline-block;vertical-align:top;color:primary;margin-left:0",
                   #       actionButton("submit_target", label = "Submit", icon = icon("cogs"), style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
                   #       )
                   #   ),
                   div(id = "tbl_role",
                       tablerCard(width = 12,
                                  h4("Variable Roles"), 
                                  overflow = TRUE, #collapsible = FALSE,
                                  br(),
                                  dataTableOutput("role", width = "100%")
                                  )
                       )
                   )
            )
        ),
        tablerTabItem(
          tabName = "Setting",
          fluidRow(
            column(width = 9,
                 fluidRow(
              tablerCard(
                title = h6("Forward Selection"),
                zoomable = FALSE,
                closable = FALSE,
                options = tagList(
                  switchInput(
                    inputId = "enable_forward",
                    label = "Use?",
                    value = TRUE,
                    onStatus = "primary",
                    offStatus = "danger", 
                    onLabel = "Yes", 
                    offLabel = "No", 
                    size = "small"
                  )
                ),
                h6("Criterion"),
                HTML('<div id="fwd_criteria" class="form-group shiny-input-radiogroup shiny-input-container" width="100%">
                        <div class="custom-controls-stacked shiny-options-group shiny-input-container">
                          <label class="custom-control custom-radio">
                            <input type="radio" class="custom-control-input" name="fwd_criteria" value="AIC"  checked="checked">
                            <span class="custom-control-label">AIC</span>
                          </label>
                          <label class="custom-control custom-radio">
                            <input type="radio" class="custom-control-input" name="fwd_criteria" value="BIC">
                            <span class="custom-control-label">BIC</span>
                          </label>
                          <label class="custom-control custom-radio">
                            <input type="radio" class="custom-control-input" name="fwd_criteria" value="adjrsq">
                            <span class="custom-control-label">Adjusted R-square</span>
                          </label>
                        </div>
                    </div>'),
                width = 6
              ),
              tablerCard(
                title = h6("LASSO"),
                zoomable = FALSE,
                closable = FALSE,
                options = tagList(
                  switchInput(
                    inputId = "enable_lasso",
                    label = "Use?",
                    value = FALSE,
                    onStatus = "primary",
                    offStatus = "danger", 
                    onLabel = "Yes", 
                    offLabel = "No", 
                    size = "small"
                  )
                ),
                h6("Criterion"),
                HTML('<div id="lasso_criteria" class="form-group shiny-input-radiogroup shiny-input-container" width="100%">
                        <div class="custom-controls-stacked shiny-options-group shiny-input-container">
                          <label class="custom-control custom-radio">
                            <input type="radio" class="custom-control-input" name="lasso_criteria" value="Optimum"  checked="checked">
                            <span class="custom-control-label">Optimum by CV</span>
                          </label>
                          <label class="custom-control custom-radio">
                            <input type="radio" class="custom-control-input" name="lasso_criteria" value="User">
                            <span class="custom-control-label">User defined</span>
                          </label>
                        </div>
                    </div>'),
                numericInput(inputId = "lasso_user_input", label = NULL, value = NA),
                width = 6
              ),
              tablerCard(
                title = h6("SCAD"),
                zoomable = FALSE,
                closable = FALSE,
                options = tagList(
                  switchInput(
                    inputId = "enable_scad",
                    label = "Use?",
                    value = FALSE,
                    onStatus = "primary",
                    offStatus = "danger", 
                    onLabel = "Yes", 
                    offLabel = "No", 
                    size = "small"
                  )
                ),
                h6("Criterion"),
                HTML('<div id="scad_criteria" class="form-group shiny-input-radiogroup shiny-input-container" width="100%">
                        <div class="custom-controls-stacked shiny-options-group shiny-input-container-inline">
                          <label class="custom-control custom-radio ">
                            <input type="radio" class="custom-control-input" name="scad_criteria" value="Optimum"  checked="checked">
                            <span class="custom-control-label">Optimum by CV</span>
                          </label>
                          <label class="custom-control custom-radio">
                            <input type="radio" class="custom-control-input" name="scad_criteria" value="User">
                            <span class="custom-control-label">User defined</span>
                          </label>
                        </div>
                    </div>'),
                numericInput(inputId = "scad_user_input", label = NULL, value = NA),
                width = 6
              ),
              tablerCard(
                title = h6("RIDGE"),
                zoomable = FALSE,
                closable = FALSE,
                options = tagList(
                  switchInput(
                    inputId = "enable_ridge",
                    label = "Use?",
                    value = FALSE,
                    onStatus = "primary",
                    offStatus = "danger", 
                    onLabel = "Yes", 
                    offLabel = "No", 
                    size = "small"
                  )
                ),
                h6("Criterion"),
                HTML('<div id="ridge_criteria" class="form-group shiny-input-radiogroup shiny-input-container" width="100%">
                        <div class="custom-controls-stacked shiny-options-group shiny-input-container-inline">
                          <label class="custom-control custom-radio ">
                            <input type="radio" class="custom-control-input" name="ridge_criteria" value="Optimum"  checked="checked">
                            <span class="custom-control-label">Optimum by CV</span>
                          </label>
                          <label class="custom-control custom-radio">
                            <input type="radio" class="custom-control-input" name="ridge_criteria" value="User">
                            <span class="custom-control-label">User defined</span>
                          </label>
                        </div>
                    </div>'),
                numericInput("ridge_user_input", label = NULL, value = NA),
                width = 6
              )
              )
            ),
            column(width = 3,
              tablerCard(width = 12,
                        status = "primary", collapsible = TRUE, zoomable = FALSE, closable = FALSE,
                        title = h4("Summary", style = "text-align:center;"),
                        br(),
                        dataTableOutput("summary"),
                        br(),
                        actionButton("processBtn", "Process", width = "100%", icon = icon("send"), style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
                       )
              )
          )
        ),
        tablerTabItem(
          tabName = "Result",
          fluidRow(
            column(width = 4,
                   tablerCard(width = 12,
                              status = "primary",
                              title = h4("Criterion"),
                              closable = FALSE,
                              zoomable = TRUE, 
                              # br(),
                              dataTableOutput("result_criteria")
                              )
                   ),
              tablerCard(width = 8, 
                         status = "primary", 
                         title = h4("Coefficients"),
                         closable = FALSE,
                         overflow = TRUE,
                         zoomable = FALSE,
                         # br(),
                         dataTableOutput("results")
            )
          )
        ),
        tablerTabItem(
          tabName = "Help",
          fluidRow(
            tablerCard(width = 12, status = "primary", title = h1("Help"))
          )
        ),
        tablerTabItem(
          tabName = "About",
          fluidRow(
            tablerCard(width = 12, status = "primary", title = h1("About"))
          )
        ),
        tablerTabItem(
          tabName = "Contact",
          div(style="display: flex;justify-content:center;",
            tablerCard(width = 4, closable = FALSE, collapsible = FALSE,
                       status = "primary", 
                       h1("Contact", style="text-align:center;"),
                       h4("Name"),
                       textInput("contact_name", NULL, width = "100%"),
                       h4("Your Email"),
                       textInput("contact_email", NULL, placeholder = "youremail@domain.com", width = "100%"),
                       h4("Message"),
                       textAreaInput("contact_msg", NULL, width = "100%", rows = 4),
                       br(),
                       actionButton("contactBtn", "Send", icon = icon("send"), width = "100%", style="color: #fff; background-color: #337ab7; border-color: #2e6da4")
                       )
          )
        )
      )
    )
  ),
  server = function(input, output, session) {
    
    datatbl <- reactive({
      read.delim(file = input$data$datapath, header = input$headerData, sep = input$delimData) #, stringsAsFactors = input$stringfactor)
    })
    
    # rv <- reactiveValues(clicks = 0)
    
    # observeEvent(input$submit_target, {
    #   rv$clicks <- rv$clicks + 1
    # })
    
    observe({
      if(is.null(input$data)) {
        return(NULL)
      } else {
        x <- datatbl()
        updateSelectInput(session, inputId = "col_y", label = NULL, choices = names(x))
        # updateSelectInput(session, inputId = "col_factor", label = NULL, choices = c("", setdiff(names(x), input$col_y)), selected = "")
      }
    })
    
    
    dt_target <- eventReactive(input$submit_target, {
      # isolate(input$submit_target)
      if(is.null(input$data)) {
        return(NULL)
      } else {
        xs <- datatbl()
        xs[, input$col_factor] <- data.frame(apply(xs[input$col_factor], 2, as.factor))
      }
      xs
    })
    
    dt_col_target <- eventReactive(input$submit_target, {
      isolate(input$col_y)
      # isolate(input$submit_target)
      if(is.null(input$data)) {
        xs <- data.frame(Column = NA, Variable = NA, Type = NA, Role = NA)
      } else {
        xs <- data.frame(Column = as.character(1:ncol(datatbl())), Variable = names(dt_target()), Type = sapply(dt_target(), class))
        xs$Role <- ifelse(xs$Variable == input$col_y, "Target", "Input")
      }
      xs
    })
    
    output$role <- renderDataTable({
      # if(is.null(input$data)){
        xs <- data.frame(Variable = NA, Type = NA, Role = NA)
        datatable(xs, 
                  rownames = FALSE,
                  options = list(pageLength = 5,
                                 lengthMenu = c(5, 10),
                                 initComplete = JS(
                                   "function(settings, json) {",
                                   "$(this.api().table().header()).css({'background-color': '#467fcf', 'color': '#fff'});",
                                   "}"), language = list(search = 'Filter:')))
      # }
    })
    
    dt_role <- eventReactive(input$submit_target, {
      if(is.null(input$data)) {
        showModal(modalDialog(
          title = "No Data Uploaded",
          "Please upload a tabular file and specify the Target variable.",
          easyClose = FALSE
        ))
        data.frame(Variable = NA, Type = NA, Role = NA)
      } else{ 
      # output$role <- renderDataTable(input$submit_target, {
          isolate(input$col_y)
          xs <- data.frame(Variable = names(dt_target()), Type = sapply(dt_target(), class))
          xs$Role <- ifelse(xs$Variable == input$col_y, "Target", "Input")
          xs
        }
        # }
      # })
      # shinyjs::toggle(id = "role_tbl")
    })
    
    observeEvent(input$submit_target, {
    output$role <- renderDataTable({
      datatable(dt_role(), 
                rownames = FALSE,
                options = list(pageLength = 5,
                               lengthMenu = c(5, 10),
                               initComplete = JS(
                                 "function(settings, json) {",
                                 "$(this.api().table().header()).css({'background-color': '#467fcf', 'color': '#fff'});",
                                 "}"), language = list(search = 'Filter:'))
      )
    })
    })
    
    # observe({
    #   if(input$enable_lasso & input$lasso_criteria == "User") {
    #     shinyjs::enable(id = "lasso_user_input")
    #   } else {
    #     shinyjs::disable(id = "lasso_user_input")
    #   }
    #   # shinyjs::toggleState("lasso_user_input", input$lasso_criteria == 'Optimum')
    # })
    
    method_cr <- reactive({
      if(is.null(input$data)) return(NULL)
      # if()
      method <- c("Forward", "LASSO", "SCAD", "Ridge")
      method <- method[c(input$enable_forward, input$enable_lasso, input$enable_scad, input$enable_ridge)]
      
      value <- c(NA, input$lasso_user_input, input$scad_user_input, input$ridge_user_input)
      value <- value[c(input$enable_forward, input$enable_lasso, input$enable_scad, input$enable_ridge)]
      
      criterion <- c(input$fwd_criteria, input$lasso_criteria, input$scad_criteria, input$ridge_criteria)
      criterion <- criterion[c(input$enable_forward, input$enable_lasso, input$enable_scad, input$enable_ridge)]
      criterion <- ifelse(criterion == 'User', paste0(criterion, "(", value, ")"), criterion)
      data.frame(method = method, criterion = criterion, value = value, stringsAsFactors = FALSE)
    })
    
    observeEvent(input$processBtn, {
      # isolate(input$processBtn)
      # isolate(input$enable_forward)
      # isolate(input$enable_lasso)
      # isolate(input$enable_scad)
      # isolate(input$enable_ridge)
      if(is.null(input$data)){
        showModal(modalDialog(title = "No Data Available", 
                              "Please upload a data file",
                              easyClose = FALSE))
      } else {
        dt_lm <- reactive({
          dt <- dt_target() #data.frame(weight, group)
          lm(dt[, dt_role()$Variable[dt_role()$Role == "Target"]] ~ ., data = dt[, names(dt) != dt_role()$Variable[dt_role()$Role == "Target"]])
        })
        
        n <- length(method_cr()[,"method"])
        
        output$results <- renderDataTable({
          if(n > 0) {
            dtn_lm <- data.frame(Variable = names(coef(dt_lm())[-1]), Forward = round(coef(dt_lm())[-1], 4))
            dtn <- dtn_lm #data.frame(Variable = setdiff(names(datatbl()), input$col_y)) 
            
            for(i in 1:n){
              # x <- data.frame(method = rep(method[i], length(names(dt))), Variable = names(dt))
              if(method_cr()[,"method"][i] == "Forward"){
                dtn[, method_cr()[,"method"][i]] <- round(dtn_lm$Forward, 4)
              } else {
                dtn[, method_cr()[,"method"][i]] <- 0
              }
            }
            
            datatable(dtn, 
                      rownames = FALSE,
                      options = list(pageLength = 5,
                                     lengthMenu = c(5, 10),
                                     initComplete = JS(
                                       "function(settings, json) {",
                                       "$(this.api().table().header()).css({'background-color': '#467fcf', 'color': '#fff'});",
                                       "}"), language = list(search = 'Filter:')))
          } else {
            showModal(modalDialog(title = "No Method Used", 
                                  "Please select at least one method and criterion",
                                  easyClose = FALSE))
            return(NULL)
          }
          
          # model.matrix(dt_target()[, input$col_y] ~ ., data = dt_target()[, names(dt) != input$col_y])
        })
      }
      
      output$result_criteria <- renderDataTable({
        # isolate(input$enable_forward)
        # isolate(input$enable_lasso)
        # isolate(input$enable_scad)
        # isolate(input$enable_ridge)
        if(n > 0) {
          isolate(method_cr())
          rc <- data.frame(Method = method_cr()[,1], Value = NA)
          rc$Value <- ifelse(rc$Method == "Forward" & input$fwd_criteria == "AIC", round(AIC(dt_lm()), 4),
                      ifelse(rc$Method == "Forward" & input$fwd_criteria == "BIC", round(BIC(dt_lm()), 4),
                      ifelse(rc$Method == "Forward" & input$fwd_criteria == "adjrsq", round(summary(dt_lm())$adj.r.sq, 4), rc$Value)))
          rc$Value <- ifelse(rc$Method == "LASSO" & input$lasso_criteria == "Optimum", round(AIC(dt_lm()), 4),
                      ifelse(rc$Method == "LASSO" & input$lasso_criteria == "User", round(BIC(dt_lm()), 4), rc$Value))
          rc$Value <- ifelse(rc$Method == "SCAD" & input$scad_criteria == "Optimum", round(AIC(dt_lm()), 4),
                      ifelse(rc$Method == "SCAD" & input$scad_criteria == "User", round(BIC(dt_lm()), 4), rc$Value))
          rc$Value <- ifelse(rc$Method == "Ridge" & input$ridge_criteria == "Optimum", round(AIC(dt_lm()), 4),
                      ifelse(rc$Method == "Ridge" & input$ridge_criteria == "User", round(BIC(dt_lm()), 4), rc$Value))
          
          datatable(rc, 
                    escape = FALSE, 
                    rownames = FALSE,
                    options = list(pageLength = 5,
                                   lengthMenu = c(5, 10),
                                   initComplete = JS(
                                     "function(settings, json) {",
                                     "$(this.api().table().header()).css({'background-color': '#467fcf', 'color': '#fff'});",
                                     "}"), 
                                   dom  = 't'))
          
        } else {
          return(NULL)
        }
      })
      showModal(modalDialog(title = "Information System", 
                            "Done!",
                            easyClose = FALSE))
    })
    
    
    observe({
      if(is.null(input$data)) return(NULL)
      # if()
      
      output$summary <- renderDataTable({
        smry_tbl <- method_cr()[, 1:2]
        names(smry_tbl) <- c("Method", "Criterion")
        smry_tbl$Criterion <- ifelse(smry_tbl$Criterion == "adjrsq", "Adj R-Square", smry_tbl$Criterion)
        
        datatable(smry_tbl, 
                  escape = FALSE, 
                  rownames = FALSE,
                  options = list(pageLength = 5,
                                 lengthMenu = c(5, 10),
                                 initComplete = JS(
                                   "function(settings, json) {",
                                   "$(this.api().table().header()).css({'background-color': '#467fcf', 'color': '#fff'});",
                                   "}"), 
                                 dom  = 't'))
      })
      
    })
    
    observeEvent(input$contactBtn, {
      if(input$contact_name == ""){
        showModal(modalDialog(
          title = "System Information",
          "Please provide your name",
          easyClose = FALSE
        ))
      } else if(input$contact_email == ""){
        showModal(modalDialog(
          title = "System Information",
          "Please provide your valid email",
          easyClose = FALSE
        ))
      } else if(input$contact_msg == ""){
        showModal(modalDialog(
          title = "System Information",
          "Please provide your message",
          easyClose = FALSE
        ))
      } else {
        mime() %>%
          to("aephidayatuloh.mail@gmail.com") %>%
          from("aef.stk@gmail.com") %>%
          cc("aep.hidayatuloh@starcore.co") %>% 
          subject("Variable Selection Application") %>% 
          text_body(paste0("This message generated from Variable Selection Application.\n\nFrom : \n", input$contact_name, " (", input$contact_email, ")\n\nMessage :\n", input$contact_msg)) %>% 
          send_message()
        
        showModal(modalDialog(
          title = "System Information",
          p(HTML("Message Sent!<br/><br/>Thank you."), style="text-align:center;"),
          easyClose = FALSE,
          size = "s"
        ))
      }
    })
  }
)

