export PATH=$PATH:${HOME}/fabric-samples/bin
export FABRIC_CFG_PATH=${HOME}/fabric-samples/config/
export ORDERER_CA=/tmp/hyperledger/org2/orderer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/tmp/hyperledger/org2/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/admin/msp
export CORE_PEER_ADDRESS=localhost:9051


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