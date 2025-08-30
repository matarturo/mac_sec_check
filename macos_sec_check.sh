#!/bin/bash
# Autor: Arturo Mata - JØKΣR
# Contacto: arturo.mata@gmail.com
# Versión: 1.0.0

echo "Iniciando auditoría de seguridad de macOS..."
echo "---"

# 1. Verificación de SIP
# SIP es fundamental. Si está desactivado, el sistema es extremadamente vulnerable.
echo "Verificando el estado de System Integrity Protection (SIP)..."
sip_status=$(csrutil status | grep 'status' | awk '{print $NF}' | sed 's/.$//')
if [ "$sip_status" = "enabled" ]; then
  echo "✅ SIP está Habilitado."
else
  echo "⚠️ SIP está Deshabilitado. ¡Acción requerida de inmediato!"
fi
echo "---"

# 2. Verificación de Gatekeeper
# Gatekeeper previene la ejecución de aplicaciones no firmadas o no verificadas.
echo "Verificando el estado de Gatekeeper..."
gatekeeper_status=$(spctl --status | grep 'assessments' | awk '{print $NF}')
if [ "$gatekeeper_status" = "enabled" ]; then
  echo "✅ Gatekeeper está Habilitado."
else
  echo "⚠️ Gatekeeper está Deshabilitado. ¡Se pueden ejecutar aplicaciones no verificadas!"
fi
echo "---"

# 3. Verificación de Cuarentena de Archivos
# Esta protección se basa en atributos extendidos de los archivos.
# El script verifica si el servicio está en funcionamiento.
echo "Verificando el servicio de Cuarentena de Archivos..."
quarantine_status=$(launchctl list | grep 'com.apple.quarantine')
if [ -n "$quarantine_status" ]; then
  echo "✅ El servicio de Cuarentena de Archivos está activo."
else
  echo "⚠️ El servicio de Cuarentena de Archivos no se ha encontrado. El sistema puede estar comprometido."
fi
echo "---"

# 4. Verificación de XProtect
# XProtect usa firmas para detectar malware. El script puede verificar si las firmas están actualizadas.
echo "Verificando la base de datos de XProtect..."
last_update=$(stat -f "%m" /Library/Apple/System/Library/CoreServices/XProtect.bundle/Contents/Resources/XProtect.meta.plist)
current_time=$(date +%s)
diff_seconds=$((current_time - last_update))
diff_days=$((diff_seconds / 86400)) # 86400 segundos en un día
if [ "$diff_days" -le 7 ]; then
  echo "✅ La base de datos de XProtect se actualizó hace menos de 7 días."
else
  echo "⚠️ La base de datos de XProtect está desactualizada. Última actualización: $diff_days días."
fi
echo "---"

# 5. Detección de uso de comandos sospechosos (relacionado con Keychain)
# Se revisa el historial del usuario para detectar intentos de acceso al Keychain.
echo "Buscando comandos sospechosos en el historial (relacionado con Keychain)..."
if history | grep -q 'security dump-keychain'; then
  echo "⚠️ ¡Advertencia! Se ha encontrado 'security dump-keychain' en el historial. Posible intento de volcado de Keychain."
else
  echo "✅ No se han encontrado comandos sospechosos en el historial."
fi
echo "---"

echo "Auditoría de seguridad completada."
