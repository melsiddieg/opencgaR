#' @title A method to query Opencga Jobs
#' @aliases OpencgaJobs
#' @description This method allow the user to create, update and explore
#' jobs data and metadta
#' @export
setMethod("OpencgaJobs", "Opencga",    definition = function(object,
                                                             id, action, params, ...){
  category <- "jobs"
  data <- excuteOpencga(object=object, category=category, id=id, action=action,
                        params=NULL, ...)
  return(data)
})
