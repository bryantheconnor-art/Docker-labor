# Laboratório: Volumes e Docker Compose

**Autor:** Bryan da Silva  
**GitHub:** [@Bryantheconnor-art](https://github.com/Bryantheconnor-art)

Nesta aula, vamos aprender a compartilhar arquivos do Windows com o contêiner
usando **Volumes** e a gerenciar serviços de forma organizada com o
**Docker Compose**.

Neste laboratório, você vai servir arquivos locais com o Apache usando um
bind mount e depois repetir a experiência com Docker Compose.

## Pré-requisitos

- Docker Desktop instalado e em execução.
- Git Bash e um editor de código, como o VS Code.
- Docker Compose disponível pelo comando `docker compose`.

Confira o ambiente:

```bash
docker --version
docker compose version
```

---

## Conectando arquivos locais (Volumes)

Antes de ir para o Docker Compose, vamos entender como colocar um projeto real
(como um site do GitHub) dentro do Apache sem precisar criar uma imagem nova.

### 1. Preparar a pasta do projeto

No **Git Bash**, crie uma pasta simples na raiz do disco `C:` e coloque um
arquivo `index.html` dentro dela:

```bash
mkdir -p C:/meu-site
echo '<!doctype html><html lang="pt-BR"><meta charset="utf-8"><title>Meu site</title><h1>Meu Site no Docker!</h1><h2>nome-do-aluno</h2></html>' > C:/meu-site/index.html
```

Troque `nome-do-aluno` pelo seu nome.

### 2. Subir o Apache com Volume (`-v`)

Vamos mapear a pasta `C:/meu-site` do Windows para a pasta padrão onde o Apache
lê os arquivos do site (`/usr/local/apache2/htdocs/`):

```bash
docker run -d -p 8080:80 --name site-volume -v "C:/meu-site:/usr/local/apache2/htdocs/" httpd:alpine
```

> **Entendendo a flag `-v` (Volume):**
> * Funciona no formato `"PASTA_DO_WINDOWS:PASTA_DO_CONTAINER"`.
> * Tudo o que você editar na pasta `C:/meu-site` reflete **instantaneamente**
>   dentro do contêiner.
> * Esse mapeamento de uma pasta do computador é chamado de **bind mount**.

Acesse **http://localhost:8080** no navegador.

> *Dica:* se a página não atualizar de primeira, aperte `Ctrl + Shift + R`
> para limpar o cache.
>
> *Dica:* se o Git Bash converter o caminho e a pasta aparecer vazia no
> contêiner, rode o mesmo comando com `MSYS_NO_PATHCONV=1` antes de `docker run`.

Para conferir o contêiner e os logs:

```bash
docker ps
docker logs site-volume
```

### 3. Alterar o conteúdo do site

Abra `C:/meu-site/index.html` no editor de código e faça uma alteração
visível, como mudar o texto ou a cor do fundo. Salve o arquivo e atualize a
página no navegador para ver a mudança refletida.

### 4. Limpar o ambiente para o próximo passo

Antes de avançar, remova esse contêiner para liberar a porta `8080`:

```bash
docker rm -f site-volume
```

Isso não apaga os arquivos de `C:/meu-site`.

---

## Executar o site com Docker Compose

Esta versão inclui um site de exemplo na pasta `site/`. O arquivo
[`compose.yaml`](compose.yaml) conecta essa pasta ao diretório servido pelo
Apache. No Git Bash, a partir da pasta `versão 2`, valide e inicie o serviço:

```bash
docker compose config
docker compose up -d
docker compose ps
docker compose logs web
```

Abra **http://localhost:8080**. Edite [`site/index.html`](site/index.html),
salve e atualize o navegador para ver a mudança sem reconstruir a imagem.

O Compose usa um caminho relativo (`./site`), então o projeto pode ser movido
sem alterar o caminho do volume. Para parar e remover os recursos criados pelo
Compose:

```bash
docker compose down
```

O comando não remove os arquivos do site. Este laboratório não cria volumes
nomeados, portanto não é necessário usar `docker compose down -v`.

Se a porta 8080 já estiver ocupada, edite `ports` em `compose.yaml` para
`"8081:80"` e abra **http://localhost:8081**.

---

## Exercício: testando o Volume

1. Baixe um projeto HTML do GitHub e coloque-o em uma pasta local.
2. Suba um contêiner do Apache mapeando essa pasta (no `docker run` ou em
   `compose.yaml`).
3. Acesse o site no navegador.
4. Faça uma alteração bem visível no site.
5. Atualize a página no navegador e veja a mudança refletida.
6. Documente o passo a passo e tire prints da tela como evidência. Lembre-se de
   sempre personalizar o conteúdo do site e os nomes, como a pasta do projeto e
   o nome do contêiner.

---

## Arquivos

- [`README.md`](README.md): instruções do laboratório.
- [`comandos.sh`](comandos.sh): comandos de referência para executar um por vez no Git Bash.
- [`compose.yaml`](compose.yaml): configuração do serviço Apache e do bind mount.
- [`site/index.html`](site/index.html): página local servida pelo Compose.

---

*Laboratório prático de Docker — Bryan da Silva*
