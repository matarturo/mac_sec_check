# macos_auditor
macOS Security Auditor

# Descripción

Este es un script de línea de comandos para macOS diseñado para auditar rápidamente las configuraciones de seguridad de un sistema. El script verifica el estado de las protecciones clave integradas en macOS, incluyendo Gatekeeper, Cuarentena de Archivos y XProtect. Además, busca evidencia de actividad sospechosa, como intentos de volcar el Llavero (Keychain).

El objetivo es proporcionar una herramienta simple para que los administradores de sistemas y el personal técnico puedan evaluar la postura de seguridad de un Mac de manera eficiente.

# Requisitos

 * Sistema Operativo: macOS (compatible con versiones de macOS Capitan 10.11 y posteriores).
   
 * Verificar que tiene instalado Git:
   git --version Sino tiene instalada el aplicativo, la forma más sencilla de instalar Git en macOS es a través de las Herramientas de Línea de Comandos de Xcode. En la Terminal, ejecute:
   xcode-select --install

Esto abrirá una ventana que le pedirá que instale las herramientas. Una vez que la instalación se complete, tendrá Git disponible.

 * Acceso: Se necesita acceso a la línea de comandos (Terminal).

 * Permisos: El script necesita permisos de ejecución.

# Descarga, Instalación y Uso
 * Primero, descargar el script del repositorio, usando la terminal macOS, desde el directorio o PATH /usr/local/bin, a través del comando:
sudo  git clone https://github.com/matarturo/mac_sec_check.git.  

(recomendado) Asi, usted podrá ejecutarlo desde cualquier lugar.

 * Otorgue permisos de ejecución: Ejecute el siguiente comando para que el script pueda ser ejecutado como un programa.

   sudo chmod +x macos_sec_check.sh

 * Ejecute el script:

   * Para ejecutar el script desde el directorio actual:

   sudo ./macos_sec_check.sh

# Compatibilidad

El script está diseñado para funcionar en varias versiones de macOS, pero su funcionalidad completa varía según la versión del sistema operativo debido a los cambios en las tecnologías de seguridad de Apple.

 * macOS El Capitan (10.11) y posteriores: El script es totalmente compatible y auditará tanto las protecciones de seguridad básicas como el estado de System Integrity Protection (SIP).

 * macOS Yosemite (10.10) y anteriores: En estas versiones, el comando csrutil no existe, ya que SIP fue introducido en El Capitan. Si se usa la versión del script
 *
 * que incluye esa verificación, se generará un error. Si su sistema es Yosemite o anterior, se recomienda usar la versión modificada del script.

# Guía de Mitigación

Para cada detección que el script genere, el personal técnico puede consultar una guía detallada de mitigación. En este documento se explica cómo contener, analizar y erradicar cada tipo de amenaza detectada.

​Este documento es una guía para el personal técnico sobre cómo responder a las alertas generadas por el script de auditoría de seguridad de macOS.

​1. Detección: SIP está Deshabilitado.

​Riesgo: Crítico. Un atacante puede modificar o inyectar código en directorios y procesos clave del sistema. La integridad del sistema está comprometida.
​
Acciones de Mitigación:

​  * Aislar el sistema: Desconecte el equipo de la red (Wi-Fi y Ethernet) para evitar una propagación.

  * ​Reiniciar en Modo Recuperación: Reinicie el Mac y mantenga presionadas las teclas Command (⌘) + R al encender.
​Habilitar SIP: En el menú Utilidades, abra Terminal y ejecute el comando csrutil enable.

  * ​Reiniciar el Mac: Reinicie el sistema normalmente.
​Análisis Forense: Revise los logs del sistema y las aplicaciones recientes para identificar la causa de la desactivación de SIP. Es probable que haya sido desactivado por un atacante o por la instalación de un software no confiable.

​2. Detección: Gatekeeper está Deshabilitado.

​Riesgo: Alto. El sistema puede ejecutar aplicaciones no firmadas o no verificadas, lo que aumenta la probabilidad de infección por malware.

​Acciones de Mitigación:

​  * Habilitar Gatekeeper: Abra Terminal y ejecute el comando sudo spctl --master-enable. Esto restaurará Gatekeeper a su configuración predeterminada.
​  * Verificar la configuración de seguridad: Vaya a Ajustes del Sistema > Privacidad y seguridad > Seguridad y confirme que la opción "Permitir aplicaciones descargadas de:" esté configurada en "App Store y desarrolladores identificados".
  * ​Auditoría de aplicaciones: Revise la lista de aplicaciones instaladas (/Applications) en busca de programas desconocidos o sospechosos.

​3. Detección: La base de datos de XProtect está desactualizada.

​Riesgo: Medio. El sistema es vulnerable a amenazas de malware más recientes que no están cubiertas por las firmas de protección.

​Acciones de Mitigación:

   * ​Forzar una actualización: Asegúrese de que el Mac esté conectado a internet y abra Ajustes del Sistema > General > Actualización de software. Verifique si hay actualizaciones disponibles.
​   * Monitorear la conexión: Asegúrese de que el sistema pueda comunicarse con los servidores de Apple para obtener actualizaciones de XProtect. Si el problema persiste, podría ser un indicio de que un atacante está bloqueando las conexiones.

​4. Detección: El servicio de Cuarentena de Archivos no se ha encontrado.

​Riesgo: Alto. La protección contra la ejecución de archivos descargados de Internet está ausente, lo que facilita la ejecución de malware.
​Acciones de Mitigación:

​   * Revisar los archivos de lanzamiento (Launch Agents y Launch Daemons): Busque archivos sospechosos en las siguientes ubicaciones que puedan estar interfiriendo con el servicio:

​~/Library/LaunchAgents
​/Library/LaunchAgents
​/Library/LaunchDaemons

   * ​Restaurar desde copia de seguridad: Si no se encuentra una causa evidente, considere restaurar el sistema a partir de una copia de seguridad reciente y segura para garantizar que el servicio se reinicie correctamente.

​5. Detección: Se ha encontrado un comando sospechoso en el historial (ej: security dump-keychain).

​Riesgo: Crítico. Un atacante probablemente ha logrado acceso al sistema y está intentando extraer credenciales.
​Acciones de Mitigación:

   * ​Aislar el sistema inmediatamente.
​Finalizar procesos sospechosos: Si el proceso sigue activo, use el comando kill para terminarlo.
   * ​Cambiar todas las contraseñas: Asuma que todas las contraseñas guardadas en el Keychain han sido comprometidas. Cambie de inmediato las contraseñas de las cuentas bancarias, de correo electrónico y de otras plataformas importantes.
    * ​Análisis forense profundo: Examine los logs del sistema y las actividades de red para determinar el alcance total del ataque, incluyendo cómo se obtuvo acceso al sistema.

NOTAS IMPORTANTES:

Procedimiento para Detener Procesos Sospechosos

Cuando el script de auditoría detecta una actividad sospechosa (como el uso de security dump-keychain), el personal técnico debe actuar rápidamente para detener el proceso antes de que cause más daño.

Paso 1: Identificar el Proceso

El script por sí solo detecta el comando en el historial, pero no proporciona el ID del proceso (PID). Para encontrar el PID de un proceso que está en ejecución, se puede usar el comando ps.

 * Comando: ps aux | grep "nombre_del_proceso"

 * Ejemplo de uso para la detección de dump-keychain:

   ps aux | grep "security dump-keychain"


   Este comando listará los procesos en ejecución. La salida se vería similar a esto:

   usuario   12345  0.0  0.1  4567890 123456 s001  R+    1:23PM   0:00.01 /usr/bin/security dump-keychain


   El número que aparece en la segunda columna (12345 en este ejemplo) es el ID del proceso (PID).

Paso 2: Finalizar el Proceso

Una vez que se tiene el PID, se puede usar el comando kill para terminar el proceso. Se recomienda usar las siguientes opciones, de la menos agresiva a la más agresiva:

 * Opción 1: Señal TERM (Terminar)

   * Comando: kill <PID> o kill -15 <PID>

   * Función: Esta señal le pide al proceso que termine de forma limpia, dando tiempo para que guarde los datos antes de cerrarse.

   * Cuándo usarla: Es el primer intento. Es la opción más segura.

 * Opción 2: Señal KILL (Matar)

   * Comando: kill -9 <PID>

   * Función: Esta señal obliga al sistema operativo a terminar el proceso de forma inmediata, sin darle la oportunidad de limpiar o guardar datos. Es una "muerte súbita".

   * Cuándo usarla: Si el proceso no responde a la señal TERM (si es un malware diseñado para ser persistente) o si el tiempo es crítico.

Ejemplo completo:

Si el ps le devolvió un PID de 12345, el personal técnico ejecutaría lo siguiente:

# Intento 1: Terminar de forma limpia

kill 12345


# Si el proceso sigue en ejecución, se pasa a la siguiente opción

kill -9 12345


Paso 3: Verificación

Después de ejecutar el comando kill, se debe verificar que el proceso ha sido detenido.

 * Comando: ps aux | grep "security dump-keychain"

 * Resultado esperado: El comando no debería mostrar ningún resultado (o solo el propio proceso grep), lo que confirma que el proceso ha sido terminado.

Este procedimiento, aunque simple, es fundamental para contener un ataque en curso y es un paso crucial en cualquier plan de respuesta a incidentes.
