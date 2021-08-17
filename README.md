# Orange Talents 8
### <i>(ao infinito e além)</i>

## Considerações iniciais:

	Esse documento será usado como referência em todo o projeto, devendo ser tratado como
    mais um asset e recurso da empreitada e projeto de vida Zup Innovation IT.

    obs: Converse o tempo todo com os stakeholders do seu projeto.

#### Informações importantes:

* média de 3 dias e 18h (3.75 dias) para cada curso
* equivale à 30 horas para cada curso trabalhando 8h/dia
* média de 2 cursos por semana


    início: 09/08   término: 02/11 
    
    DIAS: 91        Alura: 240h 
    SEMANAS: 13     OrangeT: 728h
    
    2h de conteúdo 6h de prática
    obs: proporção de 3 pra 1

#### OBJETIVO:

* 2 CURSOS POR SEMANA (MÉDIA)
* DESEMBOLAR NA PARTE DE DATABASES

#### ESTRATÉGIA:
* CONVERSAR COM OS COLEGAS E PEGAR IDEIAS DELES
* ANOTAR TODAS AS DÚVIDAS EM UM DOCUMENTO E APRESENTAR NO CHECK-IN DIÁRIO
* APROVEITAR O CHECK-OUT PARA FAZER AUTO-AVALIAÇÃO E PLANEJAMENTO DO PRÓXIMO DIA
* TENTAR PEDIR UM 1 O 1 AO MENOS UMA VEZ POR SEMANA

### Mentores ZUP EDU
* @Yuri Matheus
* @Cassio Dos Santos Almeida
* @Rafael Ponte
* @Leonardo Silva dos Santos
* @Alefh Sousa e Silva

### Mentora Guardiã
<b>@Paula Macedo Santana</b>

    Ela será a referência de vcs para todas as questões de conteúdo do programa, dúvidas.
    Nem sempre ela será a mentora que dará determinado conteúdo, mas ela será a referência
    técnica para vocês se apoiarem!

### PM Guardiã
<b>@Paula Nunes</b>

    Papel é apoiar vocês durante toda a jornada no programa para garantir a melhor experiência
    e todo apoio que vocês precisarem. Seja emocional, psicológico, de dúvidas sobre onde enviar
    isso, aquilo, enfim...

### Pesquisa e BI
<b>@Danilo Monteiro Ribeiro</b>

	O Dan vai acompanhar para entender os dados gerados, transformá-los em informações 
    relevantes, baseadas em dados científicos para garantir que vocês estejam calibrados e se
    desenvolvam da melhor maneira possível.


## Início dos Trabalhos

### Fase 1

* Aprendendo a aprender
* Planejamento de estudos
* Análise da complexidade do problema
* Definição de estratégia
* Adaptabilidade e auto regulação
* Accoutability

___________________________________________________________________________

### Fase 2

[1- Java Servlet: Fundamentos da programação web Java!](https://github.com/zviniciusricardo/orangeTalents/tree/main/curso1_servlets "Java EE com Eclipse e servlets")				10h

#### Primeiros passos

1) A partir do Eclipse IDE, criar um Dinamic Web Project
2) Fazer download do servidor Tomcat
3) Na página inicial da IDE, crie um novo projeto com o nome gerenciador
4) configurações:
Tomcat 9, JRE default (do sistema) e arquivo web.xml
5) No diretório webapp irão arquivos estáticos (páginas html e recursos como jpg, png, videos, etc)
6) Dentro de gerenciador/src/main/java irão nossas classes (context root)
7) Configurar o projeto para que ele reconheça o Tomcat - definir a pasta onde o Tomcat está e algumas
configurações


#### Criando servlets

1) Criar uma classe que extends HttpServlet
2) Anotation @WebServlet(urlPatterns="/meu-endpoint")
3) Usar a classe PrintWriter (Java I/O) para gerar html dinamicamente.
4) usar o método .getWriter() da Classe PrintWriter para capturar o html gerado por nós
de maneira estática ou dinâmica.
5) Usar o prinln para mostrar a mensagem capturada no browser

#### Estrutura de requisições http	

		protocolo://ip:porta/contexto/recurso


MONTANDO UMA REQUISIÇÃO DO TIPO POST MANUALMENTE

		http://localhost:8080/gerenciador/novaEmpresa?nome=Alura
		
				context root + endpoint + service parameter + type + parameter
						
### Métodos HttpServlet

request.getParameter("nome") --> obtém o parâmetro digitado na url pelo user
response.getWriter() --> responde (printa) no browser a resposta do servidor para o usuário

		obs: Alternativa correta! O método req.getParameter(..) sempre retorna uma string e recebe
		como parâmetro o nome do parâmetro recebido na requisição.
		
		
#### Porq o dispatcher deve ser pela request e não pela response?

		Mantém o fluxo http --> mais barato --> continua dentro de servidor e é redirecionamento.


		requestDispatcher --> é um pedido a partir do pedido do HTTP request.
		sobrescrita de método só com herança
		O Dispatcher é um objeto --> adquire através do request q é do tipo HttpServletRequest
		método do tipo response = sendRedirect


#### observações da Alana:

		Servlet -> 	o nome do inglês significa um servidor(serv) pequeno (let). Recebe,
		processa e responde as requisições HTTP.

		HTTP 	->  HTTP é o protocolo responsável pela comunicação de sites na web. 
		As requisições HTTP são mensagens enviadas pelo cliente para iniciar uma ação no servidor.

		POST 	-> os dados são enviados no corpo da requisição, escondidos da URI. É usado 
		normalmente para enviar informações.
 
		GET 	-> os dados são enviados no cabeçalho da requisição, podendo ser vistos pela
		URI. É usado normalmente para obter dados.

		IOC 	-> or Inversion Of Control, é uma forma que temos para manipular o controle
		sobre um objeto. No caso do projeto realizado no curso, o método main() é quem instanciava
		os objetos, mas quem realiza esse processo era o Tomcat.



#### Observações checkIn OT (@Paula Macedo)

		1- Se você tiver usando o Eclipse, ao deletar um projeto ou server pode ser que ele ainda permaneça 
		na pasta Workspace e então ao criar um projeto com o mesmo nome ou servidor ele pegue as mesmas 
		configurações do que esta na pasta e você ache estranho que seu projeto ou servidor não mudou . 
		Então não esqueçam de deletar da pasta/ workspace.

		2- Se vocês decidirem não usar o workspace e usar um diretório diferente, para importar o projeto 
		o caminho é File> import > existing projects into workspace e escolham sua pasta.

		3- A versão mais atual do Tomcat ainda esta em teste então o melhor mesmo é usar o TomCat 9 e a
		versão da Jstl não precisa ser a citada pelo professor no curso, use uma versão compatível com o
		Tomcat 9 , pode ser a do Jakarta EE também, mas lembrando que o caminho dos imports mudaram nas 
		versões do Jakarta EE.


#### Observações Antonio Martins

#### Tomcat(puro em java) servidor web java

* HTML
* HTTP 
* Gera HTML dinamicamente usando Java e JSP (JSP - Podemos ao invés de utilizar HTML 
para desenvolver páginas Web estáticas e sem funcionalidade, utilizar o JSP para criar 
dinamismo. É possível escrever HTML com códigos JSP embutidos.)

#### Requisição 
	
* navegador manda a requisição(request) para o servidor tomcat e nos devolve(response) nosso conteudo .html
	
### Servlet 

* classe que contém alguma logica algo programavel para retornar uma resposta http
* Escrever uma classe que tenha um objeto que tenha a logica de ir no banco de dados buscar 
informações e expor via http em formato dinamico 
* Uma servlet é um objeto Java que podemos chamar a partir de uma requisição HTTP
* Para mapear a URL para uma servlet usamos a anotação @WebServlet
* Uma servlet deve estender a classe HttpServlet e sobrescrever um determinado método
(por exemplo service)
* Usamos o RequestDispatcher para chamar um JSP a partir da servlet
* Obtemos o RequestDispatcher a partir do HttpServletRequest
* Usamos a requisição para colocar ou pegar um atributo (setAttribute(.., ..) ou getAttribute(..))
* Servlet é um objeto que podemos chamar atraves do protocolo HTTP(navegador) quem possibilita é 
o tomcat.
* podemos mandar um requisição para o tomcat para executar o objeto do servlet 
* Servlet é um objeto que pode ser acionado por meio de uma requisição do protocolo HTTP 
obs: quem instancia o objeto é o server tomcat 

### Redirecionamento de fluxo

* O RequestDispatcher delega o fluxo da requisição para qualquer recurso disponível.
* Pode chamar qualquer recurso acessível pela URL (uma página HTML, CSS, JavaScript, Servlet ou JSP).

### Considerações finais sobre scriptlets:

* JSP significa Java Server Pages
* JSP é uma página automaticamente processada pelo Tomcat
* Para gerar HTML dinamicamente no JSP usamos Scriptlets
* Um scriptlet <% %> é um código Java dentro do HTML
* Um scriptlet só funciona em uma página JSP
* Usamos o RequestDispatcher para chamar um JSP a partir da servlet
* Obtemos o RequestDispatcher a partir do HttpServletRequest
* Usamos a requisição para colocar ou pegar um atributo (setAttribute(.., ..) ou getAttribute(..))

### Problemas com scriplets

* Quando o html é muito grande, a manutenção se torna inviável
* Desse problema surge a sintaxe ${ } chamada expression language
* Ela procura dentro das requisições e procura pelo nome declarado dentro dela
	ex: ${ myVariable }
* Simplificando a sintaxe de scriplet <% %> por ${ }
	obs: não dá pra fazer laço for dentro dessa expression language

### Soluções

Baixar a biblioteca JSTL (jstl.jar) Apache Standard Taglib
Copiar a biblioteca e colar dentro da pasta WEB-INF/lib
Fazer um import <%@ taglib <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> no header

		items = variável definada em setAttribute do servlet
		var = variável definida para o for loop
		
JSTL (Java Standarfd Tag Library)
 * core - controle de fluxo
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c"%>

 * fmt - formatação/i18n (internacionalização de datas, numeros, etc)
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt"%>

 * sql - executar SQL
 
 * xml - gerar XML
 
 
### Context Root

Escrever o nome do contexto no arquivo JSP não é uma boa prática, uma vez que ele pode variar e gerar problemas em outras páginas. Para lidarmos com esse fluxo dinâmico, usaremos a biblioteca Taglib, mais especificamente, a tag <c:url />. Nela, inseriremos o atributo value, e, em seguida, iremos inserir um único caminho possível para chegar até o Servlet.

### Dispatcher

Serve para redirecionar um servlet para outro servlet.

Precisa usar o método service ao invés de doGet ou doPost

No servlet que fará o redirecionamento, colocar o endereço do outro Servlet.

obs: o RequestDispatcher pode delegar o fluxo da requisição para qualquer recurso disponível. (html, css, servlet, javaScript, etc).

### Redirecionamento Client Side

* É quando o servlet é configurado para responder imediatamente o cliente mas passando a responsabilidade pra ele (o Cliente) de fazer uma nova requisição para a página resultante do redirecionamento.

* Qual o problema de reenviar uma requisição?
* Qual a diferença entre redirecionamento pelo cliente e servidor?

		obs: para redirecionar pelo navegador usamos o método response.sendRedirect("endereço")
		o código de resposta para redirecionamento HTTP é 30X (301 ou 302)

### CRUD on Servlets

* Create


* Read


* Update


* Delete


### Deploy

No arquivo de especificação web.xml dentro de WEB-INF

Definir configurações globais e comportamentos

		<welcome-file-list>
			<welcome-file>index.html<welcome-file>
		<welcome-file-list>
		
		<servlet>
			<servlet-name>ClassServletName<servlet-name>
			<servlet-class>br.com.package.servlet.servletClass<servlet-class>
		<servlet>
		
		<servlet-mapping>
			<servlet-name>ClassServletName<servlet-name>
			<url-pattern>/some-address<url-pattern>
		<servlet-mapping>
		
* Configurações podem ser feitas de duas formas, uma na @WebServlet e outra via xml.
* Através da anotação @WebServlet podemos definir mais do que uma URL para chamar o servlet, por exemplo:

		@WebServlet(urlPatterns= {"/listaEmpresas", "/empresas"})
		public class ListaEmpresasServlet extends HttpServlet {
					ou
		<servlet>
			<servlet-name>LES</servlet-name>
			<servlet-class>br.com.alura.gerenciador.servlet.ListaEmpresasServlet</servlet-class>
		</servlet>

		<servlet-mapping>
			<servlet-name>LES</servlet-name>
			<url-pattern>/listaEmpresas</url-pattern>
		</servlet-mapping>

		<servlet-mapping>
			<servlet-name>LES</servlet-name>
			<url-pattern>/empresas</url-pattern>
		</servlet-mapping>

O que aprendemos sobre servlet?
É um objeto que pode ser invocado via HTTP via Tomcat
Nossa aplicação não possui um método main
Quem chama a classe inicializadora é o Tomcat(Servlet Container)
Tomcat é um middleware
Tomcat é Lazy loader				
Quando instanciado o Tomcat deixa o objeto (servlet) em memória
Só há uma instância de cada servlet (Singletom)
Um singletom uma vez instanciado, vive pra sempre
Tomcat usa Inversion of Control


Mudando o comportamento Lazy loader:

A anotação @WebServlet possui um atributo loadOnStartup que muda esse comportamento:

		@WebServlet(urlPatterns="/oi", loadOnStartup=1)
		public class OiMundoServlet extends HttpServlet {


			public OiMundoServlet() {
				System.out.println("Criando Oi Mundo Servlet");
			}

			@Override
			protected void service(HttpServletRequest req, HttpServletResponse resp) 
				throws IOException {

				//implementacao do metodo service omitida
			}
		}

Criando um arquivo .war para deploy da aplicação no servidor de produção

WAR é o ZIP de projetos Java Web, que você roda de dentro de um servidor como o Tomcat.
JAR é o ZIP para projetos comuns, que não são Web.

JAR e WAR são nada mais do que arquivos ZIP, no entanto um WAR possui os arquivos do mundo web
como imagens, CSS, JS, JSP e HTML.


PASSO A PASSO DEPLOY:
1. Instalar uma nova instância do Tomcat num diretório diferente (ou num servidor, nuvem, domínio, etc)
2. Criar um arquivo .war do projeto e exportar para o caminho do nosso novo Tomcat



ASSISTIR NOVAMENTE A ATIVIDADE 9 DA AULA 8 CURSO SERVLETS
RESPONDER AO QUESTIONÁRIO DE SAÍDA GOOGLE CLASSROOM
RESPONDER QUESTIONÁRIO DE ENTRADA HTTP
MANDAR MINHA PERGUNTA PARA A PAULA
TERMINAR O CURSO DE HTTP EM, NO MÁXIMO, 2 DIAS

______________________________________________________________

2- HTTP: Entendendo a web por baixo dos panos						14h

> obs:documento rfc do http --> informações oficiais e mais modernas

## O que é HTTP?

* É um protocolo de comunicação web criado para garantir segurança, imutabilidade
e acessibilidade a qualquer cliente em qualquer servidor, desde que as regras previamente
estabelecidas de comunicação sejam cumpridas.

* O HTTPS usa criptografia para garantir que o http não seja passado via texto puro(raw text) evitando
que terceiros interceptem e interpretem a comunicação.
Ele funciona com um Certificado Digital (TLS/SSL) que possui uma chave digital (ssh publico/privada) que é única.
* A criptografia é feita com base na chave privada
* O tipo de criptografia usada é a <b>criptografia assimétrica</b>
* Os problemas da criptografia assimétrica é o custo de processamento
* o HTTPS usa ambos os métodos de criptografia, assimétrica e simétrica
* o cliente gera uma chave simétrica ao vivo

		"No certificado, vem a chave pública para o cliente utilizar, certo? E o servidor continua na posse da chave privada, ok? Isso é seguro, mas lento e por isso o cliente gera uma chave simétrica ao vivo. Uma chave só para ele e o servidor com o qual está se comunicando naquele momento! Essa chave exclusiva (e simétrica) é então enviada para o servidor utilizando a criptografia assimétrica (chave privada e pública) e então é utilizada para o restante da comunicação."

		_http Alura
		
<b>A chave simétrica é criptografada com a(s) chave(s) privada e pública? </b>

		HTTPS começa com criptografia assimétrica para depois mudar para criptografia simétrica. 
		Essa chave simétrica será gerada no início da comunicação e será reaproveitada nas requisições seguintes.

### Domínios e endereços

		$- nslookup google.com
		
		// Server:		8.8.8.8
		// Address:		8.8.8.8#53
		
		...
		// Address: 172.217.29.46
		
Domínio = alias do IP
Servidor DNS = banco de dados com chave/valor dos IP's e domínios
		
#### Estrutura de um endereço web

https://cursos.alura.com.br

protocolo + domínio

://cursos.alura.com.br

subdomínio(src) + domínio + tipo domínio + top level domain (root)


### Modelo Requisição/Resposta

HTTP Request --> HTTP Response
requisições http são stateless (não carregam informações anteriores e cada
requisição é única)
Servidor usa cookies para lembrar do usuário logado já que a requisição http é stateless
Spring usa JSESSIONID
Podemos trafegar qualquer tipo de dado por uma comunicação http. Html, css, imagens, textos, sons...


### Análise Request Response

		$- telnet www.caelum.com.br 80 (no terminal)
		
		// o telnet estabelece uma conexão TCP (protocolo de rede abaixo do HTTP) e permite que
		// enviemos dados em cima dessa conexão via terminal.
		// abre o buffer:
		// digite: GET / HTTP/1.1 Host: www.caelum.com.br 

	
### Parâmetros de requisição

Enviar e configurar parâmetros para o servidor de forma estruturada

		https://youtube.com
		pesquisar por "algum assunto"
		
		devolve:
		https://www.youtube.com/results?search_query=algum+assunto
		GET 200
		
Para concatenar mais de um parâmetro na url, usar o "&" (e) comercial e o novo parâmetro. 
	

### Metodos HTTP

* GET
* POST
* PUT
* DELETE
* PATCH

### Dados binários, GZIP Ativo e TLS

		$- curl www.caelum.com.br
		
				ou
		
		$- curl -v www.caelum.com.br
		traz informações da requisição + html no terminal (binários)

Com HTTP-2: 
* Os bodys (req/resp) são comprimidos por GZIP
* Os cabeçalhos (req/resp) trafegam em binário + HPACK + TLS


		HTTP2(headers request/response) = Binário + HPACK + TLS

> No HTTP 1.1, para melhorar a performance, habilitamos o GZIP no servidor para comprimir 
os dados das respostas. É uma excelente prática, mas que precisa ser habilitada explicitamente.
No HTTP/2, o GZIP é padrão e obrigatório.

No header da requisição:
		Accept-Encoding: gzip, deflate;


#### Cabeçalhos Statefull

No HTTP-2 o header não é enviado em todas as requisições. Tendo um context root igual, ele só 
completará com o restante dos parâmetros da URI como recursos
O método HTTP é statefull, mas no HTTP-2, o HPACK tem um meio de guardar informação do header de um cliente
pra nao ficar repetindo informações pela rede e onerar o usuário. (tráfego de menos dados = internet mais rápida)

### HTTP-2 Server-Push

Quando o servidor envia dados ao cliente sem que o mesmo tenha pedido. Apenas um arquivo mas que
depende de outros recursos pra funcionar. 
ex: peço uma página html --> vem: css, javascript, um video e um audio, etc...
(programação reativa? callbacks? eventlisteners?)

### Multiplexing

Antes da conexão HTTP ser iniciada, ocorre uma conexão TCP (protocolo de infra-estrutura)
conexão TCP é cara. Por isso, ela não ocorre cada vez que uma requisição é feita por um mesmo cliente
HTTP 1.1 - método Keep-Alive mantém uma conexão TCP ativa por um tempo determinado

HTTP 1.1 mantém de 4 à 8 conexões TCP abertas ao mesmo tempo
HTTP 2.0 mantém comunicação assíncrona com callbacks e promisses



#########################################################
##### CHECKOUT ESTENDIDO NA QUARTA FEIRA			#####
##### DOJO QUINTA FEIRA À TARDE						#####
##### flyway API para migrations no Spring (JPA 	#####
##### e mapeamento de bancos já existentes)			#####
##### workbench plano de análise de queries - MY SQL#####
#########################################################

3- Introdução ao SQL com MySQL: Manipule e consulte dados 			12h

4- Consultas SQL: Avançando no SQL com MySQL 						14h

5- Java e JPA: Persista seus objetos com a JPA2 e Hibernate 		08h

6- Spring Boot API REST: Construa uma API 							08h

7- Spring Boot API Rest: Segurança da API, Cache e Monitoramento 	12h

___________________________________________________________________________		

8- Spring Boot e Teste: Profiles, Testes e Deploy 					08h

9- Spring Data JPA: Repositórios, Consultas, Projeções e 			10h
Specifications

10- SOLID com Java: Orientação a Objetos com Java 					08h

11- Java e Testes: Test Driven Development com Junit 				12h

12- Teste de Integração: Testes SQL e DAOs automatizados em Java 	12h

### Fase 3

Projetos:

1) Desafio Casa do Código
2) Desafio Mercado Livre

___________________________________________________________________________

### Fase 4

13- Docker: Criando containers sem dor de cabeça 					10h

14- Kafka: Produtores, Consumidores e streams 						08h

15- Kotlin: primeiros passos e Orientação a Objetos 				10h

16- Kotlin: herança, polimorfismo e Interface 						10h

17- Kotlin: recursos da linguagem com pacotes e composição 			08h

18- Kotlin: lidando com exceptions e referências nulas 				08h

19- Kotlin: Desenvolva com coleções, arrays e listas 				10h

___________________________________________________________________________

### Fase 5

20- Kotlin Collections: Set e Map 									08h

21- Kotlin: recursos do paradigma funcional 						12h

22- Mocks em Java: Testes de comportamentos automatizados 			12h

23- Persistência com JPA: Introdução ao Hibernate 					08h

24- SOLID com Java: Princípios da programação orientada a objetos 	08h

___________________________________________________________________________
