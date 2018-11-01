## nounprojectR
R package to use the [Noun Project](https://thenounproject.com/) API

[![Build Status](https://travis-ci.org/CaRdiffR/nounprojectR.svg?branch=master)](https://travis-ci.org/CaRdiffR/nounprojectR)

To use this package you need to [register with the Noun Project](https://thenounproject.com) and [create an app to get your own key and secret](https://thenounproject.com/developers/apps/). 
Copy and paste appname, key and secret and replace in this script:

```R
# this function puts these details into your system file. You might need to restart R-Studio. 
np_credentials(your_appname, your_key, your_secret)

# this should download and show the icon of a plane
res <- get_nouns_api("icon/609") 
get_png(res)

# this should download and show the icon of four dogs
# make the url
url <- nounprojectR::make_term_endpoint("dog", num_of_imgs = 4)
# hit the Noun Project server 
res <- get_nouns_api(url)
# extract the JSON file
result <- httr::content(res)
# show the images
get_pngs_and_show(result)
```

Please raise [issues](https://github.com/CaRdiffR/nounprojectR/issues) if you need help or would like to make comments. 

## A Hacktoberfest 2018 project - building an R package to query the noun project api for hacktoberfest!
[Hacktoberfest GitHub blog](https://blog.github.com/2018-09-24-hacktoberfest-is-back-and-celebrating-its-fifth-year/)
