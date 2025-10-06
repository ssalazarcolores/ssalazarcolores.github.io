#!/bin/bash

# Script para iniciar el servidor Jekyll del sitio web académico
# Creado por Dr. Sebastián Salazar-Colores

echo "🚀 Iniciando servidor del sitio web académico..."

# Colores para salida
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Función para verificar si Jekyll está instalado
check_jekyll() {
    if ! command -v jekyll &> /dev/null; then
        echo -e "${YELLOW}⚠️  Jekyll no está instalado. Instalando...${NC}"

        # Verificar si estamos en Ubuntu/Debian
        if command -v apt &> /dev/null; then
            echo "📦 Instalando Jekyll vía apt..."
            sudo apt update
            sudo apt install -y jekyll ruby-dev build-essential
        elif command -v gem &> /dev/null; then
            echo "📦 Instalando Jekyll vía gem..."
            sudo gem install jekyll bundler
        else
            echo -e "${RED}❌ No se pudo encontrar un gestor de paquetes compatible.${NC}"
            echo "Por favor instala Jekyll manualmente:"
            echo "  Ubuntu/Debian: sudo apt install jekyll"
            echo "  O con Ruby gem: sudo gem install jekyll"
            exit 1
        fi
    else
        echo -e "${GREEN}✅ Jekyll ya está instalado${NC}"
    fi
}

# Función para limpiar y preparar el sitio
prepare_site() {
    echo "🧹 Limpiando archivos conflictivos..."

    # Eliminar archivos que pueden causar conflictos
    rm -f index.markdown Gemfile Gemfile.lock

    # Limpiar build anterior si existe
    if [ -d "_site" ]; then
        echo "🗑️  Eliminando build anterior..."
        rm -rf _site
    fi

    # Corregir permisos si es necesario
    if [ ! -w "." ]; then
        echo "🔐 Corrigiendo permisos..."
        sudo chown -R $USER:$USER .
    fi
}

# Función para iniciar el servidor
start_server() {
    echo "🌐 Iniciando servidor en http://localhost:4000"
    echo "📝 Presiona Ctrl+C para detener el servidor"
    echo "🔍 Abre tu navegador y visita: http://localhost:4000"
    echo ""

    # Iniciar Jekyll server
    jekyll serve --host 0.0.0.0 --port 4000 --livereload
}

# Ejecutar funciones
check_jekyll
prepare_site
start_server