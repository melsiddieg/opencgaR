# Helper Functions for the Opencga Classes
# URL structure =base+category+action+params
# fetchOpencga
# createURL
# ParseResponse
base <- "http://localhost:8080/opencga-1.1.1/webservices/rest/v1"

#' A function to login Opencga web services
#' @aliases OpencgaLogin
#' @param baseurl a character specifying the host url
#' @param userid a charatcer the username
#' @param passwd a charcter the user password
#' @param logical whether to launch a graphical interface, FALSE by default
#' @param ... Any other arguments
#' @return an Opencga class object
#' @export
OpencgaLogin <- function(baseurl, userid=character(), passwd=character(), interactive=FALSE){
  if(interactive==TRUE){
    cred <- user_login()
    url <- paste(baseurl,"/users/",cred$user,"/login","?password=", cred$pass,
                 sep="")
  }else{
    url <- paste(baseurl,"/users/", userid, "/login","?password=", passwd,
                 sep="")
  }
  # print(url)
  res <- fromJSON(url)
  userId <- userid
  sessionId <- unlist(res$response$result[[1]]$sessionId)
  return(new("Opencga",baseurl=baseurl, sessionID=sessionId, userID=userId))
}
# Workforce function
excuteOpencga <- function(object, category, id, action, params,
                          acl=NULL, memberID=NULL, groups=NULL,
                          groupId=NULL, annotaionSet=NULL,
                          annotationSetName=NULL, configs=NULL,
                          fname=NULL, ...){
  version <- object@baseurl
  sessionID <- paste0("?sid=",object@sessionID)
  if(is.null(id)){
    id <- NULL
  }else{
    id <- paste0("/", id, sep="")
  }
  
  action <- paste0("/", action)
  category <- paste0("/", category)
  params <- params
  acl=acl
  memberID=memberID
  groups=groups
  groupId=groupId
  annotaionSet=annotaionSet
  annotationSetName=annotationSetName
  configs=configs
  fname=fname

  Oargs <- list(...)
  if(length(args)>0){
    acc <- list()
    j <- 1
    for (i in names(Oargs)){
      tmp <- paste(i,"=", Oargs[[i]], sep="")
      acc[[j]]<-tmp
      
            j <- j+1
    }
    Nargs <- paste(unlist(acc), collapse = "&")
  }else{
    Nargs <- NULL
  }
  ## loop to get all the data to be finished
  i=1
  server_limit=2000
  skip=0
  num_results=2000
  container=list()
  while(num_results==server_limit){
    grl <- createURL(version, category, id, action,acl=NULL, memberID=NULL,
                     groups=NULL, groupId=NULL, annotaionSet=NULL,
                     annotationSetName=NULL, configs=NULL,fname=NULL,
                     field=NULL, sessionID, params, skip, Nargs)
    res_list <- parseJ(grl)
    num_results <- res_list$num_results
    cell <- res_list$data
    container[[i]] <- cell
    skip=skip+2000
    i = i + 1
  }
  ds <- rbind_pages(container)
  ###############################################################
  return(ds)
}


createURL <- function(version, category, id, action, sessionID, 
                      acl=NULL, memberID=NULL, groups=NULL,
                      groupId=NULL, annotaionSet=NULL,
                      annotationSetName=NULL, configs=NULL,fname=NULL,
                      field=NULL,params, skip, Nargs){
  noIds <- c("create", "create-folder", "search", "unlink", "content-example",
             "download-example", "load")
  skip=paste0("skip=",skip)
  baseParam <- paste(sessionID, skip, sep = "&")
  if(!is.null(params)){
    extraParams <- getCgaParam(params)
  }else{
    extraParams <- NULL
  }
  # extrArgs <- list(...)
  allParams <- c(baseParam, extraParams, Nargs)
  allParams <- allParams[!is.null(allParams)]
  allParams <- paste0(allParams, collapse = "&")
  if (action %in%noIds){
    grl <- paste0(version, category, action, allParams)
  }else{
    grl <- paste0(version, category, id, action, allParams)
  }

  return(grl)
}

parseJ <- function(grl){
  res <- fromJSON(grl, flatten = TRUE, simplifyVector = TRUE)
  num_results <- res$response$numResults
  return(list(num_results=num_results,data=as.data.frame(res$response$result)))
}
# getParam <- function(object){
# 
#   return(param)
# }

getCgaParam <- function(object){
            region=object@region
            chromosome=object@chromosome
            gene=object@gene
            maf=object@maf
            mgf=object@mgf
            genotype=object@genotype
            polyphen=object@polyphen
            sift=object@sift
            conservation=object@conservation
            reference=object@reference
            alternate=object@alternate
            so=object@so
            biotype=object@biotype
            limit=object@limit
            files=object@files
            returnedStudies=object@returnedStudies
            returnedSamples=object@returnedSamples
            param=c(region, chromosome, gene, maf,mgf, genotype, polyphen,
                    sift,  conservation, reference, alternate, so, biotype,
                    limit, files, returnedStudies, returnedSamples)
            foundParam <- vector()
            i=1
            for (argument in param){
              if(length(argument)>0){
                foundParam[i] <- argument
                i=i+1
              }
            }
            return(paste(foundParam, collapse="&"))

          }
#' A method to fetch documentation about Opencga Methods
#' 
#' This method allow users to lookup required 
#' to query Opencga Data
#' @param category the Opencga category being queried
#' @param action action intended on that category
#' @return A dataframe
#' @export
getOpencgaDocs <- function(category, action,  requiredOnly=FALSE){
  # take name of the category 'users
  # construct the url by pasting docsurl and the category
  docurl <- 'http://localhost:8080/opencga-1.0.0-rc3/webservices/rest/api-docs/'
  category <- stringi::stri_trans_totitle(category)
  drl <- paste0(docurl,category)
  # get the json api docs
  Data <- fromJSON(drl)
  Data <- Data$apis
  # take the name of the action exctract the operations and the parameters
  action <- action
  index <- grep(action, Data$path)
  operations <- Data$operations[[index]]$parameters[[1]]
  if(requiredOnly==TRUE){
   operations <- subset(operations, required==TRUE)
  }else{
    operations <- operations
  }
   operations
}
#' @export
cgaHelp <- function(){
  host <- "http://localhost:8080/opencga-1.0.0-rc3/webservices/rest/"
  #category <- stringi::stri_trans_totitle(category)
  cgaDocsUrl <- paste0(host, "swagger.json")
  Datp <- fromJSON(cgaDocsUrl)
  tags <- Datp$tags
  paths <- Datp$paths
  api <- lapply(paths, function(x)x$get)
  return(list(tags=tags, paths=paths, api=api))
}

##
# new login function
#' @export
cgalogin <- function(baseurl, username, password){
  
  url <- paste(baseurl,"/users/", username, "/login", sep="")

 #print(url)
 pass <- password
 req <- POST(url = url, body = list(password=pass), encode = 'json')
 res <- content(req)
 sessionId <- res$response[[1]]$result[[1]]$sessionId
 
return(new("Opencga",baseurl=baseurl, sessionID=sessionId, userID=username))
  
}
