# Docker e containers


Abordagem da VMware - virtualização HyperVisor
Vantagens --> vários systemas em um mesmo servidor
problemas --> varios sitemas operacionais --> consomem muito espaço, muito caro de manter e atualizar

Containers

São leves
Trabalham em cima de um único S.O

Controle fino do uso de recursos de cpu
25% 25% 50% 

Eles ficam presos e isolados um dos outros
O container encapsula a aplicação pra ela não conhecer nada e achar que está sozinha


Docker

dotCloud PaaS -- Platfor as a Service -- ( heroku - Microsof Azure )

Amazon --> web services
Docker -> arquitetura

ponte containers --> SOs

Ferramenta moderna de deploy e execução de aplicações

Docker compose
Orquestrar multiplos containers

Docker Swarm
Docker Hosts que trabalham juntos em cluster ( sistemas colaborativos integrados * )


Docker Hub - repositórios de imagens docker



		-$ docker run hello-world

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash


Nessa aula você:

conheceu a ideia de virtualização,
entendeu o conceito de containers,
descobriu o que é o Docker e suas principais tecnologias,
instalou o Docker no sistema operacional,
e o testou através de uma imagem Hello, World, que foi baixada do Docker Hub
Segue também uma breve lista dos comandos utilizados:

docker version - exibe a versão do docker.
docker run NOME_DA_IMAGEM - cria um container com a respectiva imagem passada como parâmetro.



## Passos docker run

* Procura a imagem no sistema. Se não, ele procura no dockerHub
* Baixa a imagem docker
* Imagem são receitas - séries de instruções
* Inicia a imagem

> Imagem oficial do Ubuntu, Nginx

<b>lista todos os containers, inclusive os parados.</b>

        docker ps -a

        docker run ubuntu

        docker run ubuntu echo "Hello world"

Configurar o terminal para ser o terminal do container

        docker run -it ubuntu

Agora estamos dentro do container
Posso usar os comandos do terminal com o filesystem do sistema que o container usa

Subir um container com meu terminal dentro

        docker start -a -i PID_CONTAINER

### Layered File System

Matar o container

        docker rm PID_CONTAINER

Matar todos:

        docker container prune [\Y]

Remover imagens

        docker rmi NOME_IMAGEM


Toda imagem é composta de mais de uma camada
Elas podem ser reaproveitadas em outras imagens

ex:CentOS aproveita camadas do Ubuntu

Toda imagem de container é READ ONLY
Quando escrevemos algo, escrevemos em um layer separado

Read/Write Layer

layers são formas de reaproveitar e desacoplar código
eles permitem o reaproveitamento de recursos entre imagens
Sistema mais leve, isolamento das partes, encapsulamento


### Containers para sites estáticos:

        docker run dockersamples/static-site
imagem de um mantenedor não oficial
precisa explicitar o nome dele antes
no caso, dockersamples

        docker run -d dockersamples/static-site // -d de 'Detached'

Configurar as portas do container com a porta do host (meu sistema)

        docker run -d -P dockersamples/static-site // -P de 'Porta'
obs: conecta o PC com o container por uma porta aleatória gerada
pelo Docker.

        docker port PID_CONTAINER

Descobrir id da máquina virtual

        Docker Toolbox Portas:
        docker-machine ip

Parar o container sem tempo de espera:        

        docker stop -t 0 PID_CONTAINER

Dar um nome para o container buildado (alias):

        docker run -d -P --name ALIAS_CONTAINER dockersamples/static-site

        docker stop ALIAS_CONTAINER

Escolher qual porta o docker irá "virtualizar"

        docker run -d -p 12345:80 // -p de Porta virtualizada para a :80

Setar variavel de ambiente

        docker run -d -P -e AUTHOR="Vini" dockersamples/static-site

Dois containers funcionando

        docker ps -q --> retorna todos os PIDs dos containeres

Concatenar comandos e parar containeres ativos por CLI:

        docker stop -t 0 $(docker ps -q) --> para todos os containeres mostrados nos parêntesis

qual comando deve utilizar para saber quais são as portas mapeadas?

        docker port PID_CONTAINER

DevOps é uma metodologia que visa integrar os times de desenvolvimento com infraestrutura e 
o Docker está tendo um papel importante nessa tarefa.

Repare que com Docker os desenvolvedores não precisam se preocupar em configurar um ambiente de desenvolvimento
específico de cada vez. Em vez disso, eles podem se concentrar na construção de um código de boa qualidade. 
Isso, obviamente, leva à aceleração nos esforços de desenvolvimento. O Docker facilita muito construir o ambiente:
é rapido, simples e confiável.

No outro lado, para a equipe de operações de TI/Sysadmins, o Docker possibilita configurar ambientes que são 
exatamente como um servidor de produção e permite que qualquer pessoa trabalhe no mesmo projeto com exatamente as
mesmas configurações, independentemente do ambiente de host local. As configurações são descritas em arquivos simples
facilmente aplicáveis pelo desenvolvedor.

Com a padronização de um entregável Docker é possível que o desenvolvedor tenha um ambiente similar ao de 
produção na sua máquina sem todo o custo de configuração e o Sysadmin consiga lidar apenas com um tipo de entregável
conseguindo, desta forma, dar atenção aos desafios de monitoramento e orquestração para que nada dê errado. 
Neste caso, o melhor para os dois.

Aprendemos neste capítulo:

- Comandos básicos do Docker para podermos baixar imagens e interagir com o container.
- Imagens do Docker possuem um sistema de arquivos em camadas (Layered File System) e os benefícios dessa abordagem 
principalmente para o download de novas imagens.
- Imagens são Read-Only sempre (apenas para leitura)
- Containers representam uma instância de uma imagem
- Como imagens são Read-Only os containers criam nova camada (layer) para guardar as alterações
- O comando Docker run e as possibilidades de execução de um container

Segue também uma breve lista dos comandos utilizados:

* <b>docker ps</b> - exibe todos os containers em execução no momento.
* <b>docker ps -a</b> - exibe todos os containers, independentemente de estarem em execução ou não.
* <b>docker run -it NOME_DA_IMAGEM</b> - conecta o terminal que estamos utilizando com o do container.
* <b>docker start ID_CONTAINER</b> - inicia o container com id em questão.
* <b>docker stop ID_CONTAINER</b> - interrompe o container com id em questão.
* <b>docker start -a -i ID_CONTAINER</b> - inicia o container com id em questão e integra os terminais, além de permitir interação entre ambos.
* <b>docker rm ID_CONTAINER</b> - remove o container com id em questão.
* <b>docker container prune</b> - remove todos os containers que estão parados.
* <b>docker rmi NOME_DA_IMAGEM</b> - remove a imagem passada como parâmetro.
* <b>docker run -d -P --name NOME dockersamples/static-site</b> - ao executar, dá um nome ao container.
* <b>docker run -d -p 12345:80 dockersamples/static-site</b> - define uma porta específica para ser atribuída à porta 80 do container, neste caso 12345.
* <b>docker run -d -P -e AUTHOR="Fulano" dockersamples/static-site</b> - define uma variável de ambiente AUTHOR com o valor Fulano no container criado.

## Volumes:

Relembrando
Containers são pequenas camadas de Read and Wright
Quando removo o container docker rm, pra onde vão os dados, logs, código?

Nos volumes
		
        /var/www --> DockerHost

symlink para um docker host		
Os dados são persistidos e não são removidos junto com o volume
Podemos especificar um local virtual onde os dados serão salvos
Eles ficam salvos localmente ou onde nós quisermos e é visto como
estando dentro do container

#### Criando um volume

usando a flag -v seguindo pelo CAMINHO_HOST:CAMINHO_CONTAINER

		docker run -v "/var/www" ubuntu
		docker ps -a
		docker inspect --> informações sobre o container (olher o mout) especificação do volume
		docker container prune
		a pasta continua em "/var/www"

		docker run -it -v "~./Desktop/projects/pizzaria" ubuntu

> obs: o volume fica no Docker Host. Ou seja, fica salvo no computador onde a Docker Engine está rodando.


## Rodando código dentro do container

		docker run -p -d 8080:3000 -v "home/viniciusferreira/Desktop/valume-docker:/var/www" -w "/var/www" mvn -Dspring-boot:run

obs: 	-w é de working directory
		-d é para não travar o terminal
		
		docker run -d -p 8080:3000 -v "$(pwd):/var/www" -w "/var/www" mvn -Dspring-boot:run

obs: 	$(pwd) é uma variável que indica onde o usuário está no momento em que executa o comando

		
## Construindo as próprias imagens:
#### Dockerfile


<b>Nome no projeto:</b>
		
		Dockerfile
		java.dockerfile
		
<b>Estrutura Dockerfile:</b>
		
		FROM open-jdk:latest or "$VERSION" 	// última versão ou versão especificada
		MAINTAINER dono da imagem 			// mantenedor da imagem
		COPY . /var/www						// nossos arquivos que serão copiados para dentro do container
		WORKDIR /var/www					// diretório (volume) do container onde daremos nosso primeiro comando
		RUN java -jar MeuArquivo etc etc	// especifique o primeiro comando ao iniciar
		ENTRYPOINT ["mvn spring-boot:run", "fazer aquilo"]	
		EXPOSE $PORT
		
		//variáveis de ambiente
		
		ENV PORT=3000
		ENV NODE_ENV=production

	
		docker build -f Dockerfile

Cada build do docker tem um ID
Cada passo ele cria um container intermediário
Camadas criam uma imagem final
Cada Dockerfile é unico
		
Para criar a imagem, precisamos fazer o seu build através do comando docker build, comando utilizado para buildar uma imagem a partir de um Dockerfile. Para configurar esse comando, passamos o nome do Dockerfile através da flag -f:

		viniciusferreira@ZUP-7979:~/Desktop/volume-exemplo$ docker build -f Dockerfile
		viniciusferreira@ZUP-7979:/home/viniciusferreira/Desktop/volume-exemplo$ docker build -f Dockerfile

Além disso, passamos a tag da imagem, o seu nome, através da flag -t. Já vimos que para imagens não-oficiais, colocamos o nome no padrão NOME_DO_USUARIO/NOME_DA_IMAGEM

		docker build -f Dockerfile -t douglasq/node .
		docker run -d -p 8080:3000 douglasq/node



### Criando imagens o dockerhub

		docker login
		Username: ovnny
		Password: *************
		
		docker push ovnny/open-jdk

Guilherme Nicolau recebeu as seguintes instruções para criação de um docker container:

Deve instalar o mysql da última imagem disponível
Os dados iniciais devem ser copiados para a pasta /etc/sinc
O diretório de trabalho deve ser /etc/sinc/plen
A porta de comunicação deve ser 1711
O comando de entrada chmod 755 /etc/sinc


		FROM mysql:latest
		MAINTAINER Guilherme Nicolau
		COPY . /etc/sinc
		WORKDIR /etc/sinc/plen
		ENTRYPOINT chmod 755 /etc/sinc
		EXPOSE 1711

Aprendemos neste capítulo:

A entender o papel do arquivo DockerFile para criar imagens.
O Dockerfile define os comandos para executar instalações complexas e com características específicas.
Vimos os principais comandos como FROM, MAINTAINER, COPY, WORKDIR, RUN, EXPOSE e ENTRYPOINT
A subir uma imagem criada através de um Dockerfile para o Docker Hub e disponibilizar para os desenvolvedores
Lembrando também:

as imagens são read-only sempre
um container é uma instância de uma imagem
para guardar as alterações a docker engine cria uma nova layer em cima da última layer da imagem
Segue também uma breve lista dos comandos utilizados:

docker build -f Dockerfile - cria uma imagem a partir de um Dockerfile.
docker build -f CAMINHO_DOCKERFILE/Dockerfile -t NOME_USUARIO/NOME_IMAGEM - constrói e nomeia uma imagem não-oficial informando o caminho para o Dockerfile.
docker login - inicia o processo de login no Docker Hub.
docker push NOME_USUARIO/NOME_IMAGEM - envia a imagem criada para o Docker Hub.
docker pull NOME_USUARIO/NOME_IMAGEM - baixa a imagem desejada do Docker Hub.


## Conectando Múltiplos containers

img salva 

img salva

uma aplicação rodando em cada container. 
banco de dados | código | serviços


Network settings:

		hostname -i 
		172.17.0.2
		
		docker inspect NOME_CONTAINER

Verificar as informações de networking no json
Por padrão, o docker cria uma rede padrão onde os containeres possam se comunicar. 

A comunicação é feita por IP

Se quiser um domainNetworkService (DNS) precisamos criar uma rede

		docker network create --driver bridge minha_rede

		docker run -it --name ubuntu1 --network minha_rede ubuntu
		
		apt-get update && apt-get install iputils-ping
		
		docker run -it --name ubuntu2 --network minha_rede ubuntu
		
		do ubuntu2  	-->		ping ubuntu1
		do ubuntu1		--> 	ping ubuntu2

			
		64 bytes from ubuntu2.ubuntu-net (172.19.0.3): icmp_seq=173 ttl=64 time=0.109 ms
		64 bytes from ubuntu2.ubuntu-net (172.19.0.3): icmp_seq=174 ttl=64 time=0.108 ms
		^C
		--- ubuntu2 ping statistics ---
		174 packets transmitted, 174 received, 0% packet loss, time 177142ms
		rtt min/avg/max/mdev = 0.034/0.118/0.194/0.016 ms
		

##Baixando imagens docker

		docker pull ubuntu
		docker pull NOME_USUARIO/NOME_IMAGEN
		

Neste capítulo aprendemos:

Que imagens criadas pelo Docker acessam a mesma rede, porém apenas através de IP.
Ao criar uma rede é possível realizar a comunicação entre os containers através do seu nome.
Que durante a criação de uma rede precisamos indicar qual driver utilizaremos, geralmente, o driver bridge.
Segue também uma breve lista dos comandos utilizados:

hostname -i - mostra o ip atribuído ao container pelo docker (funciona apenas dentro do container).
docker network create --driver bridge NOME_DA_REDE - cria uma rede especificando o driver desejado.
docker run -it --name NOME_CONTAINER --network NOME_DA_REDE NOME_IMAGEM - cria um container especificando seu nome e qual rede deverá ser usada.



## Docker Compose
#### Gerenciando múltiplos containers


Evitar repetição de comandos e erro humano
Automatização de configurações de rede, de aplicações, etc


Uma aplicação geralmente possui várias instâncias de imagens para dividir a carga

Uma para o banco, uma para um serviço, outra pra um serviço de mensageria, etc

Nginx é um Load Balancer para distribuir carga
Nginx tmb é usado para servir arquivos estáticos (html, css, js)
recebe a requisição e gerencia (delega) para um container (aplicação)
As aplicações podem dividir um ou mais bancos de dados


#### Usando o compose

Orquestrador simples
Arquivo de texto
Descrição para subir a aplicação

passo a passo/ receita

		docker-compose.yml

		version: '3'
services:
  nginx:
    build:
      dockerfile: ./docker/nginx.dockerfile
      context: .
    image: douglasq/nginx
    container_name: nginx
    port:
      - "80:80"
      - "1234:3000"
    networks: 
      - production
  
  mongodb:
    image: mongo
    networks:
      - production-network
  
  node1:
    build:
      dockerfile: ./docker/alura-books.dockerfile
      context: .
    image: douglasq/alura-books
    container_name: alura-books1
    port:
      - "3000"
    networks: 
      - production-network
  
  node2:
    build:
      dockerfile: ./docker/alura-books.dockerfile
      context: .
    image: douglasq/alura-books
    container_name: alura-books1
    port:
      - "3000"
    networks: 
      - production-network
  
  node3:
    build:
      dockerfile: ./docker/alura-books.dockerfile
      context: .
    image: douglasq/alura-books
    container_name: alura-books1
    port:
      - "3000"
    networks: 
      - production-network

	networks: 
  		production-networks:
    		driver: bridge
		

#### Instalando o DockerCompose

		sudo curl -L https://github.com/docker/compose/releases/download/1.15.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose	
		
		sudo chmod +x /usr/local/bin/docker-compose	
		
		
## Docker Swarm

Ok, tudo bem até aqui. Agora vou ter vários serviços rodando usando o Docker. E para facilitar a criação desses containers já aprendemos usar o Docker Compose que sabe subir vários containers. O Docker Compose é a ferramenta ideal para coordenar a criação dos containers, no entanto para melhorar a escalabilidade e desempenho pode ser necessário criar muito mais containers para um serviço específico. Em outras palavras, agora gostaríamos de criar muitos containers aproveitando várias máquinas (virtuais ou físicas)! Ou seja, pode ser que um microsserviço fique rodando em 20 containers usando três máquinas físicas diferentes. Como podemos facilmente subir e parar esses containers? Repare que o Docker Compose não é para isso e por isso existe uma outra ferramenta que se chama Docker Swarm (que não faz parte do escopo desse curso).

Docker Swarm facilita a criação e administração de um cluster de containers.


Nessa aula aprendemos:

A necessidade de usar o Docker Compose
Configurar o build de vários containers através do docker-compose.yml
subir e parar os containers de maneira coordenada com Docker Compose
Segue também uma breve lista dos novos comandos utilizados:

docker-compose up - sobe os serviços criados
docker-compose down - para os serviços criados.
docker-compose ps - lista os serviços que estão rodando.
docker exec -it alura-books-1 ping node2- executa o comando ping node2 dentro do container alura-books-1

	
Segue a lista com os principais comandos utilizados durante o curso:

Comandos relacionados às informações
docker version - exibe a versão do docker que está instalada.
docker inspect ID_CONTAINER - retorna diversas informações sobre o container.
docker ps - exibe todos os containers em execução no momento.
docker ps -a - exibe todos os containers, independentemente de estarem em execução ou não.
Comandos relacionados à execução
docker run NOME_DA_IMAGEM - cria um container com a respectiva imagem passada como parâmetro.
docker run -it NOME_DA_IMAGEM - conecta o terminal que estamos utilizando com o do container.
docker run -d -P --name NOME dockersamples/static-site - ao executar, dá um nome ao container e define uma porta aleatória.
docker run -d -p 12345:80 dockersamples/static-site - define uma porta específica para ser atribuída à porta 80 do container, neste caso 12345.
docker run -v "CAMINHO_VOLUME" NOME_DA_IMAGEM - cria um volume no respectivo caminho do container.
docker run -it --name NOME_CONTAINER --network NOME_DA_REDE NOME_IMAGEM - cria um container especificando seu nome e qual rede deverá ser usada.
Comandos relacionados à inicialização/interrupção
docker start ID_CONTAINER - inicia o container com id em questão.
docker start -a -i ID_CONTAINER - inicia o container com id em questão e integra os terminais, além de permitir interação entre ambos.
docker stop ID_CONTAINER - interrompe o container com id em questão.
Comandos relacionados à remoção
docker rm ID_CONTAINER - remove o container com id em questão.
docker container prune - remove todos os containers que estão parados.
docker rmi NOME_DA_IMAGEM - remove a imagem passada como parâmetro.
Comandos relacionados à construção de Dockerfile
docker build -f Dockerfile - cria uma imagem a partir de um Dockerfile.
docker build -f Dockerfile -t NOME_USUARIO/NOME_IMAGEM - constrói e nomeia uma imagem não-oficial.
docker build -f Dockerfile -t NOME_USUARIO/NOME_IMAGEM CAMINHO_DOCKERFILE - constrói e nomeia uma imagem não-oficial informando o caminho para o Dockerfile.
Comandos relacionados ao Docker Hub
docker login - inicia o processo de login no Docker Hub.
docker push NOME_USUARIO/NOME_IMAGEM - envia a imagem criada para o Docker Hub.
docker pull NOME_USUARIO/NOME_IMAGEM - baixa a imagem desejada do Docker Hub.
Comandos relacionados à rede

hostname -i - mostra o ip atribuído ao container pelo docker (funciona apenas dentro do container).
docker network create --driver bridge NOME_DA_REDE - cria uma rede especificando o driver desejado.
Comandos relacionados ao docker-compose

docker-compose build - Realiza o build dos serviços relacionados ao arquivo docker-compose.yml, assim como verifica a sua sintaxe.
docker-compose up - Sobe todos os containers relacionados ao docker-compose, desde que o build já tenha sido executado.
docker-compose down - Para todos os serviços em execução que estejam relacionados ao arquivo docker-compose.yml.		
		
## Formulário de proposta de solução		
		
<b>Imagens referentes a cada aplicação </b>

		Casa do Código | Mercado Livre

* db para cada um
* o que você faria para garantir a existência do banco de dados no momento da criação dos contêineres a partir das imagens criadas?

* Lembrando que ambas as aplicações estão configuradas para utilizarem a porta 8080, existe algum problema ao subir contêineres de ambas as imagens criadas ao mesmo tempo?

* E como você faria para executar as imagens criadas?		
		
		
Primeiramente eu faria o build das aplicações spring (Casa do Código e Mercado Livre)
Isso feito, eu buscaria uma imagem da openjdk no DockerHub

		-$ docker pull adoptopenjdk/maven-openjdk11:latest

Depois eu faria o dowload do docker-compose para criar um docker-compose.yml
Mas primeiro, preciso montar os dockerfiles das minhas aplicações e dos bancos de dados.
Em um arquivo, eu configuraria a imagem da Casa do Código para usar o openjdk11, com um volume localizado
na pasta /public/api.

		COPY . /var/www
		WORKDIR /var/www/public/api

Também executarei o comando mvn clean install 
No entrypoint: mvn -Dspring-boot:run assim que meu container iniciar
a porta escolhida seria a 8080


A mesma coisa seria feita com o dockerfile do Mercado Livre. Inclusive, cada container é único,
então não faz diferença configurarmos todos usando a mesma porta (porta especificada) se cada 
aplicação roda em um único container isolado.

Para os dockerfiles do mysql, baixamos a imagem

		docker pull mysql:latest
		
Montamos o volume:

		COPY . /var/www
		WORKDIR /var/www/private/mysql

precisarei fazer as configurações referentes ao acesso ao banco como usuário, senha, porta utilizada, etc
Podemos configurar um script de inicialização no banco que pode se comunicar com nossa aplicação e vice-versa
enviando um dado ou exibindo um log.
Podemos também rodar scripts SQL para melhorar a indenpotência da aplicação.

Dockerfiles configurados, agora podemos montar nosso docker-compose.yml
Após configurarmos todas os containeres, precisamos configurar uma rede personalizada para que eles possam
se comunicar.

Monto meu docker-compose e depois digito docker-compose build para construir as instâncias e baixar as imagens

depois dou um docker-compose up para subir a aplicação

obs: na configuração dos bancos de dados, posso passar variáveis de ambiente como parâmetros para representar
nome, senha, etc, como tmb nas minhas aplicações Java.


O que seria bom ver nessa resposta?



Peso 5: Criação dos arquivos Dockerfile de cada uma das aplicações
Peso 3: Criação do docker-compose.yml para orquestrar a subida da aplicação e do banco de dados
Peso 2: Mapeamento das portas das aplicações nos contêineres para as portas do host


Resposta do Especialista:

Objetivo de aprendizado: Configurar as imagens docker das aplicações desenvolvidas através do Dockerfile e orquestrar o build e execução delas através do docker-compose.yml
Motivo da escolha: Através do Dockerfile configuro como serão as imagens criadas para cada uma das aplicações e utilizo o docker-compose para orquestrar a execução dessas imagens com os bancos de dados necessários para cada aplicação.
Crio o Dockerfile de cada uma das aplicações para definir como serão geradas as imagens das mesmas
Para cada uma das aplicações também crio um arquivo docker-compose.yml, onde defino uma sessão de configuração do container da aplicação, mapeando o Dockerfile criado anteriormente, e uma sessão para o banco de dados a ser utilizado pela aplicação
Uma vez que cada aplicação estará isolada em seu próprio contêiner, não há problema se as mesmas utilizarem a mesma porta. Porém a porta do host deverá ser mapeada para garantir acesso a aplicação: em cada um dos Dockerfiles mapeio as portas do host:contêiner (8081:8080 para Casa do Código e 8082:8080 para Mercado Livre, por exemplo).


		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		













		
		
		
		
		
		
		
		









