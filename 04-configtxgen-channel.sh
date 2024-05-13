configtxgen -profile OrgsOrdererGenesis -outputBlock /tmp/hyperledger/org0/orderer/genesis.block -channelID syschannel
sleep 5

configtxgen -profile OrgsChannel -outputCreateChannelTx /tmp/hyperledger/org0/orderer/channel.tx -channelID mychannel
sleep 5

configtxgen -profile OrgsChannel -outputAnchorPeersUpdate /tmp/hyperledger/org0/orderer/org1MSPanchors.tx -channelID mychannel -asOrg org1MSP
sleep 5

peer channel create -c mychannel -f /tmp/hyperledger/org0/orderer/channel.tx -o localhost:7050 --ordererTLSHostnameOverride orderer1-org0 --outputBlock /tmp/hyperledger/org1/peer1/assets/mychannel.block --tls --cafile /tmp/hyperledger/org1/peer1/tls-msp/tlscacerts/tls-0-0-0-0-7052.pem
