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










____________________________________________________________________________________________________

Resposta Formulário

_ Já temos muitos alunos e alunas cadastradas e agora temos muito acesso para visualizar os perfis. Além disso, temos um novo endpoint de listagem e essa lista só cresce. Para fechar, é mais do que importante a gente controlar o acesso a tais informações. 


* Dado que as informações cadastradas dos alunos e alunas quase nunca muda, o que você faria para evitar que a recuperação dessa informação fosse feita sempre a partir do banco de dados?
- Eu habilitaria os recursos de cache para essas tabelas. Como elas quase nunca mudam, seria interessante guardar os dados de requisições repetitivas em memória. A anotação @Cacheable no método de buscar Alunos, por exemplo.


* Na listagem é importante trabalharmos com dados paginados. Descreva em detalhes os passos de implementação que você faria para possibilitar que a aplicação cliente pudesse acessar as informações de paginada e porque realizar a paginação é importante.
- A primeira coisa a se fazer é habilitar a paginacao em nosso SpringBootApplication com a notação @EnableSpringDataWebSupport.
Logo depois eu mudaria os métodos de requisições GET no controller para retornar um tipo Page como também criaria um atributo pageable para
servir como parâmetro de ordenação e busca pela classe Page.
Caso seja propício, utilizar um valor de paginação default caso o cliente não passe nenhum parâmetro adicional na requisição. Podemos
fazer isso com a notação @PageableDefault(sort = "algumAtributo", direction = Direction.CRESCENTEouDECRESCENTE, page = Nº DE PÁGINAS, size = TAMANHO DE CADA PAGINA) Pageable ATRIBUTO CRIADO DO TIPO PAGEABLE)
Após as mudanças, é necessário modificar nosso método converter (de Dto pra Entidade e vice-versa) para devolver e receber objetos do tipo Page.
Seria interessante usar alguma API de simulação de cliente como o Postman para testar se a paginação e a passagem de parâmetros por requisição está funcionando corretamente.

* Para fechar, descreva como funciona o mecanismo de autenticação e autorização para uma API Rest através de tokens.

























