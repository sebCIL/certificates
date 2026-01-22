explainConnectionInfo() {
  echo ""
  echo "ℹ️  You will be asked for some information: " 
  echo "   1️⃣  A security admin user profil (QSECOFR type)"
  echo "   2️⃣  The password associated with the user profile"
  echo "   3️⃣  The DCM password"
  echo ""
}

getConnectionUser() {
  while true; do
    read -p "$ICON_READ_DATA Enter a user profil: " user_name
    if [[ -z "$user_name" ]]; then
      echo -e "$ICON_ERROR The user profile cannot be empty. Please try again.\n" >&2
    else
      user_name=${user_name}
      break
    fi
  done
}

getConnectionPwd() {
  while true; do
    read -sp "$ICON_READ_DATA Enter the user profile password: " user_password
    if [[ -z "$user_password" ]]; then
      echo -e "$ICON_ERROR The user profile password cannot be empty. Please try again.\n" >&2
    else
      user_password=${user_password}
      break
    fi
  done
}

getDcmPwd() {
  while true; do
    read -sp "$ICON_READ_DATA Enter the DCM password: " dcm_password
    if [[ -z "$dcm_password" ]]; then
      echo -e "$ICON_ERROR The DCM password cannot be empty. Please try again.\n" >&2
    else
      dcm_password=${dcm_password}
      break
    fi
  done
}
