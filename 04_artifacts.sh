
# generamos direcamente bloque génesis para el canal de applicación (application channel (mychannel) with our new profile SampleAppChannelEtcdRaft 
# configtx.yaml contiene ésta configuración en el apartado 'Profiles'
# SampleAppChannelEtcdRaft:
#        <<: *ChannelDefaults
#        Orderer:
#            <<: *OrdererDefaults
#            Organizations:
#                - *OrdererOrg
#            Capabilities:
#                <<: *OrdererCapabilities
#        Application:
#            <<: *ApplicationDefaults
#            Organizations:
#                - *Org1
#                - *Org2
#            Capabilities:
#                <<: *ApplicationCapabilities

echo -e $WHITE_L Creando bloque génesis para el canal$NORMAL ...

configtxgen -profile SampleAppChannelEtcdRaft \
            -configPath ${PWD} \
            -outputBlock mychannel.block \
            -channelID mychannel

echo -e $WHITE_L Consultando el status del canal$NORMAL ...

osnadmin channel list -o localhost:7080 \
                      --ca-file $ORDERER_CA \
                      --client-cert /tmp/hyperledger/org1/admin/tls-msp/signcerts/cert.pem \
                      --client-key /tmp/hyperledger/org1/admin/tls-msp/keystore/key.pem



