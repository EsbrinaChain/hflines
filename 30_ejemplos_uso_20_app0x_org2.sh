
# Ejemplos de ejecución de las app que facilitan el uso 
# de las funciones incluidas en el chaincode.

clear
. color.sh
source ./term-org2

echo -e $WHITE_L Ejemplo 10 sobre HFLINES $NORMAL
echo ""
echo -e $WHITE_L Enviando Mensaje 5 : Emisor: Julio Solana, destinataria: Maria Garcia $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "5" "Julio Solana" "Entrega urgente" "Maria Garcia" "Entrega Martes 23/09/2024 a las 11h, oficinas TELCO" "Antonio Maria Rebeca"

sleep 3

echo -e $WHITE_L Ejemplo 11 Envio de tres mensajes por HFLINES $NORMAL
echo ""
echo -e $WHITE_L Enviando Mensaje 6 : Emisor: Maria Garcia, destinatario: Julio Solana $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "6" "Maria Garcia" "Entrega aceptada" "Julio Solana" "Entrega Martes - OK. 12 copias." "antonio maria rebeca"

echo ""
echo -e $WHITE_L Enviando Mensaje 7 : Emisor: Maria Garcia, destinatario: Soledad Tuset $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "7" "Maria Garcia" "Entrega Lunes TELCO" "Soledad Tuset" "Tenemos que realizar la Entrega del proyecto el martes 23/09/2024, oficinas TELCO a las 11h." "Antonio Maria Rebeca"

echo ""
echo -e $WHITE_L Enviando Mensaje 8 : Emisor: Maria Garcia, destinatario: Soledad Tuset $BLUE RED HFLINES $NORMAL

./20_app01_enviarMensaje.sh $1 "8" "Maria Garcia" "Cambios de ultima hora..." "Soledad Tuset" "Finalmente, no podre participar de la Entrega del martes. Por favor, encargate tu de todo." "Antonio Maria Rebeca"

sleep 3

echo -e $WHITE_L Ejemplo 12 - Ver todos los mensajes en HFLINES $NORMAL
echo ""

./20_app04_listarMensajes.sh $1 

sleep 3

echo -e $WHITE_L Ejemplo 13 - Eliminar mensaje - World state, no del legder-blockchain - sobre HFLINES $NORMAL
echo ""
echo -e $WHITE_L Eliminando Mensaje 5 : Emisor: Julio Solana, destinataria: Maria Garcia $BLUE RED HFLINES $NORMAL

./20_app02_eliminarMensaje.sh $1 "5" "Julio Solana" "Entrega urgente" "Maria Garcia" "Entrega Lunes 22/09/2024 a las 11h, oficinas TELCO" "Antonio Maria Rebeca"

sleep 3

echo -e $WHITE_L Ejemplo 14 - Ver mensaje por _id_ en HFLINES $NORMAL
echo ""
echo -e $WHITE_L Visualizando Mensaje 6 _existente_ : Emisor: Maria Garcia, destinatario: Julio Solana $BLUE RED HFLINES $NORMAL

./20_app03_verMensaje.sh $1 "6"

sleep 3

echo -e $WHITE_L Ejemplo 15 - Intento de _Ver mensaje_ eliminado previamente $NORMAL
echo ""
echo -e $WHITE_L Visualizando Mensaje 5 : Emisor: Julio Solana, destinataria: Maria Garcia $BLUE RED HFLINES $NORMAL

./20_app03_verMensaje.sh $1 "5"

sleep 3

echo -e $WHITE_L Ejemplo 16 - Dado un emisor, mostrar todos sus mensajes  $NORMAL
echo ""

./20_app05_enviadosPor.sh $1 "Maria Garcia"

sleep 3

echo -e $WHITE_L Ejemplo 17 - Dado un receptor, mostrar todos los mensajes que se le han enviado $NORMAL
echo ""

./20_app06_enviadosA.sh $1 "Soledad Tuset"

sleep 3

echo -e $WHITE_L Ejemplo 18 - Mostrar todos los mensajes con el texto indicado en el _Asunto_ del mensaje $NORMAL
echo ""

./20_app07_buscarEnAsunto.sh $1 "Entrega"

sleep 3