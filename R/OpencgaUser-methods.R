
#' A method to query user data
#' @title A method to query user data
#' @aliases OpencgaUser
#' @description This method allow the user to create, update, and explore user
#'  data and metadata
#' @export
setMethod("OpencgaUser", "Opencga", definition = function(object,
                                                          id=NULL, action, params=NULL, ...){
  category <- "users"
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