source ./term-org1

peer lifecycle chaincode approveformyorg \
    -o $ORDERER_ORG1_ADDRESS \
    --ordererTLSHostnameOverride orderer1-org1 \
    --tls --cafile $ORDERER_CA \
    --channelID mychannel \
    --name chaincode$1 \
    --version 1.0 \
    --package-id $2 \
    --sequence 1
