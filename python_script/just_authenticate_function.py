import requests
from requests_oauthlib import OAuth1

def noun_auth(key, secret, url):
    # values for authentication
    auth = OAuth1(key, secret)
    endpoint = url

# go get the info from the website
    response = requests.get(endpoint, auth=auth)
    data = response.json()
    return data

