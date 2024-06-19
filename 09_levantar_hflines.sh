export PATH=$PATH:${HOME}/fabric-samples/bin
## 00
# Levantando contenedores de las Entidades Certificadoras CA para Org1 y Org2:
docker compose up -d ca-tls rca-org1 rca-org2
sleep 5

docker compose ps --format 'table {{.ID}}\t{{.Name}}\t{{.Status}}\t{{.Ports}}'
USER=$(whoami):$(whoami)
sudo chown -R $USER /tmp/hyperledger/*

. color.sh
echo -e $WHITE_L Registrando en $BLUE TLS-CA $NORMAL...
sleep 4
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/tls-ca/crypto/tls-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/tls-ca/admin

fabric-ca-client enroll -d -u https://tls-ca-admin:tls-ca-adminpw@0.0.0.0:7052
sleep 5
echo -e $WHITE_L Registrando peer1-org1 $BLUE en TLS-CA $NORMAL...
sleep 2
fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
echo -e $WHITE_L Registrando peer1-org2 $BLUE en TLS-CA $NORMAL...
sleep 2
fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7052
echo -e $WHITE_L Registrando orderer1-org1 $BLUE en TLS-CA $NORMAL...
sleep 2
fabric-ca-client register -d --id.name orderer1-org1 --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
echo -e $WHITE_L Registrando orderer1-org2 $BLUE en TLS-CA $NORMAL...
sleep 2
fabric-ca-client register -d --id.name orderer1-org2 --id.secret ordererPW --id.type orderer -u https://0.0.0.0:7052
echo -e $WHITE_L Registrando admin-org1 $BLUE en TLS-CA $NORMAL...
sleep 2
fabric-ca-client register -d --id.name admin-org1 --id.secret org1AdminPW --id.type admin -u https://0.0.0.0:7052
echo -e $WHITE_L Registrando admin-org2 $BLUE en TLS-CA $NORMAL...
sleep 2
fabric-ca-client register -d --id.name admin-org2 --id.secret org2AdminPW --id.type admin -u https://0.0.0.0:7052

echo -e $WHITE_L Registrando en $BLUE RCA-ORG1 $NORMAL.
sleep 4
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/ca/admin

fabric-ca-client enroll -d -u https://rca-org1-admin:rca-org1-adminpw@0.0.0.0:7054
sleep 5

echo -e $WHITE_L Registrando peer1-org1 $BLUE en RCA-ORG1 $NORMAL...
sleep 2
fabric-ca-client register -d --id.name peer1-org1 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7054
echo -e $WHITE_L Registrando orderer1-org1 $BLUE en RCA-ORG1 $NORMAL...
sleep 2
fabric-ca-client register -d --id.name orderer1-org1 --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7054
echo -e $WHITE_L Registrando admin-org1 $BLUE en RCA-ORG1 $NORMAL...
sleep 2
fabric-ca-client register -d --id.name admin-org1 --id.secret org1AdminPW --id.type admin -u https://0.0.0.0:7054

echo -e $WHITE_L Registrando en $BLUE RCA-ORG2 $NORMAL...
sleep 4
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/ca/crypto/ca-cert.pem
export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/ca/admin

fabric-ca-client enroll -d -u https://rca-org2-admin:rca-org2-adminpw@0.0.0.0:7055
sleep 5

echo -e $WHITE_L Registrando peer1-org2 $BLUE en RCA-ORG2 $NORMAL...
sleep 2
fabric-ca-client register -d --id.name peer1-org2 --id.secret peer1PW --id.type peer -u https://0.0.0.0:7055
echo -e $WHITE_L Registrando orderer1-org2 $BLUE en RCA-ORG2 $NORMAL...
sleep 2
fabric-ca-client register -d --id.name orderer1-org2 --id.secret ordererpw --id.type orderer -u https://0.0.0.0:7055
echo -e $WHITE_L Registrando admin-org2 $BLUE en RCA-ORG2 $NORMAL...
sleep 2
fabric-ca-client register -d --id.name admin-org2 --id.secret org2AdminPW --id.type admin -u https://0.0.0.0:7055
echo
echo -e $WHITE_L Todos los registros para las entidades certificadoras CA en $GREEN HFLINES$BLUE realizados$NORMAL...

## 01
. color.sh

echo -e $WHITE_L Emisión de certificados para la organización $GREEN Org1$NORMAL...
sleep 4
echo -e $WHITE_L Emisión de certificado CA para $GREEN peer1-org1$NORMAL...
sleep 2

mkdir -p /tmp/hyperledger/org1/peer1/assets/ca 
cp /tmp/hyperledger/org1/ca/admin/msp/cacerts/0-0-0-0-7054.pem /tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem

mkdir -p /tmp/hyperledger/org1/peer1/assets/tls-ca 
cp /tmp/hyperledger/tls-ca/admin/msp/cacerts/0-0-0-0-7052.pem /tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/peer1
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://peer1-org1:peer1PW@0.0.0.0:7054
sleep 5

echo -e $WHITE_L Emisión de certificado TLS para $GREEN peer1-org1$NORMAL...
sleep 2

export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-org1:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-org1 --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/org1/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/org1/peer1/tls-msp/keystore/key.pem

echo -e $WHITE_L Emisión de certificado CA para $GREEN orderer1-org1$NORMAL...
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

echo -e $WHITE_L Emisión de certificado TLS para $GREEN orderer1-org1$NORMAL...
sleep 2

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-org1:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-org1 --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/org1/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/org1/orderer1/tls-msp/keystore/key.pem

echo -e $WHITE_L Emisión de certificado CA para $GREEN admin-org1$NORMAL...
sleep 2

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org1/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-org1:org1AdminPW@0.0.0.0:7054

echo -e $WHITE_L Emisión de certificado TLS para $GREEN admin-org1$NORMAL...
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

mkdir -p /tmp/hyperledger/org1/msp/admincerts
mkdir -p /tmp/hyperledger/org1/msp/cacerts
mkdir -p /tmp/hyperledger/org1/msp/tlscacerts
mkdir -p /tmp/hyperledger/org1/msp/users
cp /tmp/hyperledger/org1/peer1/assets/ca/org1-ca-cert.pem /tmp/hyperledger/org1/msp/cacerts/
cp /tmp/hyperledger/org1/peer1/assets/tls-ca/tls-ca-cert.pem /tmp/hyperledger/org1/msp/tlscacerts/
cp /tmp/hyperledger/org1/admin/msp/signcerts/cert.pem /tmp/hyperledger/org1/msp/admincerts/admin-org1-cert.pem
cp ./org1-config.yaml /tmp/hyperledger/org1/msp/config.yaml
cp ./org1-config.yaml /tmp/hyperledger/org1/orderer1/msp/config.yaml

echo -e $WHITE_L Emisión de certificados para la organización $GREEN Org2$NORMAL...
echo -e $WHITE_L Emisión de certificado CA para $GREEN peer1-org2$NORMAL...
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

echo -e $WHITE_L Emisión de certificado TLS para $GREEN peer1-org2$NORMAL...
sleep 2
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://peer1-org2:peer1PW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts peer1-org2 --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/org2/peer1/tls-msp/keystore/*_sk /tmp/hyperledger/org2/peer1/tls-msp/keystore/key.pem

echo -e $WHITE_L Emisión de certificado CA para $GREEN orderer1-org2$NORMAL...
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

echo -e $WHITE_L Emisión de certificado TLS para $GREEN orderer1-org2$NORMAL...
sleep 2

# for TLS
export FABRIC_CA_CLIENT_MSPDIR=tls-msp
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/orderer1/assets/tls-ca/tls-ca-cert.pem

fabric-ca-client enroll -d -u https://orderer1-org2:ordererPW@0.0.0.0:7052 --enrollment.profile tls --csr.hosts orderer1-org2 --csr.hosts localhost
sleep 5

cp /tmp/hyperledger/org2/orderer1/tls-msp/keystore/*_sk /tmp/hyperledger/org2/orderer1/tls-msp/keystore/key.pem

echo -e $WHITE_L Emisión de certificado CA para $GREEN admin-org2$NORMAL...
sleep 2

export FABRIC_CA_CLIENT_HOME=/tmp/hyperledger/org2/admin
export FABRIC_CA_CLIENT_TLS_CERTFILES=/tmp/hyperledger/org2/peer1/assets/ca/org2-ca-cert.pem
export FABRIC_CA_CLIENT_MSPDIR=msp

fabric-ca-client enroll -d -u https://admin-org2:org2AdminPW@0.0.0.0:7055

echo -e $WHITE_L Emisión de certificado TLS para $GREEN admin-org2$NORMAL...
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
echo -e $WHITE_L Se ha realizado la $GREEN Emisión de certificados CA y TLS para $BLUE todas las organizaciones.$NORMAL...
echo

## 02
# Levantar peers y clientes
docker compose up -d 
sleep 5
echo -e $WHITE_L Arquitectura de contenedores de$BLUE HFLINES $NORMAL:
docker compose ps --format 'table {{.ID}}\t{{.Name}}\t{{.Status}}\t{{.Ports}}'
sleep 4

## 03
echo -e $WHITE_L Creando bloque génesis para el canal$NORMAL ...

configtxgen -profile SampleAppChannelEtcdRaft \
            -configPath ${PWD} \
            -outputBlock mychannel.block \
            -channelID mychannel

echo -e $WHITE_L Consultando el status del canal$NORMAL ...

osnadmin channel list -o localhost:7080 \
                      --ca-file /tmp/hyperledger/org1/orderer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem \
                      --client-cert /tmp/hyperledger/org1/admin/tls-msp/signcerts/cert.pem \
                      --client-key /tmp/hyperledger/org1/admin/tls-msp/keystore/key.pem

## 04
## Añadir orderer y peers de org1 al canal
export PATH=$PATH:${HOME}/fabric-samples/bin
export FABRIC_CFG_PATH=${HOME}/fabric-samples/config/
export ORDERER_CA=/tmp/hyperledger/org1/orderer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="org1MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/tmp/hyperledger/org1/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org1/admin/msp
export CORE_PEER_ADDRESS=localhost:7051
export CORE_PEER_ADDRESS_ORG1=localhost:7051

echo -e $WHITE_L Estado actual del canal respecto Org1$NORMAL ...
sleep 2
osnadmin channel list -o localhost:7080 \
                      --ca-file $ORDERER_CA \
                      --client-cert /tmp/hyperledger/org1/admin/tls-msp/signcerts/cert.pem \
                      --client-key /tmp/hyperledger/org1/admin/tls-msp/keystore/key.pem

echo -e $WHITE_L Uniendo al canal a orderer1-org1$NORMAL ...
sleep 2
osnadmin channel join --channelID mychannel \
                      --config-block mychannel.block \
                      -o localhost:7080 \
                      --ca-file $ORDERER_CA \
                      --client-cert /tmp/hyperledger/org1/admin/tls-msp/signcerts/cert.pem \
                      --client-key /tmp/hyperledger/org1/admin/tls-msp/keystore/key.pem

echo -e $WHITE_L Estado final del canal una vez añadido orderer1-org1$NORMAL ...
sleep 2
osnadmin channel list -o localhost:7080 \
                      --ca-file $ORDERER_CA \
                      --client-cert /tmp/hyperledger/org1/admin/tls-msp/signcerts/cert.pem \
                      --client-key /tmp/hyperledger/org1/admin/tls-msp/keystore/key.pem

echo -e $WHITE_L Uniendo al canal a peer1-org1$NORMAL ...
peer channel join -b mychannel.block

## 05
## Unir orderer y peers de org2.

export PATH=$PATH:${HOME}/fabric-samples/bin
export FABRIC_CFG_PATH=${HOME}/fabric-samples/config/
export ORDERER_CA=/tmp/hyperledger/org2/orderer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/tmp/hyperledger/org2/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/admin/msp
export CORE_PEER_ADDRESS=localhost:9051
export CORE_PEER_ADDRESS_ORG2=localhost:9051


echo -e $WHITE_L Estado actual del canal respecto Org1$NORMAL ...
sleep 2
osnadmin channel list -o localhost:8080 \
                      --ca-file $ORDERER_CA \
                      --client-cert /tmp/hyperledger/org2/admin/tls-msp/signcerts/cert.pem \
                      --client-key /tmp/hyperledger/org2/admin/tls-msp/keystore/key.pem

echo -e $WHITE_L Uniendo al canal a orderer1-org2$NORMAL ...
sleep 2
osnadmin channel join --channelID mychannel \
                      --config-block mychannel.block \
                      -o localhost:8080 \
                      --ca-file $ORDERER_CA \
                      --client-cert /tmp/hyperledger/org2/admin/tls-msp/signcerts/cert.pem \
                      --client-key /tmp/hyperledger/org2/admin/tls-msp/keystore/key.pem

echo -e $WHITE_L Estado final del canal una vez añadido orderer1-org2$NORMAL ...
sleep 2
osnadmin channel list -o localhost:8080 \
                      --ca-file $ORDERER_CA \
                      --client-cert /tmp/hyperledger/org2/admin/tls-msp/signcerts/cert.pem \
                      --client-key /tmp/hyperledger/org2/admin/tls-msp/keystore/key.pem

echo -e $WHITE_L Uniendo al canal a peer1-org2$NORMAL ...
peer channel join -b mychannel.block

echo
echo ------------------------------------------------
echo -e $WHITE_L Red Hyperledger fabric $BLUE HFLINES $WHITE_L levantada.
echo ------------------------------------------------
echo
