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

 * macOS Yosemite (10.10) y anteriores: En estas versiones, el comando csrutil no existe, ya que SIP fue introducido en El Capitan. Si se usa la versión del script que incluye esa verificación, se generará un error. Si su sistema es Yosemite o anterior, se recomienda usar la versión modificada del script.

# Guía de Mitigación

Para cada detección que el script genere, el personal técnico puede consultar una guía detallada de mitigación. En este documento se explica cómo contener, analizar y erradicar cada tipo de amenaza detectada.
