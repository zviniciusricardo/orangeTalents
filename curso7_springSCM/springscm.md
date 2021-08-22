# Spring Security, cache e monitoramento da aplicação REST


## Paginacao

		@GetMapping
		public Page<TopicoDto> lista(@RequestParam(required = false) String nomeCurso,
				@PageableDefault(sort = "id", direction = Direction.DESC, page = 0, size = 10) Pageable paginacao) {
				
			if (nomeCurso == null) {
				Page<Topico> topicos = topicoRepository.findAll(paginacao);
				return TopicoDto.converter(topicos);
			} else {
				Page<Topico> topicos = topicoRepository.findByCursoNome(nomeCurso, paginacao);
				return TopicoDto.converter(topicos);
			}
		}
		
		@SpringBootApplication
		@EnableSpringDataWebSupport ---> habilitar recursos de paginação
		public class MyApplication {
		
			public static void main(String[] args) {
				SpringApplication.run(MyAppication.class, args);
			}
		}


* alterar o retorno do método lista, de List<Topico>, para Page<Topico>. Qual a vantagem de devolver um objeto Page, ao invés de um List?
Ao utilizar o objeto Page, além de devolver os registros, o Spring também devolve informações sobre a paginação no JSON de resposta , como número total de registros e páginas.

* Vimos que, para ordenar os registros, foi necessário passar um parâmetro com o nome do atributo para realizar a ordenação. O que acontece se o nome do atributo informado estiver incorreto?
Erro 500 devolvido ao cliente via response body

Nesta aula, aprendemos que:

Para realizar paginação com Spring Data JPA, devemos utilizar a interface Pageable;
Nas classes Repository, os métodos que recebem um pageable como parâmetro retornam objetos do tipo Page<>, ao invés de List<>;
Para o Spring incluir informações sobre a paginação no JSON de resposta enviado ao cliente da API, devemos alterar o retorno do método do controller de List<> para Page<>;
Para fazer a ordenação na consulta ao banco de dados, devemos utilizar também a interface Pageable, passando como parâmetro a direção da ordenação, utilizando a classe Direction, e o nome do atributo para ordenar;
Para receber os parâmetros de ordenação e paginação diretamente nos métodos do controller, devemos habilitar o módulo SpringDataWebSupport, adicionando a anotação @EnableSpringDataWebSupport na classe ForumApplication.


## Cache

Melhorar performance
Acicionar o modulo de cache <spring-boot-starter-cache>
Provedor de cache (Redis, cache em memória HashMapping)
Habilitar o uso de cache no projeto classe main

		@SpringBootApplication
		@EnableSpringDataWebSupport ---> habilitar recursos de paginação
		@EnableCaching ----------------> habilitar cache
		public class MyApplication {
		
			public static void main(String[] args) {
				SpringApplication.run(MyAppication.class, args);
			}
		}

		@GetMapping
		@Cacheable(value = "listaDeTopicos") --------------> RECURSOS DE CACHE NO MÉTODO DO ENDPOINT
		public Page<TopicoDto> lista(@RequestParam(required = false) String nomeCurso,
				@PageableDefault(sort = "id", direction = Direction.DESC, page = 0, size = 10) Pageable paginacao) {
				
			if (nomeCurso == null) {
				Page<Topico> topicos = topicoRepository.findAll(paginacao);
				return TopicoDto.converter(topicos);
			} else {
				Page<Topico> topicos = topicoRepository.findByCursoNome(nomeCurso, paginacao);
				return TopicoDto.converter(topicos);
			}
		}
		
O cache guarda valores por requisição no navegador --> parâmetros já realizados são guardados,
novas requisições, mesmo que com dados em cache, são realizadas novamente pelo cache.
		
		@CacheEvict(value = "listaDeTopicos", allEntries = true) --> usado para invalidar o cache forçando o servidor uma nova
		requisição --> foi usado no curso como exemplo no método remove() == DELETE.
		
Onde utilizar cache e onde não utilizar? (resposta pergunta 1)
O cache precisa ser invalidado em determinado momento. Validar e invalidar cache toda hora é caro
Usar em tabelas que nunca ou quase nunca sofrem modificação - tabelas de tipos - de referência - lookup tables


Nesta aula, aprendemos que:

Para utilizar o módulo de cache do Spring Boot, devemos adicioná-lo como dependência do projeto no arquivo pom.xml;
Para habilitar o uso de caches na aplicação, devemos adicionar a anotação @EnableCaching na classe ForumApplication;
Para que o Spring guarde o retorno de um método no cache, devemos anotá-lo com @Cacheable;
Para o Spring invalidar algum cache após um determinado método ser chamado, devemos anotá-lo com @CacheEvict;
Devemos utilizar cache apenas para as informações que nunca ou raramente são atualizadas no banco de dados.


# Segurança
Adicionar a dependency <spring-boot-starter-security> no pom.xml
Configurar via classe Java


		dentro do pacote .security
		
		@EnableWebSecurity
		@Configuration
		puclic class SecurityConfigurations extends WebSecurityConfigurerAdapter {
			
			@Override // Configurações de autenticação (login)
			protected void configure(AuthenticationManagerBuilder auth) throws Exception {
			
					
			}
			
			@Override // Configurações de autorização (url, grants, acessos)
			protected void configure(HttpSecurity http) throws Exception {
				
					http.authorizeRequests()
					.antMatchers("/topicos").permitAll() ---> permissão independete do método usado
					.antMatchers(HttpMethod.GET, "/topicos").permitAll()
					.antMatchers(HttpMethod.GET, "/topicos/*").permitAll()
					.anyRequest().authenticated(); ---------> exigir permissões para todas as operações não listadas
					.and().formLogin();
					
					// liberando acesso à endpoints públicos
					// caso eu tente usar um outro método não permitido, o server retorna 403- forbidden
					
			}
			
			@Override // Configurações de recursos estáticos (html, css, imagens, etc)
			protected void configure(WebSecurity web) throws Exception {
			
			}
		
		}

obs: O padrão do Spring Security é bloquear todos os endpoints
quais endereços eu quero liberar e qual eu quero proteger
sobrescrever métodos da WebSecurityConfigurerAdapter


## Autenticação

Em uma entidade que precisar ser autenticada
		
		
		@Entity
		public class User implements UserDetails {
			
			@Entity @GeneratedValue(strategy = GenerationType.IDENTITY)
			private Long id;
			private String nome;
			private String email;
			private String senha;
			
			@ManyToMany(fetch = fetchType.EAGER)
			private List<Perfil> perfis = new ArrayList<>(); --> geraremos uma classe Perfil abaixo
			
			// implementação da Classe UserDetails e seus muitos métodos. Cada método trata
			// uma indicação para o Spring Boot Security de quais atributos serão usadas para 
			// quais autenticações via request/response
			
			// um desses métodos é o getAuthorities() que dá grant à roles, permissões, etc.
			
			@Override
			public Collection<? extends GrantedAuthority> getAuthorities() {
				return this.perfis;
			}
			
		}

		
		@Entity
		public class Perfil implements GrantedAuthorit {
		
			@Entity @GeneratedValue(strategy = GenerationType.IDENTITY)
			private Long id;
			
			private String nome;
			
			// getters and setters
			
			@Override
			public String getAuthority() {
				return nome;
			}
		}


No vídeo anterior, vimos que foi necessário criar uma classe, implementando a interface UserDetailsService do Spring Security. 
Qual o objetivo dessa classe?
Para indicar ao Spring Security que essa é a classe service que executa a lógica de autenticação

Nesta aula, aprendemos que:

Para utilizar o módulo do Spring Security, devemos adicioná-lo como dependência do projeto no arquivo pom.xml;
Para habilitar e configurar o controle de autenticação e autorização do projeto, devemos criar uma classe e anotá-la com @Configuration e @EnableWebSecurity;
Para liberar acesso a algum endpoint da nossa API, devemos chamar o método http.authorizeRequests().antMatchers().permitAll() dentro do método configure(HttpSecurity http), que está na classe SecurityConfigurations;
O método anyRequest().authenticated() indica ao Spring Security para bloquear todos os endpoints que não foram liberados anteriormente com o método permitAll();
Para implementar o controle de autenticação na API, devemos implementar a interface UserDetails na classe Usuario e também implementar a interface GrantedAuthority na classe Perfil;
Para o Spring Security gerar automaticamente um formulário de login, devemos chamar o método and().formLogin(), dentro do método configure(HttpSecurity http), que está na classe SecurityConfigurations;
A lógica de autenticação, que consulta o usuário no banco de dados, deve implementar a interface UserDetailsService;
Devemos indicar ao Spring Security qual o algoritmo de hashing de senha que utilizaremos na API, chamando o método passwordEncoder(), dentro do método configure(AuthenticationManagerBuilder auth), que está na classe SecurityConfigurations.


ASSITIR NOVAMENTE -- AUTENTICANDO O USUÁRIO, CURSO 3 DE WEB SECURITY


## Token e JWT

Autenticação via Session (antiga) JSESSIONID = 1
Ocupa espaço na memória - perde a característica REST por guardas estados (perdemos a STATELESS)
Caso o servidor caia, perdemos nosso cache em memória das sessions.

Novo
Identificação via Token


### Json Web Token
Autenticação Stateless
configurar dependência pom.xml (biblioteca jjwt)
		
		<groupId>io.jsonwebtoken</groupId>
		<artifactId>jjwt</artifactId>
		<version>0.9.1</version>

Configurar a classe de WebConfig/Configuration
metodo 
		
@Override // Configurações de autorização (url, grants, acessos)
			protected void configure(HttpSecurity http) throws Exception {
				
				http.authorizeRequests()
					.antMatchers("/topicos").permitAll() 
					.antMatchers(HttpMethod.GET, "/topicos").permitAll()
					.antMatchers(HttpMethod.GET, "/topicos/*").permitAll()
					.anyRequest().authenticated();
### .and().formLogin() -------> retirar essa classe (usaremos JWT) ###
					.and().csrf().disable() --> cross site rest forgery (ataque exploit)
					.sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);	
			}

Perdemos o formulário gerado pelo Spring
Perdemos também o nosso controller que tratava desse endpoint
Teremos q criar outro


No vídeo anterior, tivemos que remover a chamada ao método and().formLogin() da classe SecurityConfigurations. 
Mas dessa maneira, como um usuário vai se autenticar na API?
O usuário deverá se autenticar por uma página de login fornecida pela própria aplicação cliente

No último vídeo, vimos que é possível fazer injeção de dependências de propriedades do arquivo application.properties. Dos exemplos de código abaixo, qual deles faz a injeção de propriedades de maneira correta?
A anotação @Value deve declarar o nome da propriedade como String, utilizando a expression language ${}.

		@Value(“${forum.jwt.secret}”)
		private String secret;

		forum.jwt.secret=rm'!@N=Ke!~p8VTA2ZRK~nMDQX5Uvm!m'D&]{@Vr?G;2?XhbC:Qa#9#eMLN\}x3?JR3.2zr~v)gYF^8\:8>:XfB:Ww75N/emt9Yj[bQMNCWwW\J?N,nvH.<2\.r~w]*e~vgak)X"v8H`MH/7"2E`,^k@n<vE-wD3g9JWPy;CrY*.Kd2_D])=><D?YhBaSua5hW%{2]_FVXzb9`8FH^b[X3jzVER&:jw2<=c38=>L/zBq`}C6tT*cCSVC^c]-L}&/
		forum.jwt.expiration=86400000	


No último vídeo, vimos que ao devolver o token para o cliente, foi enviado juntamente outra informação, chamada Bearer. 
A que se refere essa informação?
Bearer é um dos mecanismos de autenticação utilizados no protocolo HTTP, tal como o Basic e o Digest.	

Nesta aula, aprendemos que:

Em uma API Rest, não é uma boa prática utilizar autenticação com o uso de session;
Uma das maneiras de fazer autenticação stateless é utilizando tokens JWT (Json Web Token);
Para utilizar JWT na API, devemos adicionar a dependência da biblioteca jjwt no arquivo pom.xml do projeto;
Para configurar a autenticação stateless no Spring Security, devemos utilizar o método sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
Para disparar manualmente o processo de autenticação no Spring Security, devemos utilizar a classe AuthenticationManager;
Para poder injetar o AuthenticationManager no controller, devemos criar um método anotado com @Bean, na classe SecurityConfigurations, que retorna uma chamada ao método super.authenticationManager();
Para criar o token JWT, devemos utilizar a classe Jwts;
O token tem um período de expiração, que pode ser definida no arquivo application.properties;
Para injetar uma propriedade do arquivo application.properties, devemos utilizar a anotação @Value.

No último vídeo, vimos que precisamos criar um filtro, que vai conter a lógica de recuperar o token 
do cabeçalho Authorization, validá-lo e autenticar o cliente. 
Vimos também que esse filtro precisa ser registrado no Spring.
Qual anotação foi utilizada para registrar o filtro?
O filtro deve ser registrado via método addFilterBefore, na classe SecurityConfigurations.


Por que não é possível fazer injeção de dependências com a anotação @Autowired na classe AutenticacaoViaTokenFilter?
Porque ela não é um bean gerenciado pelo Spring
O filtro foi instanciado manualmente por nós, na classe SecurityConfigurations e portanto o Spring 
não consegue realizar injeção de dependências via @Autowired.


Vimos no último vídeo que foi necessário indicar ao Spring que o cliente está autenticado. Por que essa autenticação foi feita com a classe SecurityContextHolder e não com a AuthenticationManager?
Porque a classe AuthenticationManager dispara o processo de autenticação via username/password
A classe AuthenticationManager deve ser utilizada apenas na lógica de autenticação via username/password, para a geração do token.

Nesta aula, aprendemos que:

Para enviar o token JWT na requisição, é necessário adicionar o cabeçalho Authorization, passando como valor Bearer token;
Para criar um filtro no Spring, devemos criar uma classe que herda da classe OncePerRequestFilter;
Para recuperar o token JWT da requisição no filter, devemos chamar o método request.getHeader("Authorization");
Para habilitar o filtro no Spring Security, devemos chamar o método and().addFilterBefore(new AutenticacaoViaTokenFilter(), UsernamePasswordAuthenticationFilter.class);
Para indicar ao Spring Security que o cliente está autenticado, devemos utilizar a classe SecurityContextHolder, chamando o método SecurityContextHolder.getContext().setAuthentication(authentication).


## Monitoramento

Metadados sobre a API
Se ela está logada, rodando, sobre a saúde da aplicação, etc

<spring-boot-actuator>

Novo endpoint /actuator
(Spring Boot Admin) ferramenta com interface gráfica para monitoramento 


Nesta aula, aprendemos que:

Para adicionar o Spring Boot Actuator no projeto, devemos adicioná-lo como uma dependência no arquivo pom.xml;
Para acessar as informações disponibilizadas pelo Actuator, devemos entrar no endereço http://localhost:8080/actuator;
Para liberar acesso ao Actuator no Spring Security, devemos chamar o método .antMatchers(HttpMethod.GET, "/actuator/**");
Para que o Actuator exponha mais informações sobre a API, devemos adicionar as propriedades management.endpoint.health.show-details=always e management.endpoints.web.exposure.include=* no arquivo application.properties;
Para utilizar o Spring Boot Admin, devemos criar um projeto Spring Boot e adicionar nele os módulos spring-boot-starter-web e spring-boot-admin-server;
Para trocar a porta na qual o servidor do Spring Boot Admin rodará, devemos adicionar a propriedade server.port=8081 no arquivo application.properties;
Para o Spring Boot Admin conseguir monitorar a nossa API, devemos adicionar no projeto da API o módulo spring-boot-admin-client e também adicionar a propriedade spring.boot.admin.client.url=http://localhost:8081 no arquivo application.properties;
Para acessar a interface gráfica do Spring Boot Admin, devemos entrar no endereço http://localhost:8081.

## Documentação com Swagger

Mapear endpoints e especificações da API para os clientes do mundo todo.
Estabelece padrões e comportamentos da API para uso do cliente.

SpringFox --> Biblioteca do Swagger


Nesta aula, aprendemos que:

Para documentar a nossa API Rest, podemos utilizar o Swagger, com o módulo SpringFox Swagger;
Para utilizar o SpringFox Swagger na API, devemos adicionar suas dependências no arquivo pom.xml;
Para habilitar o Swagger na API, devemos adicionar a anotação @EnableSwagger2 na classe ForumApplication;
As configurações do Swagger devem ser feitas criando-se uma classe chamada SwaggerConfigurations e adicionando nela a anotação @Configuration;
Para configurar quais endpoints e pacotes da API o Swagger deve gerar a documentação, devemos criar um método anotado com @Bean, que devolve um objeto do tipo Docket;
Para acessar a documentação da API, devemos entrar no endereço http://localhost:8080/swagger-ui.html;
Para liberar acesso ao Swagger no Spring Security, devemos chamar o seguinte método web.ignoring().antMatchers("/**.html", "/v2/api-docs", "/webjars/**", "/configuration/**", "/swagger-resources/**"), dentro do método void configure(WebSecurity web), que está na classe SecurityConfigurations.


_________________________________________________________________________________________________

Resposta Formulário

_ Já temos muitos alunos e alunas cadastradas e agora temos muito acesso para visualizar os perfis. Além disso, temos um novo endpoint de listagem e essa lista só cresce. Para fechar, é mais do que importante a gente controlar o acesso a tais informações. 


* Dado que as informações cadastradas dos alunos e alunas quase nunca muda, o que você faria para evitar que a recuperação dessa informação fosse feita sempre a partir do banco de dados?
- Eu habilitaria os recursos de cache para essas tabelas. Como elas quase nunca mudam, seria interessante guardar os dados de requisições repetitivas em memória. A anotação @Cacheable no método de buscar Alunos, por exemplo.


* Na listagem é importante trabalharmos com dados paginados. Descreva em detalhes os passos de implementação que você faria para possibilitar que a aplicação cliente pudesse acessar as informações de paginada e porque realizar a paginação é importante.

A primeira coisa a se fazer é habilitar a paginacao em nosso SpringBootApplication com a notação @EnableSpringDataWebSupport.
Logo depois eu mudaria os métodos de requisições GET no controller para retornar um tipo Page como também criaria um atributo pageable para
servir como parâmetro de ordenação e busca pela classe Page.
Caso seja propício, utilizar um valor de paginação default caso o cliente não passe nenhum parâmetro adicional na requisição. Podemos
fazer isso com a notação @PageableDefault(sort = "algumAtributo", direction = Direction.CRESCENTEouDECRESCENTE, page = Nº DE PÁGINAS, size = TAMANHO DE CADA PAGINA) Pageable ATRIBUTO CRIADO DO TIPO PAGEABLE)
Após as mudanças, é necessário modificar nosso método converter (de Dto pra Entidade e vice-versa) para devolver e receber objetos do tipo Page.
Seria interessante usar alguma API de simulação de cliente como o Postman para testar se a paginação e a passagem de parâmetros por requisição está funcionando corretamente.

* Para fechar, descreva como funciona o mecanismo de autenticação e autorização para uma API Rest através de tokens.

Primeiro, precisamos importar as dependências do spring-security que cuidará do gerenciamento de algumas classes
auxiliares com algumas configurações específicas. Outra questão são as dependências do JWT, que gera, parsea e 
gerencia Tokens e o padrão jws.

A classe WebSecurityConfigurerAdapter é a responsável por validar o uso de três métodos que irão agora, fornecer
funcionalidades de autenticação, permissão de acesso, criação de roles, users e seus "domínios exclusivos de acesso".

Os métodos são:

. configure AuthenticationManagerBuilder, para configurações de autenticação e login.
. configure HttpSecurity, para configuração de autorização à acessos, métodos (grants) e  contexto(uris, urls).
. configure WebSecurity, para configurações de recursos estáticos como html, css, imagens, etc.

Através dessas classes é possível definir algumas entidades que representarão configurações e comportamentos
tanto para o cliente quanto para o servidor. Contratos, digamos assim.
Primeiro, ele exige que nossas entidades de persistência, aquelas que representam nossas regras de negócio (e outras
também), definam um GrantedAuthorit(User) e cobra (getAuthority()) um devido nível de acesso para cada user que é
declarada na UserDetails e depois injetada na nossa classe 'User'.

Usar autenticações baseadas em sessions é considerado má prática em Web Enterprises pois fere o princípio REST
de que toda a comunicação de uma API não deve guardar estado (Stateless).
Dessa forma, a outra dependência que usamos no nosso pom.xml é a de jjwt.
O que a autenticação por Json Web Token faz, é resolver o problema de guardar estado na comunicação http.
Através da classe de configuração do web security adapter, no método sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS);
acionamos o processo de identificação como stateless. Dessa forma, o servidor envia o Token para o cliente e esse agora
é responsável por manter e gerenciar esse token para se autenticar via métodos da classe AuthenticationManager;
Agora que nossa aplicação não guarda mais estado, cabe a nós, o servidor, enviar, receber e parsear o Token gerado. Precisamos
definir um novo controller que vai parsear o token, extrair informações dele com métodos de classes provindas da Jwt,
usar o Repository para buscar o dado extraído do token (email e senha, ou outro identificador) e comparar os dois dados
para garantir ou barrar o acesso baseado nos grants definidos ao cliente.
Dessa forma, o Spring Security configura de forma prática o fechamento de todos os endpoints. Ele pede que sejam
criados users, roles e configurações de acesso para cada tipo de usuário e para cada tipo de endpoint.
Da mesma forma, ele deixa a responsabilidade do login para a parte do cliente (framework frontend como Angular) implementar o login
ou fazer o cadastro. Assim que ele está cadastrado, o Spring Security usa o Jwt para realizar comunicações stateless encriptadas
que podem ter data de validade, permissões de acesso e tipo de operações que determinado cliente tem acesso.


O que seria bom ver nessa resposta?

Peso 3: Utilização do Spring Cache para aumentar a velocidade de acesso às informações de detalhe dos(as) alunos(as).
Peso 2: Detalhes que precisam aparecer para o uso da paginação
Peso 1: O motivo de utilizar a paginação
Peso 0.25: Método novo acessado via GET para listagem
Peso 0.25: Parâmetro do tipo Pageable no método
Peso 0.25: Criação de um método no repository já recebendo um Pageable como argumento e retornando um tipo que representa Paginaçao.
Peso 0.25: Retorno do objeto do tipo que representa uma Paginaçao conectado com um outro objeto de saída, para controlar as informações certinhas.
Peso 5: Na resposta sobre segurança é importante ver uma referência a utilização do token e também sobre o funcionamento do token.
Peso 2.5: Explicação da utilização do token associada ao fato de não querermos manter estado no lado do servidor.
Peso 2.5: Explicação sobre o conteúdo do token, informando que a informação ali é criptografada e que contém tudo que é necessário para verificar a existência do usuário na aplicação a cada nova requisição.

Para não acessar o banco de dados o tempo todo para visualizar os detalhes dos(as) alunos(as), eu posso configurar o cache dentro do projeto, através do Spring Cache. Minha estratégia seria começar anotando o método do controller de detalhe com a annotation de Cache. Um ponto de atenção seria a configuração de timeout dos dados em função da necessidade de negócio.
Para a paginação:
Paginamos os dados porque é importante controlar o número de informações retornados nos endpoints. Se a gente não controla, a performance pode ser afetada assim como a própria visualização dos dados.
Primeiro eu crio o método de listagem conectado com um endereço de acesso via GET
Defino um argumento do tipo Pageable para este método
Crio um método no Repository(crio o Repository caso não exista) que recebe como argumento o objeto do tipo Pageable
Transformo os objetos retornados pelo método do Repository para objetos de um tipo de saída para a listagem.
Retorno o objeto que representa a paginação a partir do método do controller.
Para fazer um sistema de autenticação e autorização numa API Rest é necessário fazer com que a informação que representa o "usuário logado" seja passada em cada requisição feita do cliente para o servidor. Chamamos essa informação de "token". Isso pode ser feito via cookie, header, parâmetro de requisição etc.  Isto é feito por conta da natureza stateless da API, a ideia é que toda informação venha sempre do cliente. Isso facilita qualquer ação relativa a escalabilidade futura.

Este token geralmente contém algumas informações do usuário criptografadas a partir de uma chave. Podemos colocar timeout também nesse token para controlar tempo de acesso. A especificação sugerida para guiar a criação do token é a JWT. O Spring Security suporta tudo isso através de configurações um tanto quanto extensas.
