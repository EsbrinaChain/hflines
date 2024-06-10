# Muestra del parametro $1 
# $1=./chcodes/hf1/build/install/hf1

# Ruta chaincode code compiled
ruta_install=./chcodes/chaincode/build/install/chaincode

source ./term-org1

peer lifecycle chaincode package chaincode.tar.gz \
               --path $ruta_install \
               --lang java \
               --label chaincode$1

peer lifecycle chaincode install chaincode.tar.gz \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

