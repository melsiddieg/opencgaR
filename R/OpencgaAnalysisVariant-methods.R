#' A method to query variant data
#' @title A method to query user data
#' @aliases OpencgaUser
#' @description This method allow the user to perform various analytics on
#'  varinats.
#' @export
setMethod("OpencgaAnalysisVariant", "Opencga", definition = function(object,
                                                          id=NULL, action, params=NULL, ...){
  category <- "analysis/variant"
  if(is.null(id)){
    id <- NULL
  }
  if(is.null(params)){
    params <- NULL
  }
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=NULL, ...)
  return(data)
})