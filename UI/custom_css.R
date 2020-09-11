## Custom CSS ----
tags$head(
    tags$style(HTML("
    
    h3 {
    font-size: 20px;
    margin: 10.5px 0px;
    }
    
    .navbar-brand {
    height: 60px;
    padding: 10px 15px;
    }
    
    .navbar-nav>li>a{
    height: 60px;
    padding: 10px 15px;
    }
    
    h4 {
    font-size: 14px;
    font-weight: bold;
    margin: 5px 0px;
    }
    
    h5 {
    font-size: 13px;
    font-weight: bold;
    margin: 5px 0px;
    }
    
    h6 {
    font-size: 12px;
    margin: 0px;
    font-weight: 550;
    line-height: 1.4;
    }
    
    strong {
    font-size: 12px;
    font-weight: bold;
    }
    
    p{
    font-size: 12px;
    font-weight: normal;
    }
    
    li{
    font-size: 12px;
    font-weight: normal;
    }
    
    .selectize-input {
    word-wrap: break-word;
    font-size: 12px;
    overflow-x: auto;
    }
    
    .selectize-dropdown {
    word-wrap: break-word;
    font-size: 12px;
    }
    
    .selectize-control {
    margin: 0px;
    }
    
    .form-control {
    font-size: 12px;
    height: 40px;
    }
    
    .form-group {
    margin-bottom: 5px;
    }
    
    .btn {
    font-size: 12px;
    height: 40px;
    }
    
    .shiny-output-error-validation {
    font-size: 14px;
    color: #E74C3C;
    }
    
    
    .shiny-html-output{
    font-size: 12px;
    }

                    "))
    
)