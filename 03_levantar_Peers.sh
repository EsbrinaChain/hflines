# Acabar de levantar la red

docker compose up -d peer1-org1 peer2-org1 peer1-org2 peer2-org2

docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'

sleep 5