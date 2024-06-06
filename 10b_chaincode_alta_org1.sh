source ./term-org1

peer lifecycle chaincode approveformyorg \
    -o $ORDERER_ORG1_ADDRESS \
    --ordererTLSHostnameOverride orderer1-org1 \
    --tls --cafile $ORDERER_CA \
    --channelID mychannel \
    --name chaincode \
    --version 1.0 \
    --package-id $1 \
    --sequence 1
    
    # $1 : hflines:c2066d1ea51ebe1c70db570860f9e56a064d13283729e43aae2eec04b33212a0