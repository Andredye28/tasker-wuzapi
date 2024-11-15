#!/bin/bash
echo "##### ESTE PROCESSO TARDARÁ ENTRE 15 A 20 MINUTOS #####"
echo " Criado por Andredye desenvolvedor Tasker"

# Instalar Git e Go
echo "Instalando Git e Go..."
pkg install -y git golang &>/dev/null
echo "Git e Go foram instalados com sucesso."

# Clonar o repositório tasker-wuzapi
echo "Clonando o repositório tasker_wuzapi..."
git clone https://github.com/Andredye28/tasker_wuzapi &>/dev/null
echo "Repositório clonado com sucesso."

# Navegar até o diretório do projeto
cd tasker_wuzapi

# Compilar o binário do WuzAPI
echo "Compilando o binário..."
go build . &>/dev/null

# Verificar se o binário foi compilado com sucesso
if [ -f "./wuzapi" ]; then
    echo "WuzAPI foi compilado com sucesso no Termux."

    # Dar permissões de execução ao binário e ao script de inicialização
    chmod +x wuzapi
    chmod +x start_wuzapi.sh

    echo "Permissões de execução atribuídas ao WuzAPI."
else
    echo "Erro ao compilar o WuzAPI."
    exit 1
fi

# Concedendo permissão para aplicativos externos no Termux
mkdir -p ~/.termux && echo "allow-external-apps=true" > ~/.termux/termux.properties
termux-reload-settings
echo "Permissão para aplicativos externos configurada."

# Adicionando a reconfiguração automática de permissão no .bashrc
if ! grep -q "allow-external-apps=true" ~/.bashrc; then
    echo -e "\n# Configuração automática para permitir aplicativos externos no Termux após reinício" >> ~/.bashrc
    echo "mkdir -p ~/.termux && echo 'allow-external-apps=true' > ~/.termux/termux.properties && termux-reload-settings" >> ~/.bashrc
    echo "Configuração para reativação automática adicionada ao .bashrc"
else
    echo "Configuração para reativação automática já existente no .bashrc"
fi

# Executar WuzAPI
echo "Executando WuzAPI..."
./wuzapi
