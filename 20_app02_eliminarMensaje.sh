# Muestra para la ejecución de funciones del chaincode.
# App02:  ./20_app02_eliminarMensaje.sh $1 $2

# eliminarMensaje 

#               $1=num. chaincode ej: 1 para usar chaincode1 si "" -> chaincode
#     idMensaje $2="1"       

. color.sh
source ./term-org1

echo -e $WHITE_L Eliminando Mensaje en $BLUE HFLINES $NORMAL
echo ""

printf -v param1 '{"Args":["eliminarMensaje","%s"]}' "$2"
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




