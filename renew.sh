#!/bin/bash

#============================================================================
# Service...... : Cooperl                                                    
# Application.. : Certificats                                                
# Objet........ : Import and associate certificate
# Création..... : 21/01/26 par Sébastien BOURREAU                            
# Modifications :                                                            
#  +    /  /   par                                                           
#============================================================================

PATH=/QOpenSys/pkgs/bin:$PATH
export PATH PASE_PATH

source ./bin/ui.sh
source ./bin/certificat-info.sh
source ./bin/connection-info.sh
source ./env/applicationsList.sh

hostname=$(hostname)
BASEURL=https://$hostname:2012/rseapi/api/v1

showWelcomeInitMessage

explainConnectionInfo

getConnectionUser
echo ""
getConnectionPwd
echo ""
getDcmPwd

explainCertificatInfo

getCertificatInfo
echo ""
getCertificatPwd
echo ""
getCertificatName
echo ""

showTitle 📜 "Upload certificate on IBMi"

# Base64 encoding of the certificate
certificatBase64=$( base64 -w 0 $certificat_path)

### Connection
curl -v -k \
  --request POST \
  --url "$BASEURL/session" \
  --header 'Content-Type: application/json' \
  --data '{"host": "localhost",
  "userid": "'$user_name'",
  "password": "'$user_password'",
  "additionalFactor": ""}' > /dev/null 2>connection.log

BEARER=$(grep -i '< Authorization:' connection.log | sed 's/< Authorization: //g')

if [[ -z "$BEARER" ]]; then
  echo -e "$ICON_ERROR Connection error. Check your username and password. \n" >&2
  exit 1
else
  echo -e "$ICON_SUCCESS Connection established. \n" >&2
fi

### Sending the certificate in DCM
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
  echo -e "$ICON_ERROR Error importing certificate. Check the log file. 'import.log' \n" >&2
  exit 1
fi

echo ""

showTitle ⛓️‍💥 "Disassociate certificates"

### Certificate dissociation
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

echo ""

showTitle 🔗 "Associate certificates"

### Certificate association
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

### Delete session
curl -v -k \
-X 'DELETE' \
  "$BASEURL/session" \
  -H 'accept: application/json' \
  -H "Authorization: $BEARER" > /dev/null 2>logout.log

echo "💾 Check log files"
echo "✅ Done !"
