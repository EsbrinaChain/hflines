# Muestra para la ejecución de funciones del chaincode.
# App01:  ./20_app_enviar_mensaje.sh $1 $2 $3 $4 $5 $6 $7

# enviarMensaje 
#               
#               idMensaje $2="2"
#                  Emisor $3="Emisor"
#                  Asunto $4="Asunto" 
#            Destinatario $5="destinatario", 
#               Contenido $6="Contenido" 
#                 enCopia $7="enCopias"

. color.sh
source ./term-org1

echo -e $WHITE_L Enviando de Mensaje por $BLUE HFLINES $NORMAL
echo ""

printf -v param1 '{"Args":["enviarMensaje","%s","%s","%s","%s","%s","%s"]}' "$2" "$3" "$4" "$5" "$6" "$7"
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
   
#echo $op
   
echo $op | bash
echo ""



