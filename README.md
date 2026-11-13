# Laboratório: Orquestração com Docker Compose

**Autor:** Bryan da Silva  
**GitHub:** [@Bryantheconnor-art](https://github.com/Bryantheconnor-art)

Nesta aula, vamos aprender a gerenciar e conectar múltiplos serviços de forma
organizada usando um único arquivo de configuração com o **Docker Compose**.

## Estrutura do repositório

```text
versão 3/
├── README.md
├── comandos.sh
├── lab-compose/        # Parte 1: servidor web
│   ├── docker-compose.yml
│   └── index.html
├── mysql/              # Parte 2: MySQL
│   ├── docker-compose.yml
│   └── script.sql
└── mariadb/            # Parte 3: MariaDB
    ├── docker-compose.yml
    └── script.sql
```

## Pré-requisitos

- Docker Desktop instalado e em execução.
- Git Bash e um editor de código, como o VS Code.

```bash
docker --version
docker compose version
```

---

## 1. Subindo um projeto web com Docker Compose

Em vez de digitar comandos `docker run` longos com várias flags (`-d`, `-p`,
`-v`, `--name`), definimos toda a configuração do servidor em um arquivo YAML.

### 1.1 Preparar a pasta do projeto

O roteiro da aula usa `C:/lab-compose`. Neste repositório, a mesma pasta está
em [`lab-compose/`](lab-compose/). Para criá-la do zero no Git Bash:

```bash
mkdir C:/lab-compose
cd C:/lab-compose
echo "<h1>Projeto Web com Docker Compose!</h1>" > index.html
```

### 1.2 O arquivo `docker-compose.yml`

```yaml
services:
  servidor-web:
    image: httpd:alpine
    container_name: apache-compose-bryan
    ports:
      - "8080:80"
    volumes:
      - ./:/usr/local/apache2/htdocs/
```

> **Entendendo o arquivo:**
> * `services`: lista de contêineres que fazem parte da aplicação.
> * `servidor-web`: nome do serviço dentro do Compose.
> * `image`: imagem utilizada (`httpd:alpine`).
> * `container_name`: nome fixo do contêiner (personalizado).
> * `ports`: equivalente à flag `-p 8080:80`.
> * `volumes`: equivalente à flag `-v`; o `./` aponta para a pasta atual.

### 1.3 Executar e gerenciar

Dentro da pasta `lab-compose`:

```bash
docker compose version
docker compose up -d
docker compose ps
docker compose logs
```

Acesse **http://localhost:8080** para confirmar que o projeto está no ar.

### 1.4 Derrubar o ambiente

```bash
docker compose down
```

Faça isso antes de iniciar a próxima parte, para liberar a porta `8080`.

---

## 2. Exercício: MySQL com Docker Compose

Pasta [`mysql/`](mysql/). O arquivo `docker-compose.yml` sobe o MySQL 8.0 com o
banco `loja_bryan`, a porta `3306` e um volume nomeado para guardar os dados. O
`script.sql` é montado em `/scripts/script.sql` dentro do contêiner.

```bash
cd mysql
docker compose up -d
docker compose ps
docker compose logs
```

Aguarde a mensagem `ready for connections` nos logs. Depois, acesse o banco:

```bash
MSYS_NO_PATHCONV=1 docker exec -it mysql-bryan sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" loja_bryan'
```

Dentro do cliente MySQL, você pode digitar os comandos SQL manualmente ou
executar o script completo (cria a tabela `clientes_bryan`, insere dados e
consulta):

```bash
MSYS_NO_PATHCONV=1 docker exec -it mysql-bryan sh -c 'mysql -uroot -p"$MYSQL_ROOT_PASSWORD" < /scripts/script.sql'
```

Para encerrar:

```bash
docker compose down       # mantém os dados no volume
docker compose down -v    # remove também o volume com os dados
```

---

## 3. Exercício: MariaDB com Docker Compose

Pasta [`mariadb/`](mariadb/). Segue a mesma ideia, usando a imagem
`mariadb:10.11`, o cliente `mariadb` e a porta `3307` no computador (para não
conflitar com o MySQL na `3306`). A tabela criada é `produtos_bryan`.

```bash
cd mariadb
docker compose up -d
docker compose ps
docker compose logs

MSYS_NO_PATHCONV=1 docker exec -it mariadb-bryan sh -c 'mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" loja_bryan'
MSYS_NO_PATHCONV=1 docker exec -it mariadb-bryan sh -c 'mariadb -uroot -p"$MARIADB_ROOT_PASSWORD" < /scripts/script.sql'

docker compose down
```

> As senhas dos arquivos `docker-compose.yml` são apenas para este laboratório.
> Não use senhas fixas em projetos reais.

---

## Entrega

Reúna tudo em **um único arquivo PDF**, com prints de tela e explicações do
passo a passo, incluindo:

- o conteúdo de cada `docker-compose.yml`;
- os comandos SQL utilizados;
- os resultados das consultas;
- a página do item 1 aberta no navegador.

Envie o PDF na **Issue** da atividade neste repositório do GitHub, com a label
`atividade-docker-compose`.
