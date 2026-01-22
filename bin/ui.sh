#!/bin/bash

ICON_READ_DATA=📝
ICON_ERROR=❌
ICON_SUCCESS=✅

FONT_BOLD="\033[1m"
FONT_BOLD_CYAN="\033[1;36m"

FONT_RESET="\033[0m"

showWelcomeInitMessage() {
  clear
  echo -e "$FONT_BOLD━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$FONT_RESET"
  echo -e "  🧰 $FONT_BOLD Implementation of a new certificate $FONT_RESET"
  echo -e "$FONT_BOLD━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$FONT_RESET\n"

  echo -e "You will be able to install a new certificate."
  echo ""
  echo -e "⚙️  Prerequisites:"
  echo -e "  1️⃣  The file is present in the IFS."
  echo -e "  2️⃣  A security admin user profil (QSECOFR type)"
  echo -e "  3️⃣  The password associated with the profile"
  echo -e "  4️⃣  The DCM password"
  echo ""
  echo -e "⚙️  The steps include:"
  echo -e "  1️⃣  Connecting to the server"
  echo -e "  2️⃣  Sending the certificate in DCM"
  echo -e "  3️⃣  Certificate dissociation"
  echo -e "  4️⃣  Certificate association"
  read -p "Press [Enter] to begin... "
  echo ""
  clear
}

showTitle() {
    icon=$1
    title=$2

    echo -e "$FONT_BOLD━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$FONT_RESET"
    echo -e "$icon $FONT_BOLD $title $FONT_RESET"
    echo -e "$FONT_BOLD━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$FONT_RESET"
}

