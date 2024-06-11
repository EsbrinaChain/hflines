
# Ejemplos de ejecución de las app que facilitan el uso 
# de las funciones incluidas en el chaincode.

. color.sh
source ./term-org1

echo -e $WHITE_L Ejemplo 1 sobre HFLINES $NORMAL
echo -e $WHITE_L Enviando Mensaje 1 : Emisor: Juan Solana, destinataria: Maria Castillo $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "1" "Juan Solana" "Reunion urgente" "Maria Castillo" "Reunion Lunes 22/09/2024 a las 11h, oficinas TELCO" "antonio maria rebeca"

sleep 3

echo -e $WHITE_L Ejemplo 2 sobre HFLINES $NORMAL
echo -e $WHITE_L Enviando Mensaje 2 : Emisor: Maria Castillo, destinatario: Juan Solana $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "2" "Maria Castillo" "Reunion aceptada" "Juan Solana" "Reunion Lunes - OK. Nos desplazamos 4 personas" "antonio maria rebeca"

sleep 3

echo -e $WHITE_L Ejemplo 3 - Ver todos los mensajes en HFLINES $NORMAL
echo -e $WHITE_L Listar todos los mensajes existentes $BLUE RED HFLINES $NORMAL

./20_app04_listarMensaje.sh $1 

sleep 3

echo -e $WHITE_L Ejemplo 4 - Eliminar mensaje (World state, no del legder-blockchain) sobre HFLINES $NORMAL
echo -e $WHITE_L Eliminando Mensaje 1 : Emisor: Juan Solana, destinataria: Maria Castillo $BLUE RED HFLINES $NORMAL

./20_app02_eliminar_mensaje.sh $1 "1" "Juan Solana" "Reunion urgente" "Maria Castillo" "Reunion Lunes 22/09/2024 a las 11h, oficinas TELCO" "antonio maria rebeca"

sleep 3

echo -e $WHITE_L Ejemplo 5 - Ver mensaje por [id] en HFLINES $NORMAL
echo -e $WHITE_L Visualizando Mensaje 2 (existente) : Emisor: Maria Castillo, destinatario: Juan Solana $BLUE RED HFLINES $NORMAL

./20_app01_verMensaje.sh $1 "2"

sleep 3

echo -e $WHITE_L Ejemplo 6 - Intento de _Ver mensaje_ eliminado previamente $NORMAL
echo -e $WHITE_L Visualizando Mensaje 1 : Emisor: Juan Solana, destinataria: Maria Castillo $BLUE RED HFLINES $NORMAL

./20_app03_verMensaje.sh $1 "1"

sleep 3

echo -e $WHITE_L Ejemplo 7 - Mostra mensajes de un emisor $NORMAL
echo -e $WHITE_L Visualizando Mensaje de Emisor: Maria Castillo $BLUE RED HFLINES $NORMAL

./20_app05_enviadoPor.sh $1 "Maria Castillo"

sleep 3


