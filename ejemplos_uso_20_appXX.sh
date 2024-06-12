
# Ejemplos de ejecución de las app que facilitan el uso 
# de las funciones incluidas en el chaincode.

clear
. color.sh
source ./term-org1

echo -e $WHITE_L Ejemplo 1 sobre HFLINES $NORMAL
echo ""
echo -e $WHITE_L Enviando Mensaje 1 : Emisor: Juan Solana, destinataria: Maria Castillo $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "1" "Juan Solana" "Reunion urgente" "Maria Castillo" "Reunion Lunes 22/09/2024 a las 11h, oficinas TELCO" "Antonio Maria Rebeca"

sleep 3

echo -e $WHITE_L Ejemplo 2 Envio de tres mensajes por HFLINES $NORMAL
echo ""
echo -e $WHITE_L Enviando Mensaje 2 : Emisor: Maria Castillo, destinatario: Juan Solana $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "2" "Maria Castillo" "Reunion aceptada" "Juan Solana" "Reunion Lunes - OK. Nos desplazamos 4 personas" "antonio maria rebeca"

echo ""
echo -e $WHITE_L Enviando Mensaje 3 : Emisor: Maria Castillo, destinatario: Anna Gracia $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "3" "Maria Castillo" "Reunion Lunes TELCO" "Anna Gracia" "Deberias asistir a la reunion del lunes, oficinas TELCO a las 11h." "Antonio Maria Rebeca"

echo ""
echo -e $WHITE_L Enviando Mensaje 4 : Emisor: Maria Castillo, destinatario: Anna Gracia $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "4" "Maria Castillo" "Reunion de ultima hora..." "Anna Gracia" "Finalmente, no podre asistir a la reunion del lunes. Por favor, encargate tu de substituirme." "Antonio Maria Rebeca"

sleep 3

echo -e $WHITE_L Ejemplo 3 - Ver todos los mensajes en HFLINES $NORMAL
echo ""

./20_app04_listarMensajes.sh $1 

sleep 3

echo -e $WHITE_L Ejemplo 4 - Eliminar mensaje - World state, no del legder-blockchain - sobre HFLINES $NORMAL
echo ""
echo -e $WHITE_L Eliminando Mensaje 1 : Emisor: Juan Solana, destinataria: Maria Castillo $BLUE RED HFLINES $NORMAL

./20_app02_eliminarMensaje.sh $1 "1" "Juan Solana" "Reunion urgente" "Maria Castillo" "Reunion Lunes 22/09/2024 a las 11h, oficinas TELCO" "Antonio Maria Rebeca"

sleep 3

echo -e $WHITE_L Ejemplo 5 - Ver mensaje por _id_ en HFLINES $NORMAL
echo ""
echo -e $WHITE_L Visualizando Mensaje 2 _existente_ : Emisor: Maria Castillo, destinatario: Juan Solana $BLUE RED HFLINES $NORMAL

./20_app03_verMensaje.sh $1 "2"

sleep 3

echo -e $WHITE_L Ejemplo 6 - Intento de _Ver mensaje_ eliminado previamente $NORMAL
echo ""
echo -e $WHITE_L Visualizando Mensaje 1 : Emisor: Juan Solana, destinataria: Maria Castillo $BLUE RED HFLINES $NORMAL

./20_app03_verMensaje.sh $1 "1"

sleep 3

echo -e $WHITE_L Ejemplo 7 - Dado un emisor, mostrar todos sus mensajes  $NORMAL
echo ""

./20_app05_enviadosPor.sh $1 "Maria Castillo"

sleep 3

echo -e $WHITE_L Ejemplo 8 - Dado un receptor, mostrar todos los mensajes que se le han enviado $NORMAL
echo ""

./20_app06_enviadosA.sh $1 "Anna Gracia"

sleep 3

echo -e $WHITE_L Ejemplo 9 - Mostrar todos los mensajes con el texto indicado en el _Asunto_ del mensaje $NORMAL
echo ""

./20_app07_buscarEnAsunto.sh $1 "reunion"

sleep 3