# La última ejecución de peer en '10_chaincode_alta_org1.sh', genera el parametro $1 
# (ejemplo que varia por ser id de chaincode generado)
# ejemplo exacto en formato: 
#          chaincode:8029661264f62c396e5c8086ff41d46ae9704cdeace463e1a1aebbf3df4c39e6 
# Si no se pasa este parámetro se genera un error.

source ./term-org2 

peer lifecycle chaincode install chaincode.tar.gz \
                         --peerAddresses $CORE_PEER_ADDRESS \
                         --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled --peerAddresses $CORE_PEER_ADDRESS \
                                        --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode approveformyorg \
    -o $ORDERER_ORG2_ADDRESS \
    --ordererTLSHostnameOverride orderer1-org2 \
    --tls --cafile $ORDERER_CA \
    --channelID mychannel \
    --name chaincode \
    --version 1.0 \
    --package-id $1 \
    --sequence 1