#' @export
setNode <- function(x = "", sticon = NULL, stselected = FALSE, stdisabled = FALSE,
                    stopened = FALSE){

    structure(x, sticon = sticon, stselected = stselected, stdisabled = stdisabled,
              stopened = stopened)

}

#' @export
setNodeJson <- function(x, children = list(), icon = NULL,
                        stopened = FALSE, stselected = FALSE, stdisabled = FALSE){
    list(
        text = x,
        icon = ifelse(is.null(icon), "", paste0("fa fa-", icon)),
        state = list(opened = stopened,
                     selected = stselected,
                     disabled = stdisabled),
        children = children
    )
}