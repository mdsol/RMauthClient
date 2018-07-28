\name{makeMAuthCall}
\alias{makeMAuthCall}
\title{
  makeMAuthCall
}
\description{
  \code{makeMAuthCall} will make a call to MAuth v1 and return a response, which you must deal with on your own.
}
\usage{
  makeMAuthCall(RMauthClientObject, method, base_url, route, body="")
}
\arguments{
  \item{RMauthClientObject}{Valid RMauthClient object.}
  \item{method}{either "GET" or "POST"}
  \item{base_url}{base url of the service you are calling}
  \item{route}{the route of the service you want to get a response from}
  \item{body}{Body of the request, ie. for POST requests.}
  \item{header_overrides}{any additional headers or overrides (ie. Content-Type) in a named list}
  
}
%\details{
  %}
\value{
  Response (likely in json, depending on the service.)
}
%\references{
  %}
\author{
  Pramod Somashekar <psomashekar@mdsol.com>
}
%\note{
  %}
\seealso{
  \code{\link{RMauthClient-package}}
}
\examples{
  data(testKey) 
  
  c <- RMauthClient(app_uuid="aaabbbcc-dddd-abcd-abcd-eff6b4b0b637", 
                    mauth_base_url="https://mauth-sandbox.imedidata.net",
                    private_key=testKey)

  response<-makeMAuthCall(c, 
                         "GET",
                         "https://eureka-sandbox.imedidata.net",
                         "/v1/apis",
                         "")
}