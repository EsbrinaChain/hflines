
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

</p>

## PUESTA EN MARCHA de Hyperledger Fabric HFLines

<p align='justify'>

Para utilizar **HFLINES versión** y realizar su puesta en funcionamiento
en pocos pasos, seguiremos el siguiente **TUTORIAL** una vez clonado el
proyecto en su máquina virtual.

</p>



En nuestro caso: Google cloud VM:

<img src="/img/VM.png" style="width:11cm;height:5cm" alt="Interfaz de usuario gráfica, Aplicación, Tabla Descripción generada automáticamente" />


**Requisitos** previos al despliegue de **HFLINES** (las versiones son sólo orientativas, pero en nuestro caso no han presentado incompatibilidades):

-   Curl (curl 7.81.0).

-   Git (git version 2.34.1)

-   Docker (Docker version 26.1.3, build b72abbb)

-   Docker compose (Docker Compose version v2.27.0).

-   Npm (8.5.1).

-   Java

    -   openjdk version "21.0.3" 2024-04-16
    -   OpenJDK Runtime Environment (build
        21.0.3+9-Ubuntu-1ubuntu122.04.1)
    -   OpenJDK 64-Bit Server VM (build 21.0.3+9-Ubuntu-1ubuntu122.04.1,
        mixed mode, sharing)
    -   \[Si se programa Chaincodes en Java, los contenedores Docker disponen JDK 11\]

-   Jq (jq-1.6)
-   Fabric-samples (v 2.x):     curl -sSL https://bit.ly/2ysbOFE \| bash -s

1.  Existe un script (<b>09_levantar_hflines.sh</b>) para crear la red Hyperledger fabric **HFLines**
    que automatiza la disponibilidad de:

  -   Todo el **<u>material criptográfico</u>** para todos los componentes de red y usuarios.

  -   Levantar toda la arquitectura de contenedores para implementar la red Hyperledger Fabric HFLines. En este proyecto se decidido disponer de dos organizaciones **Org1** y **Org2** con los siguientes   contenedores:

<img src="/img/contenedores.png" style="width:10cm;height:7cm" alt="Arquitectura" />
<p align='justify'>
   -   Se dispone de un canal en el cual se facilita a las dos organizaciones la posibilidad de ejecutar un chaincode.

    Se monitoriza la red con:

          -   **Prometheus** (queries)
          -   **Grafana** (Gráficos)
</p>

<p align='justify'>
Toda la puesta en marcha está automatizada en el script
<b>09_levantar_hflines.sh</b>.</p>

<p align='justify'> Para eliminar o dar de baja una red en funcionamiento, podemos ejecutar el
 script <b>08_eliminar_hflines.sh</b>.</p>

 Para visualizar la arquitetura de contenedores de la red ejecutar:

 **docker ps --format 'table {{.Names}}\\t{{.ID}}\\t{{.State}}'**

 Para una información más detallada:

 **docker ps --format 'table
 {{.Names}}\\t{{.ID}}\\t{{.State}}\\t{{.Ports}}'**

 Para el despliegue de un chaincode en el canal ‘mychannel’ disponible
 tanto para org1 como org2, usaremos una secuencia de scripts:

-   10a_chaincode_alta_org1.sh

 La ejecución seria:

 -   **./10a_chaincode_alta_org1.sh 1**

 el parametro 1 indica que se registrará el chaincode con el nombre
 chaincode1, si 2 chaincode2 etc...

 Internamente el script usa el chaincode existente en la carpeta:

 **./chcodes/chaincode/build/install/chaincode**

 ejemplo de resultado:
 **chaincode1:c2066d1ea51ebe1c70db570860f9e56a064d13283729e43aae2eec04b33212a0**

 Si queremos utilizar otro chaincode simplemente hay que cambiar esta
 ruta.

-   **10b_chaincode_alta_org1.sh**


 Este script, usa un parámetro de índice “1”, y como segundo parámetro
 el chaincodeID obtenido de la ejecución del script **10a_chaincode_alta_org1.sh**.

 Siguiendo el ejemplo práctico actual ejecutaríamos (todo en la misma linea):

**./10b_chaincode_alta_org1.sh 1**
**chaincode1:c2066d1ea51ebe1c70db570860f9e56a064d13283729e43aae2eec04b33212a0**

Mediante este script realizamos el 'approveformyorg' del chaincodeID. en
el peer de org1 para el canal 'mychannel'.

-   **11_chaincode_alta_org2.sh**

 Realiza el alta ('install' y approveformyorg') del chaincode mediante
 su chaincodeID en el peer de org2 para el canal 'mychannel'.

 Siguiendo el procedimiento del ejemplo actual seria:

**./11_chaincode_alta_org2.sh 1
chaincode1:c2066d1ea51ebe1c70db570860f9e56a064d13283729e43aae2eec04b33212a0**

A continuación se realiza para **org1** el 'checkcommitreadiness','commit' y
comprobación del commit (querycommited) para el chaincode instalado en
el canal 'mychannel' para el uso por las organizaciones **org1** y **org2**, una
vez esté realizado el 'commit'. Todo el proceso lo automatiza el script:

-   **12_chaincode_aprove_commit.sh**

Siguiendo el ejemplo actual ejecutaríamos:

 **./12_chaincode_aprove_commit.sh 1**

Una vez finalizada esta ejecución el paquete-id \<chaincodeID
(chaincode1) ya está disponible.

Veremos un mensaje similar a:

**Committed chaincode definition for chaincode 'chaincode1' on channel
'mychannel':**

**Version: 1.0, Sequence: 1, Endorsement Plugin: escc, Validation
Plugin: vscc,**

**Approvals: \[org1MSP: true, org2MSP: true\]**

-   Para ejecutar las funciones del chaincode, disponemos de los scripts
    con prefijo '20_app0x':

-   Para aprender los parámetros que necesarios para su correcta
    ejecución disponemos de los scripts de ejemplos:

    - <b>30_ejemplos_uso_20_app0x_org1.sh</b><br>
    - <b>30_ejemplos_uso_20_app0x_org2.sh</b>

-   Se recomienda revisar el código para entender como se pueden usar
    individualmente cada uno de los scripts con prefijo '**20_app0x**'
    individualmente.

-   El primer script ejecuta los ejemplos como la organización org1 y el
    segundo para la organización org2.

-   Los dos script necesitan obligatoriamente que el primer parámetro
    sea el índice numérico usado para etiquetar el nombre del chaincode.

-   Siguiendo el actual ejemplo, la instrucción a ejecutar seria la
    siguiente:

     - <b>./30_ejemplos_uso_20_app0x_org1.sh 1</b>

        o bien

     - <b>./30_ejemplos_uso_20_app0x_org2.sh 1</b>

 El parámetro de índice variará según el que se haya usado al registrar el chaincode con
 **10a_chaincode_alta_org1.sh**.

