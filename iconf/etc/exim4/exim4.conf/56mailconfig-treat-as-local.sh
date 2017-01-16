#!/bin/sh

# source config
. /usr/lib/iserv/cfg

if [[ ! -z "${MailTreatAsLocal[@]}" ]]
then
  echo "domainlist treat_as_local_domains = "$(echo "${MailTreatAsLocal[@]}" | sed "s/ / : /g")
else
  # if there is no value, just use localhost...
  echo "domainlist treat_as_local_domains = localhost"
fi  
echo
echo 
echo