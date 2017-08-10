countSections <- function(x){
  length(unlist(strsplit(x, split = "/")))
}

splitPath <- function(x){
  unlist(strsplit(x, split = "/"))
}