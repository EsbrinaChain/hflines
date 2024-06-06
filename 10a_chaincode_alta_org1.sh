# Muestra del parametro $1 
# $1=./chcodes/hf1/build/install/hf1

ruta_install=./chcodes/hf2/build/install/hf2

source ./term-org1

peer lifecycle chaincode package hf2_chaincode.tar.gz \
               --path $ruta_install \
               --lang java \
               --label hf2_chaincode

peer lifecycle chaincode install hf2_chaincode.tar.gz \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

