#!/bin/bash -eux

echo "==> OpenSSL setting"
cp -fp /etc/ssl/openssl.cnf /etc/ssl/openssl.cnf.orig
sed -e "s/^MinProtocol = TLSv1.2/MinProtocol = NONE/" -e "s/CipherString = DEFAULT@SECLEVEL=2/CipherString = DEFAULT/" /etc/ssl/openssl.cnf.orig > /etc/ssl/openssl.cnf
