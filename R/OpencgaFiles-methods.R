#' @title A method to query Opencga Files
#' @aliases OpencgaFiles
#' @description This method allow the user to create, update and explore
#' files data and metadta
#' @export
setMethod("OpencgaFiles", "Opencga",    definition = function(object,
                                                              id=NULL, action, params=NULL, ...){
  category <- "files"
  if(is.null(id)){
    id <- NULL
  }
  if(is.null(params)){
    params <- NULL
  }
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=params, ...)
  return(data)
})