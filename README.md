# RMauthClient

This simple library can enable you to post and get requests via MAuth v1 in R. It should return back to you a valid response after authorization, which you will have to interpret on your own.


## Usage

First of all, you will need a special version of the PKI library for R which has SHA512 support, and support for private_encrypt (deprecated in openssl, replaced by sign(), though slightly different from what MAuth v1 needs).

Before you install this though, make sure you have the libraries `base64enc` and `openssl` pre-installed via the `install.packages` command.

Using the base PKI library, I added code to support SHA512 and included this version of PKI all tar'd up in /PKI_SHA512.

To install the above libraries, please run the following from the root of this repo:

```
Rscript PKI_SHA512/install_prereqs.R
```

The special PKI version, and the other libraries will be installed for you automatically.

Other than that, you will have to package the RMauthClient library, by doing the following:

You can use RStudio to build a package by going to `Build>Build Source Package`, which you will then use to install (ie. `R CMD install ....`)

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
