
# HFLines - Proyecto Hyperledger Fabric - EBIS - QDJ

HFLines es un proyecto que utiliza la tecnologia blockchain de Hyperledger Fabric para implementar 
${\LARGE\textrm{\color{royalblue}un sistema de auditoria de comunicaciones entre una UTE¹ de empresas}}$.

<p align='justify'>Su utilidad és múltiple y diversa para todos los proyectos que decidan implementar conjuntamente.</p><p align='justify'>Este sistema registra todas las comunicaciones y las almacena de manera transparente e inmutable en una blockchain, permitiendo aplicar la privacidad necesaria en cada comunicación.</p>
<ul>
<li>Inicialmente se implementarán 2 canales, uno global para la comunicación entre las organizaciones y uno con privacidad reservado sólo para el nivel directivo.</li>
<li>Mediante la aplicación se dispone al finalizar cada proyecto, de la secuencia de decisiones tomadas por el equipo directivo y de todas las operaciones realizadas conjuntamente así como su cronologia, a modo de auditoria global.</li>
</ul>
<p align='justify'>El uso de la tecnología blockchain permite garantizar a todas las organizaciones el acceso a los datos segun su nivel de acceso y confiar en el mismo por su capacidad de inmutabilidad del registro, siendo una herramienta de confianza para la resolución de conflictos, en la responsabilidad de cada toma de decisiones.</p>

##### <p align='right'><sup>1</sup> (UTE = Unión Temporal de Empresas).</p>

![Red HFLines](/img/img.png "HFLines")
<p align='center'>
  <b>CA</b> : Autoridad Certificadora.<br>
  <b>TLS-CA</b> : Entidad certificadora para el protocolo de transporte TLS. 
</p>
<p>
-----------------------------------------------------------------------------------
</p>

## Cómo utilizar este proyecto en una máquina virtual:

<p align='justify'>
<blockquote>
Versión 1.8:

1- Crea la red Hyperledger fabric HFLines: 
    - Material criptográfico para todos los componentes de red y usuarios.

    Tipo de arquitectura: No existe una organización para orderers sinó que
                          cada organización tiene su orderer. Ver diseño en Github.
    - contenedores: 
                       org1: orderer1-org1 peer1-org1 rca-org1
                       org2: orderer1-org2 peer1-org2 rca-org2
                       protocolo TLS: ca-tls -> Emite certificados para org1 y org2.                

2- Se dispone de un canal en el cual se instala un chaincode y se aprueba y
   se hace commit para las dos organizaciones org1 y org2.

3- Se monitoriza la red con Prometheus (queries) y Grafana (Gráficos).
4- EL proceso se puede realizar ejecutando el script:
   09_levantar_hflines.sh
5- Para eliminar la red ejecutar el script:
   08_eliminar_hflines.sh
6- Para visualizar la arquitetura de contenedores de la red ejecutar:
   docker ps --format 'table {{.Names}}\t{{.ID}}\t{{.State}}'
7- Para una información más detallada:
   docker ps --format 'table {{.Names}}\t{{.ID}}\t{{.State}}\t{{.Ports}}'
8- Para el despliegue de un chaincode en el canal mychannel tanto en org1 y org2
   usaremos los scripts:

    -10a_chaincode_alta_org1.sh
      La ejecución seria:

      ./10a_chaincode_alta_org1.sh 1

      el parametro 1 indica que se registrará el chaincode con el nombre chaincode1, si 2 chaincode2 etc...
      internamente el script usa el chaincode existente en la carpeta:
       ./chcodes/chaincode/build/install/chaincode
      ejemplo de resultado: chaincode1:c2066d1ea51ebe1c70db570860f9e56a064d13283729e43aae2eec04b33212a0
      Si queremos utilizar otro chaincode simplemente hay que cambiar esta ruta.
    
    -10b_chaincode_alta_org1.sh 
     Utilizaremos ahora, el parámetro 1, y como segundo parámetro el chaincodeID que nos lo facilitará 
     la ejecución "10a_chaincode_alta_org1.sh 1"
     Siguiendo el ejemplo práctico actual ejecutaríamos:

      ./10b_chaincode_alta_org1.sh 1 chaincode1:c2066d1ea51ebe1c70db570860f9e56a064d13283729e43aae2eec04b33212a0
      
      Mediante este script realizamos el 'approveformyorg' del chaincodeID. en el peer de org1 para el
      canal 'mychannel'.

    - El siguiente script es: 11_chaincode_alta_org2.sh y realiza el alta ('install' y 'approveformyorg') 
      del chaincode mediante su chaincodeID en el peer de org2 para el canal 'mychannel'. 
      Siguiendo el procedimiento del ejemplo actual seria:

      ./11_chaincode_alta_org2.sh 1 chaincode1:c2066d1ea51ebe1c70db570860f9e56a064d13283729e43aae2eec04b33212a0

   - A continuación se realiza para org1 el 'checkcommitreadiness','commit' y comprobación del commit
     (querycommited) para el chaincode instalado en el canal 'mychannel' para el uso por las organizaciones
     org1 y org2, una vez esté realizado el 'commit'. 
     Todo el proceso lo automatiza el script '12_chaincode_aprove_commit.sh'

     Siguiendo el ejemplo actual ejecutariamos:

     ./12_chaincode_aprove_commit.sh 1 

     Una vez finalizada esta ejecución el paquete-id <chaincodeID> (chaincode1) ya está disponible.
     Veremos un mensaje similar a:

     Committed chaincode definition for chaincode 'chaincode1' on channel 'mychannel':
     Version: 1.0, Sequence: 1, Endorsement Plugin: escc, Validation Plugin: vscc, 
     Approvals: [org1MSP: true, org2MSP: true]

   - Para ejecutar las funciones del chaincode, disponemos de los scripts con prefijo '20_app0x':
   - Para aprender los parámetros que necesarios para su correcta ejecución disponemos de los scripts de
     ejemplos '30_ejemplos_uso_20_app0x_org1.sh' y '30_ejemplos_uso_20_app0x_org2.sh'. 
     Se recomienda revisar el código para entender como se pueden usar individualmente cada uno
     de los scripts con prefijo '20_app0x' individualmente.
     
     El primer script ejecuta los ejemplos como la organización org1 y el segundo para la organización org2.
     Los dos script necesitan obligatoriamente que el primer parámetro sea el indice numérico usado para
     etiquetar el nombre del chaincode.

     Siguiendo el actual ejemplo, la instrucción a ejecutar seria la siguiente:

     ./30_ejemplos_uso_20_app0x_org1.sh 1
     o 
     ./30_ejemplos_uso_20_app0x_org2.sh

  </blockquote>
</p>


