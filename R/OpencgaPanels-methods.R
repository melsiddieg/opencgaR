#' @title A method to query Opencga Panels
#' @aliases OpencgaCohorts
#' @description This method allow the user to create, update and explore
#' cohorts data and metadta
#' @export
setMethod("OpencgaPanels", "Opencga",    definition = function(object,
                                                              id, action, params, ...){
  category <- "panels"
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=NULL, ...)
  return(data)
})