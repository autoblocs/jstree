.global <- new.env()

#' @importFrom shiny tags
tags <- shiny::tags

#' @importFrom shiny addResourcePath HTML
initResourcePaths <- function() {
  if (is.null(.global$loaded)) {
    shiny::addResourcePath(
      prefix = 'jstree',
      directoryPath = system.file('www', package='jstree'))
    .global$loaded <- TRUE
  }
  shiny::HTML("")
}

# Parse incoming jstree input from the client
#' @importFrom shiny registerInputHandler
.onAttach <- function(libname, pkgname){
  shiny::registerInputHandler("jstree", function(val, shinysession, name){
    jsonToAttr(val)
  })
}

jsonToAttr <- function(json){

  # message("jstree init :")
  # message(str(json))
  # message("")

  if(is.null(json)) return(list())
  if(length(json) == 0) return(list())

  ret <- list()

  tryCatch({

      if (! "text" %in% names(json)){
          # This is a top-level list, not a node.
          for (i in 1:length(json)){
              ret[[json[[i]]$text]] <- jsonToAttr(json[[i]])
              ret[[json[[i]]$text]] <- supplementAttr(ret[[json[[i]]$text]], json[[i]])
          }
          return(ret)
      }

      if (length(json$children) > 0){
          return(jsonToAttr(json[["children"]]))
      } else {
          ret <- 0
          ret <- supplementAttr(ret, json)
          return(ret)
      }

  }, error = function(e){
      message(e)
  })

  return(list())
}

supplementAttr <- function(ret, json){
  # Only add attributes if non-default
  if (json$state$selected != FALSE){
    attr(ret, "stselected") <- json$state$selected
  }
  if (json$state$disabled != FALSE){
    attr(ret, "stdisabled") <- json$state$disabled
  }
  if (json$state$opened != FALSE){
    attr(ret, "stopened") <- json$state$opened
  }
  ret
}