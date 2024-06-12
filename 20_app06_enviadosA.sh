# Muestra para la ejecución de funciones del chaincode.
# App06:  ./20_app06_enviadosA.sh $1 $2

# enviadosA 
#               $1=num. chaincode ej: 1 para usar chaincode1 si "" -> chaincode
#               $2="Receptor"

. color.sh
source ./term-org1

echo -e $WHITE_L Búsqueda de Mensajes enviados a $GREEN $2 $WHITE_L en $BLUE HFLINES $NORMAL

printf -v param1 '{"Args":["enviadosA","%s"]}' "$2"
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




