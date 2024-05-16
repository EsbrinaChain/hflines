# Muestra del parametro $1 
# chaincode:711f71f0a7d3fa0262aa2c3572e92bec4b49942aa7b190a38eb56cc83f493963

source ./term-org1

peer lifecycle chaincode package chaincode.tar.gz \
               --path ../chaincode/build/install/chaincode/ \
               --lang java \
               --label chaincode

peer lifecycle chaincode install chaincode.tar.gz \
               --peerAddresses localhost:7051 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled \
               --peerAddresses localhost:7051 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE