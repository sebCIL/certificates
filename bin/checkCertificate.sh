#!/bin/bash

checkCertificate(){
  getConnectionUser
  getConnectionPwd
  echo ""
  getDcmPwd
  echo ""
  connection
  getCertificatName
  listCertificate
  echo ""
  logout
}
