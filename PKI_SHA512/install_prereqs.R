#this script will install the necessary libraries needed by the RMauthClient
packages <- c("base64enc", "openssl")

if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())), repos = "http://cran.us.r-project.org")  
}

#install special PKI with SHA512 support
#assumes you are in the root repo dir as your working directory
install.packages("./PKI_SHA512/PKI_SHA512.tar", repos=NULL, type="source")
