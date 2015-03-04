#this is a basic example of how the R Mauth Client can be utilized....
library(base64enc)
library(openssl)
library(PKI)
library(RMauthClient)

#Step 0: initialize your Mauth Client Configuration:
key<-as.vector(strsplit("-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAqdxoaxAlVjs4f+TITZNmOhxv1Os6Wh7pghAt5IiFlMaEDXt4\nH8OvW/uww7McPtZ3oY1BpRW1w3Xbg7tQZX9fq8qHBBeXP8ZNMLILRkQu19neqwEJ\nGNGIIArv6coPTPMCntUvDcHT/yv8MKOPi9ArtgSxEdcOqqlP/IMUud6Rmp+19Wn8\nbJdzErwDsdHrgf/Luj2fDqbDbdnnKYWUyEHKmYylqC+oox53Hld6w0+9COu9Evwj\n3ThM3GKRUxyCQ+YYqAaCcROtAwbzqOiVCiHmqcXs3iE5qdYr53/SKtW8bd2nShjj\nRMAFa5QGaaRBzu5/HKFnH4xzI32JUcsVuS0+DQIDAQABAoIBADZrCnjiX1PU/TDc\nFt/jjSio25sXEUa2CJFGpa1Fn6YeQ0geekmS46dQZz0LMM1g4Eq9en5tCiJoq770\nT7l0qS3cYI0LEcW4vhoPsFT+mxNEFXYrisKMvlOlrV71ARnh8MD6A20g384sRUs/\n20krlBVoQ2I3x9cdDycSx50UlQk4A6ntnrtYnsduu1t8t3N9oZWh3sIaDdEtKR4C\nbsoM73mLh8VBADYhS3f+NtOKEsb8R80zWHVOdXe7EVRScE5YlPNKNpJv/Xl6k2Sw\nj2n3axReiPkgWyOFEjqvUIylDkodj8WdsFZ8U7nj0andfoHlytv+PY00JyZLHo0R\n1EA6b3ECgYEA3obMW9AixBEPKjiH6qxB6BDIZkrkptffESl0n0tTm+cBeFNDgGRW\nLDE4bogbY3eO2YzycS5TkFL0KeWBw+wZ05Je+/hK0/jhEkjWCe5Pfo3CiHNpj7ig\nBjGzcltqZq71+BzTvx18brgxtvRrjR1WM4dFCIQvcLBv0IYAUmIv3SMCgYEAw2mH\nIsUKlJJo4JE8Hc1v/RSp48478W7Hvpmm+CoeyefpVpUlDinK26nYZIjWVuvYS2/b\nfc6oIPqS67P662YORA/cXtyWhFrdGmXT9/vkGQ3NF/KgZZEIO3cPTDRnpC4ObzL1\nYGI4ZKJqzVDZNREiTvnEba8YSWG2UEbvRs1Gow8CgYAiImFUsB+1HbzKyDMpL1VI\nyNJExrY+VZzVIBvQl5hysMPL9lHDbyC81KwIYH57CoryGinSbL3KxL7JcnguWpg3\nmRtS4WpxC5tS17NlgJXXHt25WqLVtgduC8+v+g/fQnVeouVkSpycy0ps+x9IXTis\n3NIdFVHFonr0bKm9+WvIKwKBgCYmpS6Bn7Yv+2/UixMad8HGVgDW09coFLE+mF2d\nA5PRxjmUNr7UI/nM6CWAnbAsrXbU6NpgDW0a3rJL2mURuolJO3H9yRkgEEjGFqM0\nt2y4yBDj2rLZpOzPKtpq5M0l/MVzAnsF0hK7rvRU04NLzBH1K4dqhuhUvl5f6vk8\nvIy7AoGAQepXAvpDPKVIfxEJbxTKDocCbEuhG50NAmfyhqo0T4OlYCWzs5xtCwQF\n3Fe/7tI+askxPTMk9NzxqmWXx+3Fe6vSn8vRPELKpcQ0bNFxZh+oXT3SS1QbNOaF\nNQZbJH8EA9PppYKYlMo9xS+2AFsSC16h2OYO3P7XH/zg3ooIFzc=\n-----END RSA PRIVATE KEY-----", '\n'))[[1]]
myMauthClient<- RMauthClient(app_uuid="12345678-4599-47db-b57d-b6e750596500",
                             mauth_base_url="https://mauth-sandbox.imedidata.net",
                             private_key=key)
#Step 1: make the call
response<-makeMAuthCall(myMauthClient, "GET", "https://eureka-sandbox.imedidata.net", "/v1/apis", "")

#Step 2: get response text out
content(response, "text")