

export param = -o localhost:7050 --ordererTLSHostnameOverride orderer1-org1 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C mychannel -n chaincode --peerAddresses localhost:7051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 --peerAddresses localhost:9051 --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2

# Insertar registros

peer chaincode invoke -o localhost:7050 \
                      --ordererTLSHostnameOverride orderer1-org1 \ 
                      --tls $CORE_PEER_TLS_ENABLED \ 
                      --cafile $ORDERER_CA \
                      -C mychannel \
                      -n chaincode \
                      --peerAddresses localhost:7051 \
                      --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 \
                      --peerAddresses localhost:9051 \
                      --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 \
                      -c '{"Args":["registrarJamon", "1", "Iberico","Bellota","Dehesa de Extremadura","Dehesa de Extremadura", "50"]}'

peer chaincode invoke     -c '{"Args":["registrarJamon", "2", "Iberico","Cebo","Jabugo","Jabugo", "30"]}'

peer chaincode invoke    -o localhost:7050    --ordererTLSHostnameOverride orderer1-org1    --tls $CORE_PEER_TLS_ENABLED    --cafile $ORDERER_CA    -C mychannel    -n chaincode    --peerAddresses localhost:7051    --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1    --peerAddresses localhost:9051    --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 -c '{"Args":["registrarJamon", "3", "Iberico","Cebo","QJabugo","QJabugo", "130"]}'

# Visualizar registros ---------------------------------------------------------------------------------------------------------------------------------------

peer chaincode invoke    -o localhost:7050    --ordererTLSHostnameOverride orderer1-org1    --tls $CORE_PEER_TLS_ENABLED    --cafile $ORDERER_CA    -C mychannel    -n chaincode    --peerAddresses localhost:7051    --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1    --peerAddresses localhost:9051    --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 -c '{"Args":["imprimirJamon", "1"]}'
