# mac_sec_check
macOS Security Auditor

# Descripción

Este es un script de línea de comandos para macOS diseñado para auditar rápidamente las configuraciones de seguridad de un sistema. El script verifica el estado de las protecciones clave integradas en macOS, incluyendo Gatekeeper, Cuarentena de Archivos y XProtect. Además, busca evidencia de actividad sospechosa, como intentos de volcar el Llavero (Keychain).

El objetivo es proporcionar una herramienta simple para que los administradores de sistemas y el personal técnico puedan evaluar la postura de seguridad de un Mac de manera eficiente.

# Requisitos

 * Sistema Operativo: macOS (compatible con versiones de macOS Yosemite y posteriores).

 * Acceso: Se necesita acceso a la línea de comandos (Terminal).

 * Permisos: El script necesita permisos de ejecución.

# Instalación y Uso

 * Guarde el archivo: Copie el código del script y guárdelo como un archivo de texto plano llamado macos_sec_check.sh.

 * Abra la Terminal: Navegue hasta la ubicación donde guardó el archivo.

 * Otorgue permisos de ejecución: Ejecute el siguiente comando para que el script pueda ser ejecutado como un programa.

   chmod +x macos_sec_check.sh


 * Ejecute el script:

   * Para ejecutar el script desde el directorio actual:

     ./macos_sec_check.sh


   * (Recomendado) Para una mejor práctica y accesibilidad, mueva el script a un directorio en su PATH, como /usr/local/bin/. Luego podrá ejecutarlo desde cualquier lugar.

     sudo mv macos_sec_check.sh /usr/local/bin/


     Una vez movido, puede ejecutarlo simplemente escribiendo el nombre del script:

     macos_sec_check.sh


# Compatibilidad

El script está diseñado para funcionar en varias versiones de macOS, pero su funcionalidad completa varía según la versión del sistema operativo debido a los cambios en las tecnologías de seguridad de Apple.

 * macOS El Capitan (10.11) y posteriores: El script es totalmente compatible y auditará tanto las protecciones de seguridad básicas como el estado de System Integrity Protection (SIP).

 * macOS Yosemite (10.10) y anteriores: En estas versiones, el comando csrutil no existe, ya que SIP fue introducido en El Capitan. Si se usa la versión del script que incluye esa verificación, se generará un error. Si su sistema es Yosemite o anterior, se recomienda usar la versión modificada del script.

# Guía de Mitigación

Para cada detección que el script genere, el personal técnico puede consultar una guía detallada de mitigación. En este documento se explica cómo contener, analizar y erradicar cada tipo de amenaza detectada.
