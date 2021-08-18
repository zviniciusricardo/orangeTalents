# MySQL e databases

* DLL - Estrutura, tabelas, fk's, índices

* DDL - Manipulação (Select, update, delete, insert)

* DCL - acessos, users, grants, etc


## Características

Servidor
Portabilidade
Multithreads
Formas de Armazenamento
Logs
Segurança
Trabalha concorrência
Interplataforma ou independent platform


réplica de servidores -> shard?

### Instalação

		0) $- Download do arquivo .deb (para linux)
Baixe o arquivo .deb e salve num diretório

		1) $- sudo dpkg -i package-path/mysql-apt-config_0.8.18-1_all.deb // version
fazer as instalações do repositório com dpkg, o path do pacote .deb e a versao

		2) $- sudo apt-get install mysql-server
Usando o apt para gerenciar os pacotes e instalar as dependências

		3) $- sudo apt-get update
atualizando os pacotes

		4) $- systemctl status mysql
Cheque o status do mysql server

		5) $- sudo apt-get install mysql-workbench-community
instalação do workbench community

6) $- mysql -v --> abre o workbench

		7) $- sudo mysql_secure_installation
Abre o mysql server em modo visitante. Através daí, definimos senha e usuário

		8) $- mysql -u root -h localhost -p
Fazer login no banco com o usuário root, na porta local 3336 e com o password definido no script anterior

		9) $- dpkg -l | grep mysql | grep ii
Listar todos os pacotes do mysql

		10) root# - mysql
Em modo root, entre no monitor

		11) mysql> |
Dentro do monitor SQL Statements



### Help

		-$ mysqld --verbose --help
		
	or
		-$ mysqladmin variables	
		

<b> %\t% SEMPRE USAR PARA FUTURAS REFERÊNCIAS</b>


### Config files

* /etc/my.cnf
* /etc/mysql/my.cnf 
* ~/.my.cnf

### Estrutura do banco

grupos de tabelas = schemas
schemas = agrupar tabelas por assunto ou contexto
view = agrupamento de uma ou mais tabelas tratando os dados sensíveis
interface de uma querie

### Procedures

Lógica de negócios dentro do banco
Funções podem existir dentro de procedures

### Trigger
Aviso, controle, etc

### Configurations

		-$ systemctl status mysql

Dentro do monitor:

		-$ ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'new-password';

		$  sudo service mysql stop
		$  sudo service mysql start
		

#### informações auxiliares

Arquivos e tabelas gerados e salvos em disco

		my.ini >> dentro do source MYSQL
ou

		-$ mysqladmin variables >> procurar a variável "datadir"
		>> mostra o path do arquivo salvo em disco
		>> usa extensão .ibd

### Comandos do monitor

Para selecionar um banco de dados:

		-$ use database-name

Para sair do banco:

		-$ exit or CTRL+D



### Tipos de dados

#### Atributos dos campos numéricos:

		SIGNED ou UNSIGNED - Vai possuir ou não o sinal no numero alterando o armazenamento

		ZEROFILL - Preenche com zeros os espaços:
		ex: INT(4). Se armazenarmos o valor 5, será gravado 0005.

		AUTO_INCREMENT - Sequência auto incrementada


		obs: quando se estouram a capacidade dos valores
				ERR: OUT OF RANGE.

#### DATAS

		DATE - 1000-01-01 até 9999-12-31
		DATETIME - 1000-01-01 00:00:00 UTC ATÉ 2038-01-19 UTC
		TIME - -838:59:59 ATÉ 839:59:59
		YEAR - 1901 - 2155 (EXPRESSO EM 2 OU 4 DÍGITOS)























	
	

