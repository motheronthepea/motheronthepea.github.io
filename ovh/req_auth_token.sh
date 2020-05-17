#!/usr/bin/env bash

if [[ "$#" -ne 2 ]]; then 
  echo "usage: $0 <application-key> <access-rules-json-file>"
  echo
  echo "Go to https://eu.api.ovh.com/createApp/ to create an Application Key"
  exit
fi

curl -XPOST -H "X-Ovh-Application: $1" -H "Content-type: application/json" \
  https://eu.api.ovh.com/1.0/auth/credential  -d "@$2"
