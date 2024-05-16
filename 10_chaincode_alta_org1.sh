# Muestra del parametro $1 
# $1=../chaincode/build/install/chaincode/
# $2=

source ./term-org1

peer lifecycle chaincode package chaincode.tar.gz \
               --path $1 \
               --lang java \
               --label chaincode

peer lifecycle chaincode install chaincode.tar.gz \
               --peerAddresses localhost:7051 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled \
               --peerAddresses localhost:7051 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE