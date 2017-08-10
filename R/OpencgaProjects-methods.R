#' A method to query Opencga Projects
#' 
#' A method to query, and manipulate Projects data
#' @aliases OpencgaProjects
#' @description This method allow the user to create, update and explore
#' projects data and metadta
#' @export
setMethod("OpencgaProjects", "Opencga", definition = function(object,
                                                              id=NULL, action, params=NULL, ...){
  category <- "projects"
  if(is.null(id)){
    id <- NULL
  }
  if(is.null(params)){
    params <- NULL
  }
  data<- excuteOpencga(object=object, category=category, id=id, action=action,
                       params=NULL, ...)
  return(data)
})