
docker compose up -d ca-tls rca-org0 rca-org1 rca-org2
docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'
sleep 5
sudo chown $(whoami):$(whoami) -R /tmp/hyperledger