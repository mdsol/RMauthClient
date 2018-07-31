# RMauthClient

This simple library can enable you to post and get requests via MAuth v1 in R. It should return back to you a valid response after authorization, which you will have to interpret on your own.


## Usage

### Prerequisites

Install the necessary packages using Brew:

```
brew install r
brew install libgit2
```

Install the necessary R libraries by running the following from the root of this repository:

```
Rscript ./install_prereqs.R
```

### Create Source Package

You can package the RMauthClient library using RStudio:
  - Open the `RMauthClient.Rproj` file
  - In the menu bar, select `Build > Build Source Package`
  - From the command line, run `R CMD install RMauthClient_<VERSION_NUM>.tar.gz` for the newly built tarball

Note, that depending on your version of the compiler and OS, you may receive an error when trying to install the library. But, nevertheless, the library should install properly.


## Making Requests

First, you need a set of keys, public and private, for which has been previously authorized with a target Mauth instance.

Registering and generating a key is beyond the scope of this readme, but you should be able to do it with the following commands on your Unix/ Linux terminal (it is a 2048 bit key):

```
openssl genrsa -out yourname_mauth.priv.key 2048
chmod 0600 yourname_mauth.priv.key
openssl rsa -in yourname_mauth.priv.key -pubout -out yourname_mauth.pub.key
```

Once you have your key, registered with a valid MAuth instance, you should be able to make calls with this library to your designated resource(s).

The following example demonstrates how to use the library to perform valid MAuth requests:

1) Your private key will be passed in as a vector, which each line representing a line in the pem file. From a contiguous string with `\n` delimiting lines, you can transform your key in R by doing the following:

```
key<-as.vector(strsplit("-----BEGIN RSA PRIVATE KEY-----\n...your key here\n-----END RSA PRIVATE KEY-----", '\n'))[[1]]
```

2) Using the key, create an instance of the RMauthClient class:

```
myMauthClient<- RMauthClient(app_uuid="12345678-4599-47db-b57d-b6e750596500",
                             mauth_base_url="https://mauth-sandbox.imedidata.net",
                             private_key=key)
```

3) Now that you have an instance of the RMauthClient class, you may use it to make valid calls to your resource:

```
response<-makeMAuthCall(myMauthClient, "GET", "https://eureka-sandbox.imedidata.net", "/v1/apis", "")
```

4) I use httr to perform the GET and POST requests to the resources, therefore, you can get your reponse blob out either using:

```
content(response, "text")
```

Or, if your resource is outputting JSON, then you may use the following:

```
content(response)
```

However, that might be messy as the way the httr gives back JSON responses is not very good for data analysis purposes, so you might want to use `RJSONIO` or other packages specialized in reading and transforming your specific content types.

For a complete example including all this, please see the examples/exampleUse.R


## Unit Tests

There are some unit tests done using RUnit. Since this is outside the package, you should install the RUnit package on your own by doing `install.packages("RUnit")`.

To run the tests, simply use RStudio to load up the RMauthClient.Rproj and then navigate to the `tests` directory. Source `run_tests.R`.

To add tests, simply add more R files to the tests folder by naming them appropriately (ie. 1.R, 2.R, etc.). Inside each file, create a function that describes your test suite, and inside that put your tests for that feature. Please see 1.R for an example.


## Package Usage

Please see the Documentation for the package inside R once loaded up.


## Contributing

Sure, why not? Please send a PR as necessary for review.
