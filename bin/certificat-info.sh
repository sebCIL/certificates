explainCertificatInfo() {
  echo ""
  echo "ℹ️  You will be asked for some information: " 
  echo "   1️⃣  Certificate path - Full URL of the file in the IFS"
  echo "   2️⃣  Certificate password - this corresponds to the password entered when the certificate was generated."
  echo "   3️⃣  Certificate name - this corresponds to the name that the certificate will have in DCM (e.g., Certificate_2026)"
  echo ""
}

getCertificatInfo() {
  while true; do
    read -p "$ICON_READ_DATA Enter the path to the certificate: " certificat_path
    if [[ -z "$certificat_path" ]]; then
      echo -e "$ICON_ERROR The path cannot be empty. Please try again.\n" >&2
    else
      certificat_path=${certificat_path}
      break
    fi
  done
}

getCertificatPwd() {
  while true; do
    read -sp "$ICON_READ_DATA Enter the certificate password: " certificat_password
    if [[ -z "$certificat_password" ]]; then
      echo -e "$ICON_ERROR The password cannot be empty. Please try again.\n" >&2
    else
      certificat_password=${certificat_password}
      break
    fi
  done
}

getCertificatName() {
  while true; do
    read -p "$ICON_READ_DATA Enter the certificate name: " certificat_name
    if [[ -z "$certificat_name" ]]; then
      echo -e "$ICON_ERROR The certificate name cannot be empty. Please try again.\n" >&2
    else
      certificat_name=${certificat_name}
      break
    fi
  done
}