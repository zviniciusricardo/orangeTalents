# Spring Boot APU REST:

Um resumo da história e evolução do Spring;
Que, para criar um projeto com Spring Boot, utilizamos o Spring Initialzr, através do site https://start.spring.io;
Como importar um projeto com Spring Boot na IDE Eclipse;
Como é o pom.xml de uma aplicação que utiliza o Spring Boot;
Que, para inicializar o projeto com Spring Boot, devemos utilizar a classe com o método main;
Que, para criar um controller, utilizamos as anotações @Controller e @RequestMapping


@ResponseBody em cima do método lista, na classe controller. Qual o objetivo dessa anotação?
Por padrão, o Spring considera que o retorno do método é o nome da página que ele deve carregar, 
mas ao utilizar a anotação @ResponseBody, indicamos que o retorno do método deve ser serializado
e devolvido no corpo da resposta.

@RestController não precisa do ResponseBody



Sobre a API que desenvolveremos ao longo do curso e sobre as classes de domínio dela;
Que, para um método no controller não encaminhar a requisição a uma página JSP, ou Thymeleaf, devemos utilizar a anotação @ResponseBody;
Que o Spring, por padrão, converte os dados no formato JSON, utilizando a biblioteca Jackson;
Que, para não repetir a anotação @ResponseBody em todos os métodos do controller, devemos utilizar a anotação @RestController;
Que, para não precisar reiniciar manualmente o servidor a cada alteração feita no código, basta utilizar o módulo Spring Boot DevTools;
Que não é uma boa prática retornar entidades JPA nos métodos dos controllers, sendo mais indicado retornar classes que seguem o padrão DTO (Data Transfer Object);
Os principais conceitos sobre o modelo arquitetural REST, como recursos, URIs, verbos HTTP, Representações e comunicação stateless.



Em uma aplicação Spring Boot, onde são declaradas as configurações do banco de dados utilizado por ela?
No arquivo application.properties, devem ser declaradas as configurações da aplicação, inclusive as relacionadas ao banco de dados dela.


interface, seguindo o padrão Repository. Qual alternativa representa uma interface repository declarada corretamente?
A interface TopicoRepository está herdando da interface correta do Spring Data JPA.



Para utilizar o JPA no projeto, devemos incluir o módulo Spring Boot Data JPA, que utiliza o Hibernate, por padrão, como sua implementação;
Para configurar o banco de dados da aplicação, devemos adicionar as propriedades do datasource e do JPA no arquivo src/main/resources/application.properties;
Para acessar a página de gerenciamento do banco de dados H2, devemos configurar o console do H2 com propriedades no arquivo src/main/resources/application.properties;
Para mapear as classes de domínio da aplicação como entidade JPA, devemos utilizar as anotações @Entity, @Id, @GeneratedValue, @ManyToOne, @OneToMany e @Enumerated;
Para que o Spring Boot popule automaticamente o banco de dados da aplicação, devemos criar o arquivo src/main/resources/data.sql;
Para criar um Repository, devemos criar uma interface, que herda da interface JPARepository do Spring Data JPA;
Para criar consultas que filtram por atributos da entidade, devemos seguir o padrão de nomenclatura de métodos do Spring, como por exemplo findByCursoNome;
Para criar manualmente a consulta com JPQL, devemos utilizar a anotação @Query;


Métodos void no Controller
Para métodos void, será devolvida uma resposta sem conteúdo, juntamente com o código HTTP 200 (OK),
caso a requisição seja processada com sucesso.


realizar validações de formulário, utilizando a especificação Bean Validation. Foi necessário 
anotar o parâmetro form, no método cadastrar, com a anotação @Valid. Qual o objetivo dessa anotação?
Indicar ao Spring para executar as validações do Bean Validation no parâmetro do método


Handlers de Erros de Validação @RestControllerAdvice --> tratamentos de erro

metodo:

		@RestControllerAdvice
		public class ErroDeValidacaoHandler {

			@ResponseStatus(cod = HttpStatus.BAD_REQUEST)
			@ExceptionHandler(MethodArgumentNotValidException.class)
			public List<ErroDeForumularioDto> handler(MethodArgumentNotValidException ex) {
				
				List<ErroDeFormularioDto> dto = new ArrayList<>();
				
				List<FieldError> fieldErrors = exception.getBindResult().getFieldErrors();
				fieldErrors.forEach(e -> {
						String mensagem = messageSource.getMessage(e, LocaleContextHolder.getLocale());
						ErroDeForumularioDto erro = new ErroDeFormularioDto(e.getField(), mensagem);
						dto.add(erro);
				});
				
				return dto;
			}
		}
		
		____
		
		O status code padrão a ser devolvido será o 200, mas é possível modificá-lo com a anotação @ResponseStatus.


Para fazer validações das informações enviadas pelos clientes da API, podemos utilizar a 
especificação Bean Validation, com as anotações @NotNull, @NotEmpty, @Size, dentre outras;
Para o Spring disparar as validações do Bean Validation e devolver um erro 400, caso alguma 
informação enviada pelo cliente esteja inválida, devemos utilizar a anotação @Valid;

Para interceptar as exceptions que forem lançadas nos métodos das classes controller, devemos 
criar uma classe anotada com @RestControllerAdvice;

Para tratar os erros de validação do Bean Validation e personalizar o JSON, que será devolvido 
ao cliente da API, com as mensagens de erro, devemos criar um método na classe @RestControllerAdvice
e anotá-lo com @ExceptionHandler e @ResponseStatus(cod = HttpStatus.BAD_REQUEST).


é possível definir um path com partes dinâmicas. Qual das seguintes maneiras é a correta para se
definir um path dinâmico no Spring?
@GetMapping(“/{id}”)


método do controller foi necessário adicionar a anotação @Transactional. Quais os objetivos dessa anotação?
Alternativa correta! Métodos anotados com @Transactional serão executados dentro de um contexto transacional.
Efetuar o commit automático da transação, caso não ocorra uma exception


Nesta aula, aprendemos que:

Para receber parâmetros dinâmicos no path da URL, devemos utilizar a anotação @PathVariable;
Para mapear requisições do tipo PUT, devemos utilizar a anotação @PutMapping;
Para fazer o controle transacional automático, devemos utilizar a anotação @Transactional nos métodos do controller;
Para mapear requisições do tipo DELETE, devemos utilizar a anotação @DeleteMapping;
Para tratar o erro 404 na classe controller, devemos utilizar o método findById, ao invés do método getOne, e utilizar a classe ResponseEntity para montar a resposta de not found;
O método getOne lança uma exception quando o id passado como parâmetro não existir no banco de dados;
O método findById retorna um objeto Optional<>, que pode ou não conter um objeto.

________________________________________________________________________________________________________________

# Resposta Formulário

* 	O Spring Boot traz pré-configurações que nos permitem iniciar uma aplicação em questão de minutos.
Ele nos permite fazer grandes e complexas alterações com algumas notations nos permitindo alterar
coisas como o Drivers de Bancos de dados, especificações Java como servlets, persistence, web, security, etc;

* 	O primeiro passo seria interceptar os dados referentes à nossa entidade Aluno.
	Esse endpoit seria do tipo POST e seria enviado pelo cliente através de formulário x-www-formencoded e 
interceptado pelo Controller com o contexto "api/cadastro/aluno" (Esse seria também a persist-unit,
parte das configurações de properties onde o nosso Spring Data receberia configurações do tipo persistence
com as especificações JPA/Hibernate por padrão)
	Seguindo as boas práticas de aplicações MVC REST e de segurança, criaríamos uma classe auxiliadora
para conversão e persistência dos dados enviados via request em uma Entidade Objeto Relacional. Um "objetoForm"
ou um dto capaz de levar os dados de forma segura até a camada mais baixa da aplicação (conversão em entidade) e do model 
a camada de persistência.
	O nosso controller seria anotado com @RestController o que o tornaria automaticamente gerenciado pelo
Java como um java Bean e tiraria a necessidade de explicitar um RequestBody nos métodos controladores.
	Na anotation, eu definiria o contexto da requisição com @RequestMapping("api/cadastro/aluno"). Com essa
anotação, não seria mais necessário declarar nos parâmetros de cada método, o tipo de requisição, ficando
a cargo do Spring Boot configurar isso pra nós através das notações @PostMapping no método
		
		@PostMapping
		public ResponseEntity<AlunoDTO> cadastrar(@RequestBody @Valid AlunoForm form, UriComponentsBuilder uriBuilder) {
			Aluno aluno = form.converter(alunoRepository);
			alunoRepository.save(aluno);
			
			Uri uri = uriBuilder.path("/api/cadastro/aluno/{id}").buildAndExpand(aluno.getId()).toUri();
			return ResponseEntity.created(uri).body(new AlunoDto(aluno));
		};
	
	Provavelmente, usaríamos a anotation @PostMapping no método e dentro do construtor, a anotação @RequestBody para
definique que os dados não devem ser mostrados na URL e sim, serão passados pelo cliente via POST.
	Para persistir os dados, precisaremos de uma classe que herde a especificação JPA. Criaremos a classe AlunoRepository
e essa vai extender a classe JpaRepository. Desse modo, nossa classe AlunoRepository poderá usar muitos métodos pré-prontos
e configurados com especificações JPA/Hibernate definidos no application.properties.
	Para que nossa classe seja usada no controller, precisaremos passá-la ou via construtor na classe repository, ou mesmo
passá-la via @Autowired anotation.
	Dessa forma, o método receberia uma request do tipo POST do cliente e esses dados instanciariam um objeto do tipo form.
O form recebe um AlunoRepository via construtor e agora pode converter o AlunoForm (ou outra coisa) para Aluno e depois fazer
a persistência com o alunoRepository.save(). obs: precisaremos criar uma classe Util para a conversão de AlunoForm para Aluno
que poderá ser um método da própria classe AlunoForm.
	Para validação, seria interessante usar algumas anotações do JPA nas classes e seus atributos como também mapear relacionamentos.
	As notations @Id, @GeneratedValue(strategy), @NotBlank,@NotNull, @Min(18), @Max(100) são úteis pra validar os atributos das nossas
classes, bastando colocar a notação @Valid nos parâmetros do método cadastrar() do controller.
	Junto com a notação @RequestBody dentro do construtor do método cadastrar, inserir a notação 
@ResponseStatus(cod = HttpStatus.BAD_REQUEST) para enviar uma response 400 caso haja algo errado com a validação dos dados.
	Para buscar o dado persistido, devemos criar um método no controller e anotá-lo com @GetMapping

		@GetMapping("/{ id }")
		public ResponseEntity<AlunoDto> buscarAluno(@PathVariable Long id) {
			Optional<Aluno> aluno = alunoRepository.findById(id);
			if(aluno.isPresent()) {
				return ResponseEntity.ok(new AlunoDto(aluno.get()));
		}
		
		return ResponseEntity.notFound().build();
	
	Na requisição do tipo GET, o controller instancia um AlunoRepository e faz a busca no banco pelo id
declarado pelo cliente via HTTP. Esse id serve de construtor para o método buscarAluno() que também
ganha a notação @PathVariable que olha pra nossa outra notação @GetMapping e faz essa relação entre
id como parte da requisição http, devolvendo o id como um endpoint do nosso contexto, que ficaria

		api/aluno/{id}

Ao usar o ResponseEntity para gerenciar o nosso controller, podemos alterar o comportamento do servidor
usando uma abordagem de programação funcional.
Nosso nossa classe alunoRepository irá procurar por um id de aluno e devolver para uma variável do 
tipo Optional. Isso evita que erros não tratados(stacktrace) sigam na response para o cliente.
Caso ele não encontre o cliente com o id declarado, o corpo da requisição virá em branco com o status
404 Not Found.

O que seria bom ver nessa resposta?



Peso 1: 	Na resposta sobre o motivo do Spring Boot é importante aparecer algo próximo como "Facilitador de configuração"
Peso 0.5: 	Para o cadastro: Método no controller mapeado para um endereço acessado via post
Peso 2: 	Para o cadastro: Classe criada especificamente para receber os dados. O famoso DTO
Peso 0.5: 	Para o cadastro: Uso das anotações padrões da Bean Validation para realizar as validações.
Peso 0.5: 	Para o cadastro: Criação de um objeto do tipo Aluno em função dos dados recebidos no método do controller.
Peso 0.5: 	Para o cadastro: Configuração do acesso ao banco de dados no application.properties ou yaml.
Peso 0.5: 	Para o cadastro: Utilização do EntityManager ou Repository do Spring Data JPA para gravar o objeto do tipo Aluno no banco de dados escolhido.
Peso 0.5: 	Para o cadastro: Retorno void no método do controller ou usando ResponseEntity para informar o status 200.
Peso 0.5: 	Para o detalhe: Método no controller mapeado para um endereço acessado via get
Peso 0.5: 	Para o detalhe: Parâmetro que representa o id do aluno fazendo parte do endereço
Peso 0.5: 	Para o detalhe: Utilização de método padrão do Repository ou uso direto do EntityManager para carregar o objeto do tipo Aluno pelo id.
Peso 2.0: 	Para o detalhe: Utilização dos dados do objeto aluno para montar um objeto de saída com os dados específicos.
Peso 0.5: 	Para o detalhe: Retorno do objeto de saída no método. Também vale a utilização do ResponseEntiy.


Resposta do Especialista:

O Spring boot serve para facilitar a configuração de projetos que querem utilizar a stack do Spring. Através de auto configurações, quase sempre fornecida por starters, a configuração das tecnologias é bem facilitada.
Crio a classe Aluno, adiciono os atributos necessários e também adiciono um id. Adiciono o Id para mapear como chave primária para o banco de dados.
Mapeio a classe Aluno para ser entendida pelo HIbernate. Uso o @Entity em cima da classe e o @Id em cima do atributo id. Poderia colocar também o @Id no email. A @Entity explica para o Hibernate que aquela classe vai ser uma tabela no banco e o @Id explica que aquele atributo vai ser a chave primaria na tabela. Os outros atributos eu não preciso mapear pq ele já vai mapear para colunas do mesmo nome.
Já configuro o acesso ao banco de dados no application.properties com o login/senha e banco de dados local específico.
Crio o controller relativo a alunos
Crio o método que vai receber os dados de cadastro e anoto com @PostMapping

Crio a classe que representa os dados de entrada e anoto cada atributo com as anotações específicas da Bean Validation. Nesse caso poderia usar @Length, @Email, @Min
Crio um método na classe que representa os dados de entrada(DTO) que é responsável por criar um objeto do tipo Aluno a partir dos dados de entrada
Crio a classe que representa o Aluno
Mapeio a classe para a utilização do Hibernate
Volto no controller, recebo injetado o EntityManager e salvo o objeto criado do tipo Aluno. Podia ter usado um Repository também, mas não é necessário.
Deixo o retorno do método como void.
Agora eu crio outro método no controller mapeado para receber get
Coloco o id como parte do endereço
Já defino que o retorno vai ser um objeto do específico para a saída do detalhe apenas com nome e email.
Recebo o id como argumento do método usando a annotation @PathVariable
Utilizo o EntityManager dentro do método para carregar o objeto do tipo Aluno pelo id.
Instancio o objeto do tipo de saída, passo o objeto do tipo aluno como argumento no construtor  e já retorno ele no método.
Agora eu crio a classe que representa a saída, com os atributos específicos, além do construtor. Adiciono os getters, e apenas eles, para expor os dados que preciso.













