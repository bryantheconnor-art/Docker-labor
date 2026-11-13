#!/usr/bin/env bash
# ============================================================
# Laboratório: Orquestração com Docker Compose
# Autor: Bryan da Silva (GitHub: Bryantheconnor-art)
#
# Referência dos comandos da aula, organizados por etapa.
# Copie e execute os comandos UM A UM no Git Bash.
# Execute cada bloco dentro da pasta indicada.
# ============================================================

# ----- 1. Projeto web com Docker Compose (pasta lab-compose) -----
cd lab-compose
docker compose version
docker compose up -d
docker compose ps
docker compose logs
# Acesse no navegador: http://localhost:8080
docker compose down
cd ..

# ----- 2. MySQL (pasta mysql) -----
cd mysql
docker compose up -d
docker compose ps
docker compose logs          # aguarde a mensagem "ready for connections"

# Acessar o MySQL de forma interativa (a senha está no docker-compose.yml):
MSYS_NO_PATHCONV=1 docker exec -it mysql-bryan sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" loja_bryan'
#   Dentro do cliente: SHOW TABLES; SELECT * FROM clientes_bryan; exit

# Executar o script SQL (cria a tabela, insere e consulta):
MSYS_NO_PATHCONV=1 docker exec -it mysql-bryan sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" < /scripts/script.sql'

# Encerrar (o "-v" também apaga os dados do volume):
# docker compose down
# docker compose down -v
cd ..

# ----- 3. MariaDB (pasta mariadb) -----
cd mariadb
docker compose up -d
docker compose ps
docker compose logs          # aguarde a mensagem "ready for connections"

# Acessar o MariaDB de forma interativa:
MSYS_NO_PATHCONV=1 docker exec -it mariadb-bryan sh -c 'mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" loja_bryan'
#   Dentro do cliente: SHOW TABLES; SELECT * FROM produtos_bryan; exit

# Executar o script SQL:
MSYS_NO_PATHCONV=1 docker exec -it mariadb-bryan sh -c 'mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" < /scripts/script.sql'

# Encerrar:
# docker compose down
# docker compose down -v
cd ..
