#!/bin/bash


function respaldo() {
    
    echo "Archivos en el directorio actual antes del respaldo:"
    count_before=$(find ./ -type f | wc -l)
    echo "Total de archivos: $count_before"

    tar -czf ./backup_$(date +%Y%m%d).tar.gz ./
    
    
    count_after=$(find ./ -type f | wc -l)
    echo "Archivos respaldados $count_after"
    

}


function informe() {
    echo "Generando informe de uso de recursos..."

  
    echo "Uso de CPU:"
    
    top -bn1 | grep "Cpu(s)"

    echo "Uso de memoria:"
    
    free -h

    
    echo "Uso de disco:"
   
    df -h

    echo "Informe generado."
}


function eliminar_cache() {
    echo "Eliminando archivos temporales de caché..."

    
    rm -rf ~/.cache/mozilla/firefox/*
    rm -rf ~/.cache/google-chrome/*

   
    rm -rf ~/.cache/*

    echo "Archivos temporales de caché eliminados."
    echo "Archivos en ~/.cache después de la eliminación:"
find ~/.cache -type f | wc -l

}


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