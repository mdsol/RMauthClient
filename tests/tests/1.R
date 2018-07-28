library(RMauthClient)
library(openssl)
# 

data(testKey)

test.RMAuthClientHeaderCompositionEncodingAndConfigLoad<-function()
{
  #setup
  mauth_base_url<-"https://mauth-sandbox.imedidata.net"
  mauth_api_version<-"v1"
  app_uuid<- "aaabbbcc-dddd-abcd-abcd-eff6b4b0b637"
  c<-RMauthClient(mauth_base_url = mauth_base_url, mauth_api_version = mauth_api_version, app_uuid = app_uuid, private_key = testKey)
  
  generate_padding<-function(hashed_bin, keylength)
  {
    padding_length=keylength-length(hashed_bin)-3
    as.raw(c(0x00,0x01, rep(0xff, padding_length),0x00,hashed_bin))
  }
  
  #prechecks
  
  #it should have loaded the key properly
  checkTrue("-----BEGIN RSA PRIVATE KEY-----" %in% c@private_key[[1]])
  
  #it should have loaded the rest of the config properly
  checkTrue(c@mauth_base_url=="https://mauth-sandbox.imedidata.net" &&
              c@mauth_api_version=="v1" && 
              c@app_uuid=="aaabbbcc-dddd-abcd-abcd-eff6b4b0b637")
  
  
  #testing
  headerVal<-composeMAuthHeader(c, "GET", "https://mdsol.com", "/api/v1/tests", "")
  
  #it should contain the following headers
  checkTrue(all(names(headerVal) %in% c("X-MWS-Authentication","X-MWS-Time","Content-Type")))
  
  #it should have the following for content type
  checkEquals(headerVal$`Content-Type`,"application/json;charset=utf-8")
  
  #it should have base64 encoded the message in the following way
  checkTrue(
  paste("MWS ", c@app_uuid, ":",
  base64_encode(
  PKI.pencrypt(generate_padding(charToRaw(sha512(paste("GET\n/api/v1/tests\n\n",c@app_uuid,"\n",headerVal$`X-MWS-Time`,sep = ""))),256), 
               key=PKI.load.key(testKey,format = "PEM", private = T))
  ),sep="")==
  headerVal$`X-MWS-Authentication`
  )
    
}

test.RMAuthClientStops<-function()
{
  #setup
  mauth_base_url<-"https://mauth-sandbox.imedidata.net"
  mauth_api_version<-"v1"
  app_uuid<- "aaabbbcc-dddd-abcd-abcd-eff6b4b0b637"
  c<-RMauthClient(mauth_base_url, mauth_api_version, app_uuid, testKey)
  
  #it should return an error for http verbs not supported.
  checkException(makeMAuthCall(c, "PUT", "https://mdsol.com", "/api/v1/tests", "xyz"))
  
  #it should return an error when the config isn't available or null
  checkException(RMauthClient("blahblahblah"))
  
  #it should return an error when the configuration is missing items
  checkException(RMAuthClient(mauth_base_url="https://mauth-sandbox.imedidata.net",
                              mauth_api_version="v1",
                              private_key=testKey))
  
  #it should return an error if the private key is not found
  c@private_key=""
  checkException(composeMAuthHeader(c, "GET", "https://mdsol.com", "/api/v1/tests", ""))
  
  
}