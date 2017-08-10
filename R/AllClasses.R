require(methods)
require(miniUI)
require(shiny)
#' @include OpencgaFunctions.R
#' This class defines the Opencga object
Opencga <- setClass("Opencga", slots = c(baseurl="character",
    userID="character", sessionID="character"))

## A constructor function

Opencga <- function(baseurl, userID, sessionID){
  new("Opencga", baseurl=baseurl, userID=userID, sessionID=sessionID)
}


#' 
#' A class to store Opencga parameters for filtering queries
#' 
#' This class is used to store Opencga parameters for filtering queries
#' @aliases cgaVariantParam
#' @param chromosome the name of the chromosome to be returned
#' @export
cgaVariantParam <- setClass("cgaVariantParam", slots = c(region="character",
                          chromosome="character", type="character",
                          gene="character", maf="character", mgf="character",
                          genotype="character", polyphen="character",
                          sift="character", conservation="character",
                          reference="character", alternate="character",
                          so="character", biotype="character", skip="numeric",
                          limit="character", files="character",
                          returnedStudies='character',
                          returnedSamples='character'),
                          prototype = prototype(region=character(),
                          chromosome=character(), type=character(),
                          gene=character(), maf=character(),
                          mgf=character(), genotype=character(),
                          polyphen=character(), sift=character(),
                          conservation=character(), reference=character(),
                          alternate=character(), so=character(),
                          so=character(), biotype=character(),
                          limit=character(), files=character(),
                          returnedStudies=character(),
                          returnedSamples=character()))


cgaVariantParam <- function(region=character(), chromosome=character(),
                         type=character(), gene=character(), maf=character(),
                         mgf=character(), genotype=character(),
                         polyphen=character(), sift=character(),
                         conservation=character(), reference=character(),
                         alternate=character(), so=character(),
                         biotype=character(), limit=character(),
                         files=character(),  returnedStudies=character(),
                          returnedSamples=character())
{
  if(length(region)>0){
    region <- paste0(region,collapse = ",")
    region <- paste("region=",region,sep = "")
  }

  if(length(chromosome)>0){
    chromosome <- paste0(chromosome,collapse = ",")
    chromosome <- paste("chromosome=",chromosome,sep = "")
  }

  if(length(type)>0){
    type <- paste0(type,collapse = ",")
    type <- paste("type=",type,sep = "")
  }

  if(length(gene)>0){
    gene <- paste0(gene,collapse = ",")
    gene <- paste("gene=",gene,sep = "")
  }

  if(length(maf)>0){
    maf <- paste0(maf,collapse = ",")
    maf <- paste("maf=",maf,sep = "")
  }
  if(length(mgf)>0){
    mgf <- paste0(mgf,collapse = ",")
    mgf <- paste("mgf=",mgf,sep = "")
  }
  if(length(genotype)>0){
    genotype <- paste0(genotype,collapse = ",")
    genotype <- paste("genotype=",genotype,sep = "")
  }
  if(length(polyphen)>0){
    polyphen <- paste0(polyphen,collapse = ",")
    polyphen <- paste("polyphen=",polyphen,sep = "")
  }
  if(length(sift)>0){
    sift <- paste0(sift,collapse = ",")
    sift <- paste("sift=",sift,sep = "")
  }
  if(length(conservation)>0){
    conservation <- paste0(conservation,collapse = ",")
    conservation <- paste("conservation=",conservation,sep = "")
  }
  if(length(reference)>0){
    reference <- paste0(reference,collapse = ",")
    reference <- paste("reference=",reference,sep = "")
  }
  if(length(alternate)>0){
    alternate <- paste0(alternate,collapse = ",")
    alternate <- paste("alternate=",alternate,sep = "")
  }
  if(length(so)>0){
    so <- paste0(so,collapse = ",")
    so <- paste("so=",so,sep = "")
  }
  if(length(biotype)>0){
    biotype <- paste0(biotype,collapse = ",")
    biotype <- paste("biotype=",biotype,sep = "")
  }
  if(length(limit)>0){
    limit <- paste("limit=",limit,sep = "")
  }else{
    limit <- paste("limit=",1000,sep = "")
  }
  if(length(files)>0){
    files <- paste0(files,collapse = ",")
    files <- paste("files=",files,sep = "")
  }
  if(length(returnedStudies)>0){
    returnedStudies <- paste0(returnedStudies,collapse = ",")
    returnedStudies <- paste("returnedStudies=",returnedStudies,sep = "")
  }
  if(length(returnedSamples)>0){
    returnedSamples <- paste0(returnedSamples,collapse = ",")
    returnedSamples <- paste("returnedSamples=",returnedSamples,sep = "")
  }


  new("cgaVariantParam", region=region, chromosome=chromosome, type=type,
      gene=gene, maf=maf, mgf=mgf, genotype=genotype, polyphen=polyphen,
      sift=sift, conservation=conservation, reference=reference,
      alternate=alternate, so=so, biotype=biotype, limit=limit,
      files=files, returnedStudies=returnedStudies,
      returnedSamples=returnedSamples)
}

