export PATH=$PATH:${HOME}/fabric-samples/bin
export FABRIC_CFG_PATH=${HOME}/fabric-samples/config/
export ORDERER_CA=/tmp/hyperledger/org2/orderer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="org2MSP"
export CORE_PEER_TLS_ROOTCERT_FILE=/tmp/hyperledger/org2/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem
export CORE_PEER_MSPCONFIGPATH=/tmp/hyperledger/org2/admin/msp
export CORE_PEER_ADDRESS=localhost:9051

echo -e $WHITE_L Uniendo al canal a peer2-org1$NORMAL ...
peer channel join -b mychannel.block