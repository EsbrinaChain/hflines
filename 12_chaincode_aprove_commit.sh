# chaincode:711f71f0a7d3fa0262aa2c3572e92bec4b49942aa7b190a38eb56cc83f493963

source ./term-org1

peer lifecycle chaincode approveformyorg \
                         -o localhost:7050 \ 
                         --ordererTLSHostnameOverride orderer1-org1 \
                         --tls \
                         --cafile $ORDERER_CA \
                         --channelID mychannel \
                         --name chaincode \
                         --version 1.0 \
                         --package-id $1 \ 
                         --sequence 1
                         
peer lifecycle chaincode checkcommitreadiness \
        --channelID mychannel \
        --name chaincode \
        --version 1.0 \
        --sequence 1 \
        --output json 

peer lifecycle chaincode commit -o localhost:7050 \
                                --ordererTLSHostnameOverride orderer1-org1 \
                                --tls $CORE_PEER_TLS_ENABLED \
                                --cafile $ORDERER_CA \
                                --channelID mychannel \
                                --name chaincode \
                                --peerAddresses localhost:7051 \
                                --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG1 \
                                --peerAddresses localhost:9051 \
                                --tlsRootCertFiles $CORE_PEER_TLS_ROOTCERT_FILE_ORG2 \
                                --version 1.0 \
                                --sequence 1
                                
peer lifecycle chaincode querycommitted --channelID mychannel --name chaincode