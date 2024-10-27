#!/bin/bash

# Función para respaldar un directorio
function respaldo() {
    # Contar archivos antes del respaldo
    echo "Archivos en el directorio actual antes del respaldo:"
    count_before=$(find ./ -type f | wc -l)
    echo "Total de archivos: $count_before"

    tar -czf ./backup_$(date +%Y%m%d).tar.gz ./
    
    # Contar archivos después del respaldo
    count_after=$(find ./ -type f | wc -l)
    echo "Archivos respaldados :"
    echo "Total de archivos: $count_after"

}

# Función para generar un informe de recursos
function informe() {
    echo "Generando informe de uso de recursos..."

    # Informe de uso de CPU
    echo "Uso de CPU:"
    # Muestra un resumen del uso de la CPU
    top -bn1 | grep "Cpu(s)"

    # Informe de uso de memoria
    echo "Uso de memoria:"
    # Muestra la memoria total, usada y libre
    free -h

    # Informe de uso de disco
    echo "Uso de disco:"
    # Muestra el uso de disco en todas las particiones
    df -h

    echo "Informe generado."
}

# Función para eliminar archivos temporales
function eliminar_cache() {
    echo "Eliminando archivos temporales de caché..."

    # Eliminar caché de navegadores (ejemplo para Firefox y Chrome)
    rm -rf ~/.cache/mozilla/firefox/*
    rm -rf ~/.cache/google-chrome/*

    # Eliminar caché del sistema
    rm -rf ~/.cache/*

    echo "Archivos temporales de caché eliminados."
    echo "Archivos en ~/.cache después de la eliminación:"
find ~/.cache -type f | wc -l

}

# Menú interactivo
while true; do
    echo "Seleccione una opción:"
    echo "1) Respaldo de un directorio"
    echo "2) Informe de uso de recursos"
    echo "3) Eliminar archivos temporales"
    echo "4) Salir"
    
    read -p "Ingrese el número de la opción: " opcion
    
    case $opcion in
        1)
            respaldo
            ;;
        2)
            informe
            ;;
        3)
            eliminar_cache
            ;;
        4)
            echo "Saliendo..."
            exit 0
            ;;
        *)
            echo "Opción no válida. Intente de nuevo."
            ;;
    esac
done