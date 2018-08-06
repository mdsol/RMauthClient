\name{composeMAuthHeader}
\alias{composeMAuthHeader}
\title{
  composeMAuthHeader
}
\description{
  \code{composeMAuthHeader} will compose the elements of a header which can be used to call MAuth v1.
}
\usage{
  composeMAuthHeader(RMauthClientObject, method, base_url, route, body="")
}
\arguments{
  \item{RMauthClientObject}{Valid RMauthClient object.}
  \item{method}{either "GET", "POST", "PUT" or "DELETE"}
  \item{base_url}{base url of the service you are calling}
  \item{route}{the route of the service you want to get a response from}
  \item{body}{Body of the request, ie. for POST requests. (Optional)}
  
}
%\details{
  %}
\value{
  Number of values, which you can access for the different headers.
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

  headers<-composeMAuthHeader(c, 
                              "GET",
                              "https://eureka-sandbox.imedidata.net",
                              "/v1/apis",
                              "")
}