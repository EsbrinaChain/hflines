# Muestra del parametro $1 
# $1=./chcodes/hf1/build/install/hf1

ruta_install=./chcodes/hf1/build/install/hf1

source ./term-org1

peer lifecycle chaincode package hf1_chaincode.tar.gz \
               --path $ruta_install \
               --lang java \
               --label chaincode

peer lifecycle chaincode install hf1_chaincode.tar.gz \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

