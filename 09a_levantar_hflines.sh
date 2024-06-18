export PATH=$PATH:${HOME}/fabric-samples/bin

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
