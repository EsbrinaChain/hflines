# Muestra del parametro $1 
# $1=./chcodes/hflines_ch1/build/install/hflines_ch1/

ruta_install=./chcodes/hflines_ch1/build/install/hflines_ch1

source ./term-org1

peer lifecycle chaincode package hflines_chaincode.tar.gz \
               --path $ruta_install \
               --lang java \
               --label chaincode

peer lifecycle chaincode install hflines_chaincode.tar.gz \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled \
               --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
               --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

