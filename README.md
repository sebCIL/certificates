# Certificates

## ✅ Needed
- SSH access
- curl installed
- bash

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

## ⚠️ Warning
- Tested only with Bash
- Don't forget to make the script executable. (`chmod +x renew.sh`)

## 📋 TODO:
- Multi-partition
- Assign certificates to HTTPAdmin instances