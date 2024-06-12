# Muestra para la ejecución de funciones del chaincode.
# App08:  ./20_app08_eliminarTodosMensajes.sh $1 

# eliminarTodosMensajes
#               $1=num. chaincode ej: 1 para usar chaincode1 si "" -> chaincode

. color.sh
source ./term-org1

echo -e $WHITE_L Eliminar todos los Mensajes en $BLUE HFLINES $NORMAL

printf -v param1 '{"Args":["eliminarTodosMensajes"]}'
#echo $param1

op="peer chaincode invoke \
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
   -c '${param1}"
   
op="${op}'"
#printf -v op $op

#echo op

echo $op | bash
echo ""




