#Mauth Client for R
library(PKI)
library(digest)
library(jsonlite)
library(httr)
library(openssl)

RMauthClient<-setClass(
  "RMauthClient",
  slots=c(
    app_uuid="character",
    mauth_base_url="character",
    mauth_api_version="character",
    private_key="character"
  )
)

setMethod("initialize", "RMauthClient", function(.Object, app_uuid=NULL, mauth_base_url=NULL, mauth_api_version="v1", private_key=NULL){
  requiredConfigs<- c("app_uuid", "mauth_base_url", "mauth_api_version", "private_key")
  
  lapply(seq(1,length(requiredConfigs)), function(c){
    if(is.null(eval(as.symbol(requiredConfigs[c])))){
      stop(paste("missing config element", requiredConfigs[c]))
    }
  })
  
  .Object@app_uuid <- app_uuid
  .Object@mauth_base_url <- mauth_base_url
  .Object@mauth_api_version <- mauth_api_version
  .Object@private_key <- private_key
  .Object
})

composeMAuthHeader<-function(RMauthClientObject, method, base_url, route, body="")
{
  load_pk<-function()
  {
      PKI.load.key(what=RMauthClientObject@private_key, format = "PEM", private = T)
  }
  
  make_headers<-function(app_uuid, signature, time)
  {
    list(
      'X-MWS-Authentication' = sprintf('MWS %s:%s',app_uuid,signature),
      'X-MWS-Time' = time,
      'Content-Type' = 'application/json;charset=utf-8')
  }
  
  make_request_string<-function(app_uuid, route, http_req_method, message_body, time)
  {
    s<-sprintf('%s\n%s\n%s\n%s\n%s', http_req_method, route, message_body, app_uuid, time)
    sha512(s)
  }
  
  generate_padding<-function(hashed_bin, keylength)
  {
    padding_length=keylength-length(hashed_bin)-3
    as.raw(c(0x00,0x01, rep(0xff, padding_length),0x00,hashed_bin))
  }
  
  sign_request<-function(request_string, pk)
  {
    PKI.pencrypt(generate_padding(charToRaw(request_string),256), key=pk)
  }
  
  request_time<-as.character(as.integer(Sys.time()))
  
  private_key<-load_pk()
  signed_string<-sign_request(make_request_string(RMauthClientObject@app_uuid, route, method, body, request_time), 
                              private_key)
  
  make_headers(RMauthClientObject@app_uuid, base64encode(signed_string), request_time)
}

makeMAuthCall<-function(RMauthClientObject, method, base_url, route, body="", queryString="", retryAttempts=5,pause_cap=1800, header_overrides=NULL)
{
  
  fullRoute=paste0(route, queryString)
  mAuthHeader<-composeMAuthHeader(RMauthClientObject, method, base_url, route, body)
  
  if(!is.null(header_overrides) && !is.null(header_overrides$`Content-Type`)){
    mAuthHeader$`Content-Type`<-NULL
    mAuthHeader<-append(mAuthHeader, header_overrides)
  } else if (!is.null(header_overrides)){
    mAuthHeader<-append(mAuthHeader, header_overrides)
  }
  
  mAuthHeader<-setNames(as.character(mAuthHeader), names(mAuthHeader))
  requestURL = paste0(base_url,fullRoute)
  
  if(method=="GET")
  {
    GET(paste(base_url,route,sep = ""), 
        add_headers(.headers = mAuthHeader))  
  }  else if (method=="POST"){
    POST(paste(base_url,route,sep = ""), 
         add_headers(.headers = mAuthHeader),
         body=body,timeout(1800))
  } else {
    stop("Not Supported HTTP Verb. Please use only GET or POST.")
  }
}
