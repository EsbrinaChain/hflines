# La última ejecución de peer en '10_chaincode_alta_org1.sh', genera el parametro $1 
# (ejemplo que varia por ser id de chaincode generado)
# ejemplo exacto en formato: 
#          chaincode:711f71f0a7d3fa0262aa2c3572e92bec4b49942aa7b190a38eb56cc83f493963 
# Si no se pasa este parámetro se genera un error.

source ./term-org2

peer lifecycle chaincode install chaincode.tar.gz \
                         --peerAddresses localhost:9051 \
                         --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode queryinstalled --peerAddresses localhost:9051 \
                                        --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE

peer lifecycle chaincode approveformyorg \
    -o localhost:7050 \
    --ordererTLSHostnameOverride orderer1-org1 \
    --tls --cafile $ORDERER_CA \
    --channelID mychannel \
    --name chaincode \
    --version 1.0 \
    --package-id $1 \
    --sequence 1