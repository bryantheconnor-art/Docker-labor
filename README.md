# Docker-labor
beggin studies with Docker - Bryan da Silva :3
# Laboratório: Contêineres com Docker

**Autor:** Bryan da Silva  
**GitHub:** [@Bryantheconnor-art](https://github.com/Bryantheconnor-art)

Guia prático para aprender a baixar imagens, iniciar um contêiner Apache e
gerenciar seu ciclo de vida com Docker.

## Pré-requisitos

- Docker Desktop no Windows ou macOS, ou Docker Engine no Linux, instalado e em execução.
- Git instalado.
- Um terminal e um editor de código, como o VS Code.

## 1. Verificar o ambiente

No Windows, verifique se o WSL está disponível (quando aplicável) e confira a
versão do Docker. O comando `wsl --version` deve ser executado no PowerShell ou
no Prompt de Comando:

```powershell
wsl --version
docker --version
docker run hello-world
```

`hello-world` baixa uma imagem de teste e inicia um contêiner para confirmar que
o Docker está funcionando.

## 2. Consultar imagens e contêineres

```bash
docker images
docker ps
```

`docker ps` lista os contêineres em execução. Para incluir os que estão parados:

```bash
docker ps -a
```

## 3. Iniciar o servidor Apache

```bash
docker run -d -p 8080:80 --name meu-apache httpd:alpine
```

- `-d`: executa em segundo plano.
- `-p 8080:80`: encaminha a porta 8080 do computador para a porta 80 do contêiner.
- `--name meu-apache`: define um nome para o contêiner.
- `httpd:alpine`: usa a imagem Apache HTTP Server baseada em Alpine Linux.

Abra [http://localhost:8080](http://localhost:8080) no navegador.

> Se a porta 8080 já estiver ocupada, escolha outra porta para o computador,
> por exemplo `-p 8081:80`, e acesse `http://localhost:8081`.

## 4. Gerenciar o contêiner

```bash
docker ps
docker logs meu-apache
docker stop meu-apache
docker start meu-apache
```

Para remover somente o contêiner deste exercício:

```bash
docker rm -f meu-apache
```

## Limpeza: atenção

O comando abaixo remove **todos os contêineres parados** do Docker no computador.
Confira antes se não há contêineres que você queira manter:

```bash
docker container prune
```

O comando `docker rm -f $(docker ps -aq)` remove todos os contêineres, inclusive
os que estão em execução. Ele não é necessário para este laboratório e foi
omitido do arquivo de comandos para evitar uma remoção acidental.

## Arquivos do repositório

- [README.md](README.md): este guia.
- [comandos.sh](comandos.sh): referência dos comandos para copiar e executar um por vez em Bash.

## Publicar no GitHub

Coloque `README.md` e `comandos.sh` na pasta do repositório e envie as alterações
com o Git ou pela interface do GitHub. O `README.md` aparecerá automaticamente
na página inicial do repositório.

---

*Laboratório prático de Docker — Bryan da Silva*
