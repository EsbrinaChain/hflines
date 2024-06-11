# Muestra para la ejecución de funciones del chaincode.

. color.sh
source ./term-org1

echo -e $WHITE_L Mensajes enviados por... en $BLUE HFLINES $NORMAL

peer chaincode invoke \
   -o $ORDERER_ORG1_ADDRESS \
   --ordererTLSHostnameOverride orderer1-org1 \
   --tls $CORE_PEER_TLS_ENABLED \
   --cafile $ORDERER_CA \
   -C mychannel \
   -n chaincode$1 \
   --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
   --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 \
   --peerAddresses $CORE_PEER_ADDRESS_ORG2 \
   --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 \
   -c '{"Args":["eliminarMensaje", "102"]}'
   

sleep 3

echo -e $WHITE_L Listtado de Mensajes en $BLUE HFLINES $NORMAL   
peer chaincode invoke \
   -o $ORDERER_ORG1_ADDRESS \
   --ordererTLSHostnameOverride orderer1-org1 \
   --tls $CORE_PEER_TLS_ENABLED \
   --cafile $ORDERER_CA \
   -C mychannel \
   -n chaincode$1 \
   --peerAddresses $CORE_PEER_ADDRESS_ORG1 \
   --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 \
   --peerAddresses $CORE_PEER_ADDRESS_ORG2 \
   --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 \
   -c '{"Args":["listarMensajes"]}'

   
   ##-c '{"Args":["listarMensajes"]}'

   ##-c '{"Args":["enviarMensaje", "2", "Emisor","Asunto", "dest", "Contenido","enCopias"]}'
   ##-c '{"Args":["enviarMensaje", "1", "Emisor mensaje 1","Asunto mensaje 1", "destinatario@mensaje1.com", "Contenido texto mensaje 1","enCopia1@mensaje1.com, enCopia2@mensaje1.com"]}'
   
   ##-c '{"Args":["recibidosDe","dest"]}'
   
   ##-c '{"Args":["enviarMensaje", "2", "Iberico","Bellota","Dehesa de Extremadura","Dehesa de Extremadura", "50"]}'
   
   ##-c '{"Args":["enviarMensaje", "3", "Emisor mensaje 1","Asunto mensaje 1", "recep1", "enCopias","Contenido texto mensaje 1"]}'
   
   
   ##-c '{"Args":["qf", "JOAN"]}'
   
   ## -c '{"Args":["enviarMensaje", "1", "Emisor mensaje 1","Asunto mensaje 1", "destinatario@mensaje1.com", "enCopia1@mensaje1.com, enCopia2@mensaje1.com","Contenido texto mensaje 1"]}'
   
   # -c '{"Args":["enviadosPor", "E1"]}'