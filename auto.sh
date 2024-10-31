#!/bin/bash

LOG_FILE="informe.log"


RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' 

function respaldo() {
    echo -e "${BLUE}Archivos en el directorio actual antes del respaldo:${NC}"
    count_before=$(find ./ -type f | wc -l)
    echo -e "${YELLOW}Total de archivos: $count_before${NC}"

    
    find . -maxdepth 1 -name "backup_*.tar.gz" -type f -mtime +7 -exec rm {} \;
    echo -e "${GREEN}Se eliminaron backups antiguos (más de 7 días).${NC}"

}

function informe() {
    echo -e "${BLUE}Generando informe de uso de recursos...${NC}"
    
    
    {
        echo -e "${BLUE}Informe generado el: $(date)${NC}"
        echo -e "${YELLOW}Uso de CPU:${NC}"
        top -bn1 | grep "Cpu(s)"
        echo
        echo -e "${YELLOW}Uso de memoria:${NC}"
        free -h
        echo
        echo -e "${YELLOW}Uso de disco:${NC}"
        df -h
        echo "---------------------------------"
    } > "$LOG_FILE"
    
    echo -e "${GREEN}Informe guardado en $LOG_FILE.${NC}"
}

function eliminar_cache() {
    echo -e "${BLUE}Eliminando archivos temporales de caché...${NC}"
    
    
    rm -rf ~/.cache/mozilla/firefox/*
    rm -rf ~/.cache/google-chrome/*
    rm -rf ~/.cache/opera/*
    rm -rf ~/.cache/chromium/*
    
    
    rm -rf ~/.cache/*
    
    echo -e "${GREEN}Archivos temporales de caché eliminados.${NC}"
    echo -e "${YELLOW}Archivos en ~/.cache después de la eliminación:${NC}"
    find ~/.cache -type f | wc -l
}

while true; do
    echo -e "${BLUE}Seleccione una opción:${NC}"
    echo -e "${YELLOW}1) Respaldo de un directorio${NC}"
    echo -e "${YELLOW}2) Informe de uso de recursos${NC}"
    echo -e "${YELLOW}3) Eliminar archivos temporales${NC}"
    echo -e "${YELLOW}4) Salir${NC}"
    
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
            echo -e "${GREEN}Saliendo...${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Opción no válida. Intente de nuevo.${NC}"
            ;;
    esac
done