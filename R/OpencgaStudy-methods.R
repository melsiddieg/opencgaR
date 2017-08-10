#' A method to query Studies
#' @title A method to query Opencga studies
#' @aliases OpencgaStudy
#' @description This method allow the user to create, update and explore
#' study data and metadta
#' @export
setMethod("OpencgaStudy", "Opencga", definition = function(object, id=NULL,
                                                           category="studies",
                                                           action, params=NULL,
                                                           acl=NULL,
                                                           memberID=NULL,
                                                           groups=NULL,
                                                           groupID=NULL
                                                           , ...){
  category <- category
  if(is.null(id)){
    id <- NULL
  }
  if(is.null(params)){
    params <- NULL
  }
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=params,acl=NULL, groups=NULL, memberID=NULL,
                        groupID=NULL, ...)
  return(data)
})
