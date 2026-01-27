# Certificates

This script allows you to send a certificate to one (or more) machines and assign it (or them) to applications.\
This script use Remote System Explorer API (https://www.ibm.com/support/pages/node/6982701).

The settings are configured in the files located in the env directory.

⚠️ You MUST start start and secure the RSE API. ⚠️

**Take note**: The script can be launch from an Linux server.

## ✅ Needed
- On IBMi, the SSH Server is running (Command launch `STRTCPSVR SERVER(*SSHD)`)
- SSH access to one IBMi
- CURL installed
- bash

## Settings
- `env/applicationsList.sh`: List the applications to be assigned
- `env/serversList.sh`: List the servers and their associated ports

## Features

### Import certificate on IBMi DCM
✔️  Prerequisites:
- 1️⃣  The file is present in the IFS.
- 2️⃣  A security admin user profil (QSECOFR type)
- 3️⃣  The password associated with the profile
- 4️⃣  The DCM password

⚙️  The steps include:
-  1️⃣  Connecting to the API server
-  2️⃣  Sending the certificate in DCM
-  3️⃣  Certificate dissociation
-  4️⃣  Certificate association
-  5️⃣  Logout

### Check a certificate exist
✔️  Prerequisites:
- 1️⃣  A security admin user profil (QSECOFR type)
- 2️⃣  The password associated with the profile
- 3️⃣  The DCM password
- 4️⃣  The certificate name

⚙️  The steps include:
- 1️⃣  Connecting to the API server
- 2️⃣  Check certificate
- 3️⃣  Logout

### Delete a certificate
✔️  Prerequisites:
- 1️⃣  A security admin user profil (QSECOFR type)
- 2️⃣  The password associated with the profile
- 3️⃣  The DCM password
- 4️⃣  The certificate name

⚙️  The steps include:
- 1️⃣  Connecting to the API server
- 2️⃣  Delete certificate
- 3️⃣  Logout

Parameters:
- applications: env/applicationsList.sh
- servers: env/serersList.sh

## ⚠️ Warning
- Tested only with Bash
- Don't forget to make the script executable. (`chmod +x certificate.sh`)

## 📋 TODO:
- Assign certificates to HTTPAdmin instances