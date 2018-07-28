\name{RMauthClient}
\alias{RMauthClient}
\title{
  RMauthClient
}
\description{
  \code{RMauthClient} initializes an RMauthClient object, which can be used to
  pass to \code{makeMAuthCall} to make an MAuth call.
}
\usage{
  RMauthClient(app_uuid=NULL, mauth_base_url=NULL, mauth_api_version="v1", 
  private_key=NULL)
}
\arguments{
  \item{app_uuid}{A valid application uuid which has been pre-registered with a 
    valid mauth instance you are making requests to}
  \item{mauth_base_url}{The base url of the mauth instance your app_uuid and 
    keys are registered with}
  \item{mauth_api_version}{Should be v1, but if its something else, please 
    specify it.}
  \item{private_key}{Your private key, in pem format, as a string Note: IT
    SHOULD BE A CHARACTER VECTOR, one item per line of the keyfile (see example
    usage file)}
}
%\details{
  %}
\value{
  RMAuthClient object
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
}