# Acabar de levantar la red

docker compose up -d 

docker ps --format 'table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}'

sleep 5