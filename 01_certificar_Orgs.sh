
. color.sh

echo -e $WHITE_L Emisión de certificados para la organización $GREEN Org1$NORMAL!
echo -e $WHITE_L Emisión de certificado CA para $GREEN peer1-org1$NORMAL!
sleep 3

mkdir -p /tmp/hyperledger/org1/peer1/assets/ca 
cp /tmp/hyperledger/org1/ca/admin/msp/cacerts/0-0-0-0-7054.pem /tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem

mkdir -p /tmp/hyperledger/org1/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-org1:peer1PW@0.0.0.0:7054
sleep 5

echo -e $WHITE_L Emisión de certificado TLS para $GREEN peer1-org1$NORMAL!
sleep 2

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-org1:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-org1 --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/org1/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/org1/peer1/tls-msp/keystore/key.pem

echo -e $WHITE_L Emisión de certificado CA para $GREEN orderer1-org1$NORMAL!
sleep 2

# preparation
mkdir -p /tmp/hyperledger/org1/orderer1/assets/ca 
cp /tmp/hyperledger/org1/ca/admin/msp/cacerts/0-0-0-0-7054.pem /tmp/hyperledger/org1/orderer1/assets/ca/org1-ca-cert.pem

mkdir -p /tmp/hyperledger/org1/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/org1/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/orderer1/assets/ca/org1-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-org1:ordererpw@0.0.0.0:7054
sleep 5

echo -e $WHITE_L Emisión de certificado TLS para $GREEN orderer1-org1$NORMAL!
sleep 2

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-org1:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-org1 --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/org1/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/org1/orderer1/tls-msp/keystore/key.pem

echo -e $WHITE_L Emisión de certificado CA para $GREEN admin-org1$NORMAL!
sleep 2

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-org1:org1AdminPW@0.0.0.0:7054

echo -e $WHITE_L Emisión de certificado TLS para $GREEN admin-org1$NORMAL!
sleep 2
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-org1:org1AdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/org1/admin/tls-msp/keystore/*_sk /tmp/hyperledger/org1/admin/tls-msp/keystore/key.pem


mkdir -p /tmp/hyperledger/org1/peer1/msp/admincerts
cp /tmp/hyperledger/org1/admin/msp/signcerts/cert.pem /tmp/hyperledger/org1/peer1/msp/admincerts/org1-admin-cert.pem

mkdir -p /tmp/hyperledger/org1/admin/msp/admincerts
cp /tmp/hyperledger/org1/admin/msp/signcerts/cert.pem /tmp/hyperledger/org1/admin/msp/admincerts/org1-admin-cert.pem

mkdir -p /tmp/hyperledger/org1/msp/{admincerts,cacerts,tlscacerts,users}
cp /tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem /tmp/hyperledger/org1/msp/cacerts/
cp /tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/org1/msp/tlscacerts/
cp /tmp/hyperledger/org1/admin/msp/signcerts/cert.pem /tmp/hyperledger/org1/msp/admincerts/admin-org1-cert.pem
cp ./org1-config.yaml /tmp/hyperledger/org1/msp/config.yaml
cp ./org1-config.yaml /tmp/hyperledger/org1/orderer1/msp/config.yaml

echo -e $WHITE_L Emisión de certificados para la organización $GREEN Org2$NORMAL!
echo -e $WHITE_L Emisión de certificado CA para $GREEN peer1-org2$NORMAL!
sleep 3

mkdir -p /tmp/hyperledger/org2/peer1/assets/ca 
cp /tmp/hyperledger/org2/ca/admin/msp/cacerts/0-0-0-0-7055.pem /tmp/hyperledger/org2/peer1/assets/ca/org2-ca-cert.pem

mkdir -p /tmp/hyperledger/org2/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/org2/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer1/assets/ca/org2-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-org2:peer1PW@0.0.0.0:7055
sleep 5

echo -e $WHITE_L Emisión de certificado TLS para $GREEN peer1-org2$NORMAL!
sleep 2
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-org2:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-org2 --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/org2/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/org2/peer1/tls-msp/keystore/key.pem

echo -e $WHITE_L Emisión de certificado CA para $GREEN orderer1-org2$NORMAL!
sleep 2
# preparation
mkdir -p /tmp/hyperledger/org2/orderer1/assets/ca 
cp /tmp/hyperledger/org2/ca/admin/msp/cacerts/0-0-0-0-7055.pem /tmp/hyperledger/org2/orderer1/assets/ca/org2-ca-cert.pem

mkdir -p /tmp/hyperledger/org2/orderer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/org2/orderer1/assets/tls-ca/tls-ca-cert.pem

# for identity
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/orderer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/orderer1/assets/ca/org2-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://orderer1-org2:ordererpw@0.0.0.0:7055
sleep 5

echo -e $WHITE_L Emisión de certificado TLS para $GREEN orderer1-org2$NORMAL!
sleep 2

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-org2:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-org2 --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/org2/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/org2/orderer1/tls-msp/keystore/key.pem

echo -e $WHITE_L Emisión de certificado CA para $GREEN admin-org2$NORMAL!
sleep 2

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer1/assets/ca/org2-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-org2:org2AdminPW@0.0.0.0:7055

echo -e $WHITE_L Emisión de certificado TLS para $GREEN admin-org2$NORMAL!
sleep 2

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://admin-org2:org2AdminPW@0.0.0.0:7052 --enrollment.profile tls
sleep 5

cp /tmp/hyperledger/org2/admin/tls-msp/keystore/*_sk /tmp/hyperledger/org2/admin/tls-msp/keystore/key.pem

mkdir -p /tmp/hyperledger/org2/peer1/msp/admincerts
cp /tmp/hyperledger/org2/admin/msp/signcerts/cert.pem /tmp/hyperledger/org2/peer1/msp/admincerts/org2-admin-cert.pem

mkdir -p /tmp/hyperledger/org2/admin/msp/admincerts
cp /tmp/hyperledger/org2/admin/msp/signcerts/cert.pem /tmp/hyperledger/org2/admin/msp/admincerts/org2-admin-cert.pem

mkdir -p /tmp/hyperledger/org2/msp/admincerts
mkdir -p /tmp/hyperledger/org2/msp/cacerts
mkdir -p /tmp/hyperledger/org2/msp/tlscacerts
mkdir -p /tmp/hyperledger/org2/msp/users

cp /tmp/hyperledger/org2/peer1/assets/ca/org2-ca-cert.pem /tmp/hyperledger/org2/msp/cacerts/
cp /tmp/hyperledger/org2/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/org2/msp/tlscacerts/
cp /tmp/hyperledger/org2/admin/msp/signcerts/cert.pem /tmp/hyperledger/org2/msp/admincerts/admin-org2-cert.pem
cp ./org2-config.yaml /tmp/hyperledger/org2/msp/config.yaml
cp ./org2-config.yaml /tmp/hyperledger/org2/orderer1/msp/config.yaml

echo
echo -e $WHITE_L Se ha ha realizado la $GREEN Emisión de certificados CA y TLS para $BLUE todas las organizaciones.$NORMAL!
echo
