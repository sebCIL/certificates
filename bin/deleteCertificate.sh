#!/bin/bash

checkCertificate(){
  getConnectionUser
  getConnectionPwd
  echo ""
  getDcmPwd
  echo ""
  connection
  getCertificatName
  deleteCertificate
  echo ""
  logout
}
