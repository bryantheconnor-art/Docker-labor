#!/usr/bin/env bash
# ============================================================
# Laboratório: Contêineres com Docker
# Autor: Bryan da Silva (GitHub: Bryantheconnor-art)
#
# Referência dos comandos da aula, organizados por etapa.
# Copie e execute os comandos UM A UM em um terminal Bash.
# No Windows, execute "wsl --version" separadamente no PowerShell.
# Os comandos de remoção estão comentados para evitar ações acidentais.
# ============================================================

# ----- 1.1 Verificando o ambiente -----
# No Windows, rode separadamente no PowerShell: wsl --version
docker --version
docker run hello-world

# ----- 1.2 Verificando imagens e contêineres -----
docker images
docker ps

# ----- 1.3 Subindo o servidor web Apache -----
# -d: segundo plano | -p 8080:80: porta host:contêiner | --name: nome do contêiner
docker run -d -p 8080:80 --name meu-apache httpd:alpine
# Acesse no navegador: http://localhost:8080

# ----- 1.4 Gerenciando o ciclo de vida -----
docker ps                    # listar contêineres ativos
docker logs meu-apache       # ver logs de acesso
docker stop meu-apache       # parar o contêiner
docker start meu-apache      # iniciar novamente

# --- Limpeza opcional ---
# Remove somente o contêiner deste laboratório:
# docker rm -f meu-apache
#
# Remove TODOS os contêineres parados deste computador. Confira antes:
# docker container prune
#
# Evite "docker rm -f $(docker ps -aq)": remove todos os contêineres,
# inclusive os ativos, e não é necessário para este laboratório.
