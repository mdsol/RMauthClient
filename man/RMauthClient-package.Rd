\name{RMauthClient}
\alias{RMauthClient}
\docType{package}
\title{
RMauthClient
}
\description{
This simple library can enable you to post and get requests via MAuth v1 in R. It should return back to you a valid response after authorization, which you will have to interpret on your own.
}
\details{
\tabular{ll}{
Package: \tab RMauthClient\cr
Type: \tab Package\cr
Version: \tab 1.1\cr
Date: \tab 2015-03-03\cr
License: \tab MIT + file LICENSE\cr
}
Usage is really simple.
Simply create an MAuthClient object, and then call makeMAuthCall with the appropriate parameters.

You will need a valid configuration for MAuth, passed in as the parameters when initializing RMauthClient.

The private key, must be a 2048 bit RSA key for which the public key already has been registered with a valid MAuth v1 service.

}
\author{
Pramod Somashekar <psomashekar@mdsol.com>

Maintainer: Pramod Somashekar <psomashekar@mdsol.com>
}
\references{
}
\keyword{ package }
\seealso{
}
\examples{
c<-RMauthClient(app_uuid="aaabbbcc-dddd-abcd-abcd-eff6b4b0b637", mauth_base_url="https://mauth-sandbox.imedidata.net", private_key=testKey)
response<-makeMAuthCall(c, "GET","https://eureka-sandbox.imedidata.net", "/v1/apis", "")
f<-fromJSON(content(d,"text")) #f is now a valid frame.

}
