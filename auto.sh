#!/bin/bash



RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' 

function respaldo() {
    echo -e "${BLUE}Iniciando respaldo...${NC}"
    tar -czf ./backup_$(date +%Y%m%d).tar.gz ./
    echo -e "${GREEN}Respaldo completado.${NC}"
}



function informe() {
    echo -e "${BLUE}Generando informe de uso de recursos...${NC}"
    {
        echo "Informe generado el: $(date)"
        echo "Uso de CPU:"
        top -b -n1 | grep "Cpu(s)"
        echo
        echo "Uso de memoria:"
        free -h
        echo
        echo "Uso de disco:"
        df -h
        echo
    } > uso_recursos.log
    echo -e "${GREEN}Informe completo generado en uso_recursos.log.${NC}"
}



function eliminar_cache() {
    echo -e "${YELLOW}Eliminando archivos temporales de caché...${NC}"
    
    rm -rf ~/.cache/mozilla/firefox/*
    rm -rf ~/.cache/google-chrome/*
    rm -rf ~/.cache/*

    echo -e "${GREEN}Archivos temporales de caché eliminados.${NC}"
    echo -e "${YELLOW}Archivos en ~/.cache después de la eliminación:${NC}"
    find ~/.cache -type f | wc -l
}



while true; do
    echo -e "${BLUE}Seleccione una opción:${NC}"
    echo -e "${YELLOW}1) Respaldo del directorio${NC}"
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