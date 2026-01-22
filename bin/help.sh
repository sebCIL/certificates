#!/bin/bash

help() {
  clear
  echo -e "$FONT_BOLD━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$FONT_RESET"
  echo -e "  🧰 $FONT_BOLD Implementation of a new certificate $FONT_RESET"
  echo -e "$FONT_BOLD━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━$FONT_RESET\n"

  echo -e "Syntax: renew [-h|l|c|d]"
  echo ""
  echo -e "⛑️  Options:"
  echo -e " h     Print this Help."
  echo -e " l     List steps"
  echo -e " c     Check a certificate exist"
  echo -e " d     Delete a certificate"
}
