# Spring Data JPA: Repos, consultas, projeções e Specifications


Nessa aula aprendemos:

qual a stack necessária para nosso projeto;
configurar nosso projeto Spring para conectar ao banco de dados;
criar tabelas de forma automática e alterar o nome delas conforme a necessidade da aplicação;
utilizar os repositórios do framework para trazer agilidade nas nossas operações de CRUD.


O findById sempre devolve um Optional, que sabe se o elemento existe ou não. 
Assim, não precisamos lidar com null ou tratar uma exceção.

Nessa aula aprendemos:

como utilizar a ferramenta de repositório do framework;
inserir um registro dinâmico na base de dados;
atualizar registros salvos;
deletar um registro por meio do seu ID;
visualizar todos os registros salvos.

Derived Queries Spring Data

findByAlgumaCoisaAndOutraCoisa

ver documentação do Spring Data e os métodos do JPARepository

https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#reference
https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#jpa.query-methods

Em vídeo, vimos como buscar funcionários pelo método findByNome dentro do repositório:

@Repository
public interface FuncionarioRepository extends CrudRepository<Funcionario, Integer> {
    List<Funcionario> findByNome(String nome);
}COPIAR CÓDIGO
As queries derivadas são simples, mas poderosas, e oferecem mais variações e recursos. Seguem alguns exemplos:

Usando Like
Para executar um like (e não um equals, como no exemplo), use:

List<Funcionario> findByNomeLike(String nome);COPIAR CÓDIGO
O valor do parâmetro nome deve usar o pattern, por exemplo:

String nome = "%maria%";COPIAR CÓDIGO
Starting e Ending
Você também pode buscar os funcionários pelo prefixo ou sufixo:

List<Funcionario> findByNomeEndingWith(String nome)COPIAR CÓDIGO
Ou:

List<Funcionario> findByNomeStartingWith(String nome)COPIAR CÓDIGO
Null e not Null
Igualmente podemos pesquisar elemento nulos ou não nulos:

List<Funcionario> findByNomeIsNull()COPIAR CÓDIGO
Ou não nulos com:

List<Funcionario> findByNomeIsNotNull()COPIAR CÓDIGO
Ordenação
Ainda vamos falar sobre ordenação e páginas, mas claro que a Derived Query pode dar suporte:

List<Funcionario> findByNomeOrderByNomeAsc(String nome);COPIAR CÓDIGO
Métodos longos
E como dica, como definimos os critérios de pesquisa por meio do nome do método, precisamos ter cuidado para não criar nomes gigantes e prejudicar a legibilidade. Nesse caso devemos favorecer as consultas com JPQL apresentadas no próximo vídeo.


## JPQL

Já vimos duas formas como executar consultas com Spring Data no repositório:

Derived Query Methods
métodos anotados com @Query.
Aprendemos que ao usar o Derived Query Methods o JPQL é gerado dinamicamente (ou derivado) baseado no nome do método. Não mostramos no vídeo mas claro que isso também funciona para consultas que acessam os relacionamentos!

Por exemplo, veja o método abaixo onde estamos procurando funcionários pela descrição do cargo:

//deve estar no repositório do funcionário
List<Funcionario> findByCargoDescricao(String descricao);COPIAR CÓDIGO
Repare que usamos findBy para depois definir o caminho no relacionamento CargoDescricao (a descrição é um atributo dentro do Cargo). O método é análogo ao JPQL abaixo:

@Query("SELECT f FROM Funcionario f JOIN f.cargo c WHERE c.descricao = :descricao")
List<Funcionario> findByCargoPelaDescricao(String descricao);COPIAR CÓDIGO
Ficou claro?

Agora imagina se precisa pesquisar pela descrição mas da UnidadeTrabalho. A primeira ideia seria usar o nome findByUnidadeTrabalhosDescricao(String descricao) como discutimos.

No entanto temos o problema que o nome da entidade UnidadeTrabalho é composto de duas palavras. Para separar claramente o nome da entidade do atributo devemos usar o caracter _. Veja a assinatura do método então:

List<Funcionario> findByUnidadeTrabalhos_Descricao(String descricao);COPIAR CÓDIGO
Também analisa a mesma pesquisa com JPQL e @Query:

@Query("SELECT f FROM Funcionario f JOIN f.unidadeTrabalhos u WHERE u.descricao = :descricao")
List<Funcionario> findByUnidadeTrabalhos_Descricao(String descricao);COPIAR CÓDIGO
Repare que nesse exemplo, bastante simples ainda, o nome do método já cresceu e usa uma nomenclatura fora do padrão Java. Isso é uma desvantagem dos Derived Query Methods.

Caso que precise consultas um pouco mais complexas, por exemplo usando relacionamentos e vários parâmetros, dê a preferência aos métodos com @Query para não prejudicar o entendimento pois os nomes dos métodos vão ficar muito longos para definir todos os critérios de busca. Tudo bem?

## Paginação

Nas aulas anteriores vimos como buscar funcionários pelo nome usando o método findByNome:

@Repository
public interface FuncionarioRepository extends PagingAndSortingRepository <Funcionario, Integer> {

    List<Funcionario> findByNome(String nome);

    //outros métodos omitidos
}COPIAR CÓDIGO
Será que a paginação também funciona com esse tipo de método? Claro que sim, basta passar o Pageable como parâmetro. Veja o exemplo:

@Repository
public interface FuncionarioRepository extends PagingAndSortingRepository <Funcionario, Integer> {

    List<Funcionario> findByNome(String nome);

    //novo método com paginação
    List<Funcionario> findByNome(String nome, Pageable pageable);

    //outros métodos omitidos
}COPIAR CÓDIGO
A criação do objeto Pageable fica como foi explicado no vídeo usando o PageRequest. Lembrando também que a interface FuncionarioRepository deve estender o PagingAndSortingRepository.


## Paginação - Ordenação

Quando utilizamos o repositório PagingAndSortingRepository, adicionamos à nossa aplicação todo o poder da paginação. Porém, para utilizarmos de fato esse poder, devemos passar um atributo no método findAll.
Pageable - enviamos esse objeto pois nele encapsulamos a página, a quantidade de itens por página e qual o tipo de ordenação.
Enviamos esse objeto como parâmetro para informarmos ao nosso repository as informações que queremos receber na nossa paginação.

Nesta aula aprendemos:

como paginar uma consulta dentro do framework;
a existência de um repositório específico para paginação;
cada repositório tem um propósito para existir;
ordenar nossas consultas dentro do framework.

## Projeções

Vimos em vídeo como definir uma projeção baseada na interface:

public interface FuncionarioProjecao {
    Integer getId();
    String getNome();
    Double getSalario();
}COPIAR CÓDIGO
Essa forma de projeção também é chamada de Interface based Projection.

Como alternativa, podemos também usar uma classe com o mesmo propósito:

public class FuncionarioDto {
    private Integer id;
    private String nome;
    private Double salario;

    //getter e setter

    //construtor recebendo os atributos 
    //na ordem da query
}COPIAR CÓDIGO
E no nosso repositório:

@Query(value = "SELECT f.id, f.nome, f.salario FROM funcionarios f", nativeQuery = true)
List<FuncionarioDto> findFuncionarioSalarioComProjecaoClasse();COPIAR CÓDIGO
Repare na classe FuncionarioDto como tipo genérico da lisa no retorno do método.

Uma classe dá muito mais trabalho de escrever e manter, mas pode ter uma vantagem, pois podemos adicionar métodos mais específicos que podem fazer sentido para a view (por exemplo, os de formatação).

obs.: o sufixo Dto é muito comum para esse tipo de classe auxiliar, e significa Data Transfer Object.


Nessa aula aprendemos:

o que são projeções;
como criar queries projetadas dentro do framework Spring Data;
criar uma entidade projetada para reduzir o tempo de consulta do banco de dados;
a diferença entre interface e class-based projections.


## Specification (Criteria)

Quando criamos consultas dinâmicas, utilizamos a Specification. Qual é o seu papel na criação das consultas dinâmicas?
Ter um objeto com todos os itens necessários para realizar uma consulta dinâmica, como por exemplo root, criteriaQuery e criteriaBuilder.
O objetivo é entregar, ao desenvolver um objeto pronto, para que ele só tenha que se preocupar com qual operação SQL ele deseja executar.

É importante ressaltar que o framework do Spring Data permite a utilização de banco de dados relacionais, conforme estamos aprendendo, entretanto, ele também permite o uso de banco de dados não relacionais. Vamos ver como podemos utilizar o framework com o MongoDB, considerando que existem outras possibilidades de uso para bancos não relacionais.

Quando queremos utilizar um banco de dados não relacional, não há necessidade de adicionarmos a dependência do JPA, nem mesmo do drive do banco, pois o Spring já entrega para nós uma dependência com tudo o que for necessário para acessarmos esse terminado banco. Por exemplo, o MongoDB utiliza a seguinte dependência:

<dependency>
 <groupId>org.springframework.boot</groupId>
 <artifactId>spring-boot-starter-data-mongodb</artifactId>
</dependency>COPIAR CÓDIGO
Apesar do acesso ao banco dentro do arquivo de propriedade ser bem semelhante, as tags mudam um pouco, sai o:

spring.datasource.url=jdbc:mariadb://{URL}:{PORTA}/{NOME_DO_BANCO}COPIAR CÓDIGO
E entra a tag:

spring.data.mongodb.uri: mongodb://{URL}:{PORTA}/{NOME_DO_BANCO}COPIAR CÓDIGO
obs.: Em alguns bancos não relacionais, é muito comum adicionar o usuário e senha na própria URI, entretanto o Spring também nos dá a opção de adicionarmos os valores de forma apartada:

spring.data.mongodb.username=root
spring.data.mongodb.password=root
spring.data.mongodb.database=test_db
spring.data.mongodb.port=27017
spring.data.mongodb.host=localhostCOPIAR CÓDIGO
Com a alteração para um banco de dados não relacional, deixamos de lado nosso CrudRepository, pois o Spring nos entrega um repositório específico para cada tipo de banco de dados não relacional, e dentro dele já temos todos os recursos encapsulados.

No caso do Mongo, utilizamos a interface MongoRepository. Esse repositório segue o mesmo princípio dos demais, sendo necessário passar no diamante o objeto que desejamos manipular, e o tipo do seu ID. Pronto! Basta utilizar esses passos que sua aplicação vai trabalhar perfeitamente com banco de dados não relacionais.


Nessa aula aprendemos:

criar queries dinâmicas baseada na API de Criteria do JPA;
dar ao cliente o poder de escolha sem a necessidade de alterar o código da aplicação;
como utilizar as Specification;
a praticidade de se realizar a consulta pelo framework em relação ao JPA puro.

_______________________________________________________________________________________________________________


Precisamos possibilitar a inserção, atualização, exibição e remoção de uma avaliação criada por mentores(as). Além disso, vamos querer buscar as avaliações pesquisando pelos títulos delas. 

Descreva exatamente quais passos você faria para possibilitar que tais operações fossem feitas usando o Spring Data JPA aproveitando o máximo de coisas prontas da tecnologia.
Pergunta bônus: Se você só cria interface no Spring Data JPA, onde está a real implementação?

Eu adicionaria as dependências do Spring Data no projeto como as configurações no application.properties.
Além disso, eu criaria uma classe chamada AvaliacaoRepository que extenderia a classe JpaRepository.
Dessa forma, a especificação persistence da JPA forneceria vários métodos prontos pra nós.
o findBy() e a Derived Queries poderíam ser usadas pra criar o método findByAvaliacaoTitulo() para
que o JPA criasse as queries de forma automática usando recursos da JPA/Hibernate.

Acontece que a classe JpaRepository extende diversas outras classes. Uma delas é o CrudRepository, 
outra é a própria classe Repository, que é a super classe, de onde os principais métodos e propriedades derivam e 
de onde vêem os recursos de paginação com a classe PagingAndSortingRepository.

Criar um repository herdando de CrudRepository
Peso 3: Criar um método findByTitulo ou algo parecido.




Criação de uma interface de repositório para objetos do tipo Avaliacao
Essa interface vai herdar de CrudRepository. A herança dessa interface vem do fato dela já possuir comportamentos definidos para as operações solicitadas pela funcionalidade.
Criação do método findByTitulo no repositório, para que o Spring Data JPA já derive a consulta necessária para buscar avaliações por titulo.
Sobre a pergunta bônus. Em tempo de execução, o Spring Data JPA cria uma implementação da interface que a gente define com os comportamentos corretamente implementados. É feito uso da API de Reflection e manipulação de bytecode intensiva.















