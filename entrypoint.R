options(shiny.port = 8787, shiny.host = "0.0.0.0")

pkgload::load_all(export_all = FALSE,helpers = FALSE,attach_testthat = FALSE)
options( "golem.app.prod" = TRUE)
pilot2wrappers::run_app() # add parameters here (if any)
