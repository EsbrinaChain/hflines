# Muestra para la ejecución de funciones del chaincode.

peer chaincode invoke \
   -o localhost:7050 \
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