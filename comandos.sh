#!/usr/bin/env bash
# ============================================================
# Laboratório: Volumes e Docker Compose
# Autor: Bryan da Silva (GitHub: Bryantheconnor-art)
#
# Referência dos comandos da aula, organizados por etapa.
# Copie e execute os comandos UM A UM no Git Bash.
# Os comandos de remoção estão comentados para evitar ações acidentais.
# ============================================================

# ----- 0. Verificando o ambiente -----
docker --version
docker compose version

# ----- 1. Preparando a pasta do projeto -----
mkdir -p C:/meu-site
echo '<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>Meu site</title><h1>Meu Site no Docker!</h1><h2>nome-do-aluno</h2></html>' > C:/meu-site/index.html
# Troque "nome-do-aluno" pelo seu nome.

# ----- 2. Subindo o Apache com Volume (-v) -----
# -v "PASTA_DO_WINDOWS:PASTA_DO_CONTAINER" (bind mount)
docker run -d -p 8080:80 --name site-volume -v "C:/meu-site:/usr/local/apache2/htdocs/" httpd:alpine
# Acesse no navegador: http://localhost:8080  (Ctrl + Shift + R limpa o cache)
# Se a pasta aparecer vazia no contêiner, use:
# MSYS_NO_PATHCONV=1 docker run -d -p 8080:80 --name site-volume -v "C:/meu-site:/usr/local/apache2/htdocs/" httpd:alpine

docker ps
docker logs site-volume

# ----- 3. Alterando o conteúdo -----
# Edite C:/meu-site/index.html no editor, salve e atualize o navegador.

# ----- 4. Limpando o ambiente (libera a porta 8080) -----
docker rm -f site-volume
# Não apaga os arquivos de C:/meu-site.

# ----- 5. Docker Compose (execute dentro da pasta "versão 2") -----
docker compose config
docker compose up -d
docker compose ps
docker compose logs web
# Acesse no navegador: http://localhost:8080
# Edite site/index.html, salve e atualize o navegador.

# Parar e remover os recursos criados pelo Compose:
# docker compose down
