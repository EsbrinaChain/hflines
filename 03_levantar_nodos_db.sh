# Levantar peers y clientes
docker compose up -d 
sleep 5
echo -e $WHITE_L Arquitectura de contenedores de$BLUE HFLINES $NORMAL:
docker compose ps --format 'table {{.ID}}\t{{.Name}}\t{{.Status}}\t{{.Ports}}'