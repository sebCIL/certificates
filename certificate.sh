#!/bin/bash

#============================================================================
# Service...... : Cooperl                                                    
# Application.. : Certificats                                                
# Objet........ : Import and associate certificate
# Création..... : 21/01/26 par Sébastien BOURREAU                            
# Modifications :                                                            
#  +  27/01/26 par Sébastien BOURREAU: Multi server
#============================================================================

PATH=/QOpenSys/pkgs/bin:$PATH
export PATH PASE_PATH

source ./bin/ui.sh
source ./bin/help.sh
source ./bin/certificat-info.sh
source ./bin/connection-info.sh
source ./bin/apis.sh
source ./bin/checkCertificate.sh
source ./env/applicationsList.sh
source ./env/serversList.sh

while getopts ":hlcd" option; do
  case $option in
    h) # display Help
      help
      exit;;
    l) # display steps
      showSteps
      exit;;
    c) # check certificate
      checkCertificate
      exit;;
    d) # check certificate
      deleteCertificate
      exit;;
    \?) # incorrect option
      echo "Error: Invalid option"
      exit;;
  esac
done

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

# Base64 encoding of the certificate
certificatBase64=$( base64 -w 0 $certificat_path)

for server in "${!servers[@]}"
  do

    BASEURL=https://$server:${servers[$server]}/rseapi/api/v1

    showTitle 📜 "Upload certificate on IBMi: $server"
    
    ### Connection to the API
    connection
    
    ### Send the certificate in DCM
    sendCertificate
    
    echo ""

    showTitle ⛓️‍💥 "Disassociate certificates"
    
    ### Certificate dissociation
    dissociate

    echo ""

    showTitle 🔗 "Associate certificates"
    
    ### Certificate association
    associate

    ### Delete API session
    logout

    echo "✅ Server: $server done !"

  done

echo "💾 Check log files"
echo "✅ Done !"