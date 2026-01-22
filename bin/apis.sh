#!/bin/bash

### Connection
connection() {
  curl -v -k \
    --request POST \
    --url "$BASEURL/session" \
    --header 'Content-Type: application/json' \
    --data '{"host": "localhost",
    "userid": "'$user_name'",
    "password": "'$user_password'",
    "additionalFactor": ""}' > /dev/null 2>connection.log

  BEARER=$(grep -i '< Authorization:' connection.log | sed 's/< Authorization: //g')
}

### Send the certificate in DCM
sendCertificate() {
  curl -v -k \
    --request POST \
    --url "$BASEURL/security/dcm/cert/import" \
    --header 'accept: */*' \
    --header "Authorization: $BEARER" \
    --header 'Content-Type: application/json' \
    --data '{"certStoreType": "CMS", 
    "certStorePath": "*SYSTEM", 
    "certStorePassword": "'$dcm_password'", 
    "certType": "SERVER_CLIENT", 
    "certFormat": "PKCS12", 
    "certAlias": "'$certificat_name'", 
    "certData": "'$certificatBase64'", 
    "certDataPassword": "'$certificat_password'" }'  > /dev/null 2>import.log
  
  STATUS=$(grep -i '< HTTP/1.1' import.log | cut -c 12-15)
  
  if [ "$STATUS" -eq 204 ]; then
    echo -e "$ICON_SUCCESS Import finished. \n" >&2
  else
    echo -e "$ICON_ERROR Error importing certificate. Check the log file: 'import.log' \n" >&2
    exit 1
  fi
}

### Certificate dissociation
dissociate() {
  for application in "${applications[@]}"
  do
     
    curl -v -k \
      --request POST \
      --url "$BASEURL/security/dcm/appdef/disassociate" \
      --header 'accept: */*' \
      --header "Authorization: $BEARER" \
      --header 'Content-Type: application/json' \
      --data '{"appDefinitionID": "'$application'"}'  > /dev/null 2>>disassociate.log
  
  done
  
  echo -e "$ICON_SUCCESS Disassociated finished. \n" >&2
}

### Certificate association
associate() {
  for application in "${applications[@]}"
  do
     
    curl -v -k \
      --request POST \
      --url "$BASEURL/security/dcm/appdef/associate" \
      --header 'accept: */*' \
      --header "Authorization: $BEARER" \
      --header 'Content-Type: application/json' \
      --data '{"appDefinitionID": "'$application'", "certAliases": ["'$certificat_name'"]}'  > /dev/null 2>>associate.log
  
  done
  
  echo -e "$ICON_SUCCESS Associated finished. \n" >&2
}

### List certificate
listCertificate() {
  curl  -v -k \
    --request POST \
    --url "$BASEURL/security/dcm/cert/list" \
    --header 'accept: application/json' \
    --header "Authorization: $BEARER" \
    --header 'Content-Type: application/json' \
    --data '{
      "certStoreType": "CMS",
      "certStorePath": "*SYSTEM",
      "certStorePassword": "'$dcm_password'", 
      "filters": {
        "certAlias": "'$certificat_name'",
        "certTypes": [
          "SERVER_CLIENT"
        ],
        "daysUntilExpiration": 5000,
        "excludeExpired": false
      }
    }'  2>list.log
}

### Delete certificate
deleteCertificate() {
  curl  -v -k \
    --request POST \
    --url "$BASEURL/security/dcm/cert/delete" \
    --header 'accept: application/json' \
    --header "Authorization: $BEARER" \
    --header 'Content-Type: application/json' \
    --data '{
      "certStoreType": "CMS",
      "certStorePath": "*SYSTEM",
      "certStorePassword": "'$dcm_password'", 
      "certAlias": "'$certificat_name'"
    }'  2>delete.log
}

### Delete session
logout(){
  curl -v -k \
  -X 'DELETE' \
    "$BASEURL/session" \
    -H 'accept: application/json' \
    -H "Authorization: $BEARER" > /dev/null 2>logout.log
}