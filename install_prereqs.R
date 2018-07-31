# This script will install the necessary libraries needed by the RMauthClient
packages <- c("base64enc", "openssl", "httr", "git2r", "devtools")

if (length(setdiff(packages, rownames(installed.packages()))) > 0) {
  install.packages(setdiff(packages, rownames(installed.packages())), repos = "http://cran.us.r-project.org")
}

install_github("mdsol/PKI")
