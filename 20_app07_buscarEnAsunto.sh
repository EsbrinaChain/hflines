# Muestra para la ejecución de funciones del chaincode.
# App07:  ./20_app05_buscarEnAsunto.sh $1 $2

# buscarEnAsunto 
#               $1=num. chaincode ej: 1 para usar chaincode1 si "" -> chaincode
#               $2="texto a localizar en el campo Asunto de un mensaje enviado." Ej: "reunion"

. color.sh
source ./term-org1

echo -e $WHITE_L Búsqueda de Mensajes enviados en HFLINES con el texto $GREEN $2 $WHITE_L en el campo $BLUE ASUNTO $NORMAL

printf -v param1 '{"Args":["buscarEnAsunto","%s"]}' "$2"
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



