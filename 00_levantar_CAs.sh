export PATH=$PATH:${HOME}/fabric-samples/bin

# Levantando contenedores de las Entidades Certificadoras CA para Org1 y Org2:
docker compose up -d ca-tls rca-org1 rca-org2
sleep 5

docker compose ps --format 'table {{.ID}}\t{{.Name}}\t{{.Status}}\t{{.Ports}}'
USER=$(whoami):$(whoami)
sudo chown -R $USER /tmp/hyperledger/*

. color.sh
echo -e $WHITE_L Registrando en $BLUE TLS-CA $NORMAL...
sleep 2
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
echo -e $WHITE_L Registrando admin-org1 $BLUE en TLS-CA $NORMAL...
sleep 2
fabric-ca-client register -d --id.name admin-org2 --id.secret org2AdminPW --id.type admin -u https://0.0.0.0:7052

echo -e $WHITE_L Registrando en $BLUE RCA-ORG1 $NORMAL.

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
sleep 2
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
echo -e $WHITE_L Todos los registros para las entidades certificadoras CA en $GREEN HFLINES$BLUE realizados$NORMAL!