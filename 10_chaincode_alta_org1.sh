# Muestra del parametro $1 
# $1=../chaincode/build/install/chaincode/

source ./term-org1

peer lifecycle chaincode package chaincode.tar.gz \
               --path $1 \
               --lang java \
               --label chaincode

peer lifecycle chaincode install chaincode.tar.gz \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode approveformyorg \
    -o $ORDERER_ORG1_ADDRESS \
    --ordererTLSHostnameOverride orderer1-org1 \
    --tls --cafile $ORDERER_CA \
    --channelID mychannel \
    --name chaincode \
    --version 1.0 \
    --package-id $1 \
    --sequence 1