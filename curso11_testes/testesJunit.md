## Curso de Testes com Junit
<b>Usando Junit Framework para testes de unidade</b>

### 3 Passos - AAA

		Cenário | Acção | validação

<b>Constraints:</b>

* Toda classe de testes é public e void
* Classe Assert serve para conferir o resultado esperado


Assery.Equals(int VALOR_ESPERADO, int VALOR_CALCULADO, 0.00001) 
		// --> 0.00001 é um delta (serve para aceitar margem de erro no tipo Double)
		// --> Todos os testes similares tem essa ordem dos parâmetros nos métodos Assert
		// primeiro o valor esperado, depois o valor calculado


> Números de ponto flutuante (float e double), ao contrário de números inteiros, raramente representam números exatos, mas sim números dentro de um determinado limite de precisão.

Além disso, alguns números de ponto flutuante são representados como dízimas periódicas quando convertidos para binário. Por isso, pode ocorrer ainda algum arredondamento no dígito menos significativo.


### A classe		
		
		class Avaliador {

			private double maiorDeTodos = Double.NEGATIVE_INFINITY;
			private double menorDeTodos = Double.POSITIVE_INFINITY;

			public void avalia(Leilao leilao) {

				for(Lance lance : leilao.getLances()) {
					if(lance.getValor() > maiorDeTodos) maiorDeTodos = lance.getValor();
					if(lance.getValor() < menorDeTodos) menorDeTodos = lance.getValor();
				}
			}

			public double getMaiorLance() { return maiorDeTodos; }
			public double getMenorLance() { return menorDeTodos; }
		}
		
		
### O Teste:
		
		import org.junit.Assert;

		public class AvaliadorTest {

			@Test
			public void deveEntenderLancesEmOrdemCrescente() {
				// cenario: 3 lances em ordem crescente
				Usuario joao = new Usuario("Joao");
				Usuario jose = new Usuario("José");
				Usuario maria = new Usuario("Maria");

				Leilao leilao = new Leilao("Playstation 3 Novo");

				leilao.propoe(new Lance(maria,250.0));
				leilao.propoe(new Lance(joao,300.0));
				leilao.propoe(new Lance(jose,400.0));

				// executando a acao
				Avaliador leiloeiro = new Avaliador();
				leiloeiro.avalia(leilao);

				// comparando a saida com o esperado
				double maiorEsperado = 400;
				double menorEsperado = 250;

				Assert.assertEquals(maiorEsperado, leiloeiro.getMaiorLance(), 0.0001);
				Assert.assertEquals(menorEsperado, leiloeiro.getMenorLance(), 0.0001);
			}
		}
		
		
		
## Testar somente o necessário

Regra: escreva um teste por ordem de equivalência
* Ordem crescente,
* ordem decrescente
* ordem randômica
* apenas 1 lance


TESTES DE REGRESSÃO SÃO IMPORTANTES


### Ao testar uma lista, quantas verificações (quantidade de asserts) geralmente fazemos?

1 + N, onde o primeiro é para garantir o tamanho da lista, e depois N asserts para garantir o 
conteúdo interno completo dessa lista

		Precisamos sempre garantir todo o conteúdo da lista retornada. Veja que só garantir o tamanho 
		da lista não nos ajuda muito, afinal a lista pode ter o tamanho certo, mas ter o conteúdo inválido.

		Tratar o caso da lista com um elemento separado do caso da lista com vários elementos faz todo sentido. É muito comum, durante a implementação, pensarmos direto no caso complicado, e esquecermos de casos simples, mas que acontecem. Por esse motivo é importante testarmos esses casos.

		Quando lidamos com listas, por exemplo, é sempre interessante tratarmos o caso da lista cheia, da lista com apenas um elemento, e da lista vazia.

		Se estamos lidando com algoritmos cuja ordem é importante, precisamos testar ordem crescente, decrescente, e randômica.

		Um código que apresente um if(salario>=2000), por exemplo, precisa de três diferentes testes:

		Um cenário com salário menor do que 2000
		Um cenário com salário maior do que 2000
		Um cenário com salário igual a 2000
		Afinal, quem nunca confundiu um > por um >= ?

		#####################################################################
		##### O grande desafio da área dos testadores é encontrar todos #####
		##### as classes de equivalência; tarefa essa que não é fácil ! #####
		#####################################################################

		public class Avaliador {

			private double maiorDeTodos = Double.NEGATIVE_INFINITY;
			private double menorDeTodos = Double.POSITIVE_INFINITY;
			private List<Lance> maiores;

			public void avalia(Leilao leilao) {
				for(Lance lance : leilao.getLances()) {
					if(lance.getValor() > maiorDeTodos) maiorDeTodos = lance.getValor();
					if (lance.getValor() < menorDeTodos) menorDeTodos = lance.getValor();
				}

				pegaOsMaioresNo(leilao);
			}

			private void pegaOsMaioresNo(Leilao leilao) {
				maiores = new ArrayList<Lance>(leilao.getLances());
				Collections.sort(maiores, new Comparator<Lance>() {
					public int compare(Lance o1, Lance o2) {
						if(o1.getValor() < o2.getValor()) return 1;
						if(o1.getValor() > o2.getValor()) return -1;
						return 0;
					}
				});
				maiores = maiores.subList(0, maiores.size() > 3 ? 3 : maiores.size());
			}

			public List<Lance> getTresMaiores() {
				return this.maiores;
			}

			public double getMaiorLance() {
				return maiorDeTodos;
			}

			public double getMenorLance() {
				return menorDeTodos;
			}
		}

* Um leilão com 5 lances, deve encontrar os três maiores
* Um leilão com 2 lances, deve devolver apenas os dois lances que encontrou
* Um leilão sem nenhum lance, devolve lista vazia


		@Test
		public void deveEncontrarOsTresMaioresLances() {
		    Usuario joao = new Usuario("João");
		    Usuario maria = new Usuario("Maria");
		    Leilao leilao = new Leilao("Playstation 3 Novo");

		    leilao.propoe(new Lance(joao, 100.0));
		    leilao.propoe(new Lance(maria, 200.0));
		    leilao.propoe(new Lance(joao, 300.0));
		    leilao.propoe(new Lance(maria, 400.0));

		    Avaliador leiloeiro = new Avaliador();
		    leiloeiro.avalia(leilao);

		    List<Lance> maiores = leiloeiro.getTresMaiores();

		    assertEquals(3, maiores.size());
		    assertEquals(400, maiores.get(0).getValor(), 0.00001);
		    assertEquals(300, maiores.get(1).getValor(), 0.00001);
		    assertEquals(200, maiores.get(2).getValor(), 0.00001);
		}

		@Test
		public void deveDevolverTodosLancesCasoNaoHajaNoMinimo3() {
		    Usuario joao = new Usuario("João");
		    Usuario maria = new Usuario("Maria");
		    Leilao leilao = new Leilao("Playstation 3 Novo");

		    leilao.propoe(new Lance(joao, 100.0));
		    leilao.propoe(new Lance(maria, 200.0));

		    Avaliador leiloeiro = new Avaliador();
		    leiloeiro.avalia(leilao);

		    List<Lance> maiores = leiloeiro.getTresMaiores();

		    assertEquals(2, maiores.size());
		    assertEquals(200, maiores.get(0).getValor(), 0.00001);
		    assertEquals(100, maiores.get(1).getValor(), 0.00001);
		}

		@Test
		public void deveDevolverListaVaziaCasoNaoHajaLances() {
		    Leilao leilao = new Leilao("Playstation 3 Novo");

		    Avaliador leiloeiro = new Avaliador();
		    leiloeiro.avalia(leilao);

		    List<Lance> maiores = leiloeiro.getTresMaiores();

		    assertEquals(0, maiores.size());
		}


Sem uma bateria de testes, dificilmente pegaríamos esse bug em tempo de desenvolvimento. Testes manuais são caros e, por esse motivo, o desenvolvedor comumente testa apenas a funcionalidade atual, deixando de lado os TESTES DE REGRESSÃO (ou seja, testes para garantir que o resto do sistema ainda continua funcionando mesmo após a implementação da nova funcionalidade).


## Cuidando dos testes

TEST DATA BUILDERS - Montam cenários para testes - código que se repete
@BeforeEach serve para dizermos para o Junit executar aquele treche de codigo anotado antes de todos
os nossos métodos de teste

Ao contrário do @Before, métodos anotados com @After são executados após a execução do método de teste.

Utilizamos métodos @After quando nossos testes consomem recursos que precisam ser finalizados. 
Exemplos podem ser testes que acessam banco de dados, abrem arquivos, abrem sockets, e etc.

(Apesar desses testes não serem mais considerados testes de unidade, afinal eles falam com outros sistemas, desenvolvedores utilizam JUnit para escrever testes de integração. Os mesmos são discutidos no curso online de Testes de Integração).


## Passo a passo

1. Pensar nos possíveis cenários para um método de classe. Qual deve ser o comportamento esperado?
Baby steps
2. Criar uma classe de teste e fazê-la falhar
3. Validar pensar em testes de ordem de equivalência (testes essenciais, testes genéricos que servem pra todos os casos)
4. Construir um caso mais simples possível que o faça passar.
5. Refatorar o código repetitivo criando TEST DATA BUILDERS e usando notações do Junit @BeforeEach e @After

### @BeforeClass e @AfterClass

Executa só uma vez antes e depois da classe inteira de testes.
Serve para utilizar recursos únicos que serão usados por todos os métodos


## Testando exceções

Tratar exceções:

		@Test(expected = RunTimeException.class)
		public void nãoDeveAceitarDeterminadaSaída() {
			
			// Substitui o try cat e o throws
		}


## Hamcrest

Nos dá pequenos métodos que facilitam a legibilidade dos testes

		assertThat()

O Hamcrest é extremamente flexível. Matchers como equalTo(), hasItems, e etc, podem ser criados!

Possível criar matchers customizados ![aqui](http://jmock.org/custom-matchers.html, "Matchers customizáveis").



## Resposta formulário 1

Provavelmente eu pensaria nos casos de uso que minha classe tenta suprir, avaliando qual seria o 
comportamento ideal dela no contexto da aplicação.
Toda questão é feita por alguém, pra começar. Sendo assim, toda resposta, precisa de um aluno que a responda.
Da mesma forma precisa haver uma avaliação da qual essa resposta pertence, no caso, pensando nos moldes do Orange.

Todas os desvios de fluxo, apresentam a mesma exceção, então seria legal criar uma classe TesteRespostaQuestão
e anotála com 

		@Test(expected = IllegalArgumentoException)
		public void TesteRespostaQuestao() {			
		}

Dessa forma, todos os argumentos seriam tratados como se esperassem essa saída caso a exceção esperada
aconteça.
Criar métodos que sintetizem a essência e a intenção da classe
O teste para saber se existem duas respostas do mesmo aluno para a mesma questão, saber se aquela resposta
pertence àquela avaliação, e se aquela avaliação pertence a aquele mesmo aluno.
Testar se avaliação, aluno e nota são validos e possuem todas as características que classes desse tipo 
devem ter (se falta algum atributo, o se o objeto é uma instância da classe referente à esperada no método)
Depois disso eu criaria pequenos métodos que simulassem um determinado caso de uso daquele método.
Caso o meu caso de uso use algum recurso de outras classes, invocá-los usando @BeforeEach ou @After em casos
onde eu queira executar a mesma ação antes de cada teste.
Depois disso, simularia as condições em que o teste falha e o faria falhar.
Logo após, eu criaria o código mais simples que o faria passar
Depois disso, eu validaria as saídas e criticaria o teste pra saber se ele realmente cobre 
a maioria dos casos de uso
Após tudo validado, eu procuraria refatorar o código usando bibliotecas como Hamscrest e extraindo
sentenças complicadas pra métodos separados, encapsulando e desacoplando o código fazendo com que 
os testes possam progredir junto com a aplicação.

Algumas anotações podem nos ajudar a automatizar tarefas antes e depois de cada teste usando a anotação
@BeforClass e/ou @AfterClass


Cenário:

Dentro do nosso programa de treinamento, temos um momento onde a pessoa responde uma avaliação de auto percepção para o determinado curso que ela acabou. Nessa avaliação a pessoa responde várias questões. Cada questão tem uma nota que vai de 0 a 10. Para representar a resposta por questão na aplicação, imagine que criamos a classe RespostaQuestao. O construtor dessa classe é da seguinte forma:

class RespostaQuestao {

   private Avaliacao avaliacao;

   private Aluno aluno;

   private int nota;


   //construtor

   public RespostaQuestao(Avaliacao avaliacao,Aluno aluno,int nota){

       if(avaliacao == null){

           throw new IllegalArgumentoException("A avaliação não pode ser nula");

       }
       if(aluno == null){

           throw new IllegalArgumentoException("O aluno não pode ser nula");
       }

       if(nota < 0){

           throw new IllegalArgumentoException("A nota não pode ser menor que zero");
       }

       if(nota > 10){

           throw new IllegalArgumentoException("A nota não pode ser maior que10");
       }
      //resto do código de atribuição aqui
   }

}


Descreva os testes automatizados que você vai escrever para aumentar a confiabilidade deste código.
O que seria bom ver nessa resposta?

Peso 1.5: Teste da avaliação nula
Peso 1.5: Teste do aluno nulo
Peso 1.5: Teste da avaliação com nota zero ou maior que zero
Peso 1.5: Teste da avaliação com nota 10 ou menor que 10
Peso 1.5: Teste da avaliação com nota menor que zero
Peso 1.5: Teste da avaliação com nota maior que dez
Peso 1: Utilização do expect de exceptions para cuidar dos testes que lançam
Peso 1: Utilização do assert para verificar os valores atribuídos.

Resposta do Especialista:

Crio a classe AvaliacaoTest

O primeiro teste é um que passa uma avaliação nula. Uso a funcionalidade do Junit de fazer o expect da Exception.
O segundo teste eu passo uma avaliação correta e um aluno nulo. Uso a funcionalidade do Junit de fazer o expect da Exception.
O terceiro teste eu passo uma avaliação correta, aluno correta e a nota -1. Uso a funcionalidade do Junit de fazer o expect da Exception.
O quarto teste eu passo uma avaliação correta, aluno correta e a nota 11. Uso a funcionalidade do Junit de fazer o expect da Exception.
O quinto teste eu passo uma avaliação correta, aluno correta e a nota 0. Uso os asserts do Junit para verificar os valores que foram atribuídos
O sexto teste eu passo uma avaliação correta, aluno correta e a nota 10. Uso os asserts do Junit para verificar os valores que foram atribuídos


## Mockito: Testes de comportamentos automatizados

É impossível mockar métodos estáticos!

Por esse motivo, desenvolvedores fanáticos por testes evitam ao máximo criar métodos estáticos!

Fuja deles! Além de serem difíceis de serem testados, ainda não são uma boa prática de orientação a objetos.

A grande vantagem é trabalhar sempre voltado para interfaces, que é um importante princípio de orientação a objetos.

Sempre que for trabalhar com mocks, pense em criar interfaces entre suas classes. Dessa forma, seu teste e código passam a depender apenas de um contrato, e não de uma classe concreta


Devemos evitar a quebra de testes quando uma nova dependência aparece. Para isso, precisamos usar boas práticas de testes de unidade, como o uso do @Before, que o JUnit oferece. Essas boas práticas são estudadas no curso de testes de unidade e TDD.

O teste falha, mas porque o Mockito não consegue fazer com que o método lance Exception.

Exception é uma exceção checada no Java, e seu lançamento precisa ser explicitamente declarado, o que não acontece no método envia() do EnviadorDeEmail.

Por esse motivo a mensagem de erro do teste é: org.mockito.exceptions.base.MockitoException: Checked exception is invalid for this method!. Ou seja, o Mockito percebe isso e falha o teste!

Fique sempre atento às exceções que seu método pode lançar.


### Testes de Integração

Um teste de unidade isola a classe de suas dependências, e a testa independente delas. Testes de unidade fazem sentido quando nossas classes contém regras de negócio, mas dependem de infra estrutura. Nesses casos, fica fácil isolar a infra estrutura.

Já testes de integração testam a classe de maneira integrada ao serviço que usam. Um teste de DAO, por exemplo, que bate em um banco de dados de verdade, é considerado um teste de integração. Testes como esses são especialmente úteis para testar classes cuja responsabilidade é se comunicar com outros serviços.

Por que precisamos fechar a Session ao final do teste?
para que o banco de dados libere essa porta para um próximo teste. Não fechar a sessão pode implicar em problemas futuros, como testes que falham ou travam. Lembre-se sempre de fechar a conexão.

Podemos fazer diversas coisas ao final de cada teste. Mas uma coisa que geralmente não é opcional é limpar o banco de dados para que o próximo teste consiga executar sem problemas.

Fazemos isso dando rollback no banco de dados, ou mesmo executando uma sequência de TRUNCATE TABLEs. Você pode escolher qual maneira agrada mais!

Precisamos forçar o Hibernate a enviar comandos para o banco de dados, e garantir que as próximas consultas levarão em consideração as anteriores. Para isso, o flush() torna-se obrigatório em alguns testes!

Geralmente em testes que fazemos SELECTs logo após uma deleção ou alteração em batch, o uso do flush é obrigatório.

O que você acha de testar métodos de alteração?
Tudo é questão de feedback. Eles podem fazer sentido quando o processo de alteração é complicado. Por exemplo, atualizar um usuário é bem simples e feito pelo próprio Hibernate. Não há muito como dar errado.

Agora, atualizar um leilão pode ser mais trabalhoso, afinal precisamos atualizar lances juntos. Nesses casos, testar uma alteração pode ser bem importante.

Quais são os problemas de se usar mocks (e simular a conexão com o banco de dados) para testar Repositories?
Ao usar mocks, estamos "enganando" nosso teste. Um bom teste de DAO é aquele que garante que sua consulta SQL realmente funciona quando enviada para o banco de dados; e a melhor maneira de garantir isso é enviando-a para o banco!

Repare que, na explicação, quando usamos mock objects, nosso teste passou, mesmo estando com bug! Testes como esses não servem de nada, apenas atrapalham.

Sempre que tiver classes cuja responsabilidade é falar com outro sistema, teste-a realmente integrando com esse outro sistema.


Tipos de Itegrações

Com o banco de dados
com API's externas
Integração com outro módulo
Integração com serviços (mensageria, kafka, etc)



		public class RespostaRepository {
			private EntityManager manager;
		   
			RespostaRepository(EntityManager manager){
				this.manager = manager;
		   	}
			
			public Collection<Resposta> buscaRespostas(Long idAluno){
				return manager.createQuery("select r from Resposta r where r.aluno.id =    :idAluno",Resposta.class)
						.setParameter("idAluno",idAluno)
						.getResultList();
			}

		}



## Testes de Integração

Formulário resposta:

Teste de unidade precisa representar o estado real da ação. Ele é interdependende
dos serviços externos com os quais se relaciona.

Caso banco de dados:
* preciso representar as entidades reais (DAOs ou Repositories) para executar a ação;
* preciso realmente "salvar" ou ir até o banco pra saber se o usuário foi ou não foi encontrado
* se ele foi ou não foi salvo

* Unit Testing with Spring Boot
* Testing Spring MVC Web Controllers with @WebMvcTest
* Testing JPA Queries with Spring Boot and @DataJpaTest
* Integration Tests with @SpringBootTest




		@RunWith(SpringRunner.class)
		@DataJpaTest
		public void RespostaRepositoryTeste() {
			
			private TestEntityManager testManager;
			private Aluno aluno;
			private Avaliacao avaliacao;
			private Resposta resposta;
			
			@Test
			void DeveRetornarUmaListaNaoNulaDeRespostasDeUmAluno() {
				
				private Aluno aluno = new Aluno("vinicius@email.com","Vinicius Ricardo");
			
				private Avaliacao avaliacao = new Avaliacao("Bases React");
				private Avaliacao avaliacao2 = new Avaliacao("Bases Angular");
				
				private Resposta reposta = new Resposta( 1, 1, "Bases React", "A resposta é a letra B!" );
				private Resposta reposta2 = new Resposta( 2, 1, "Bases Angular", "A resposta é a letra D!" );
				
				private List<Resposta> listaRespostas = new ArrayList<Resposta>();
								
				manager.persist(aluno);
				manager.persist(avaliacao);
				manager.persist(avaliacao2);
				manager.persist(resposta);
				manager.persist(resposta2);
				
				manager.flush();
				
				listaRespostas = manager.findAll(Resposta.class, resposta.getAlunoId());
				
				assertThat(manager.findAll(Resposta.class, resposta.getAlunoId())
						.isEqualTo(ListaRespostas.toArray());		
			}
			

Primeiro de tudo é observar que esse é um teste de integração.
Sendo assim, precisamos subir o contexto do Spring e do DataJpaTest

		@RunWith(SpringRunner.class)
				@DataJpaTest
				public void RespostaRepositoryTeste() {
					
					private TestEntityManager testManager;
					private Aluno aluno;
					private Avaliacao avaliacao;
					private Resposta resposta;
					
Usaremos também o TestEntityManager para testar as queries em um "in memory database".
Depois criaremos o arranjo do teste instanciando objetos da classe Aluno, Avaliacao e Resposta.
Preenchemos todos os atributos necessários pelo construtor e depois persistimos esses objetos
Usamos o manager.flush() para que o EntityManager não guarde os objetos em memória para que depois
possamos buscá-los no banco com o managerTest.findAll(Resposta.class, resposta.getAlunoId());

Essa parte do código poderia ser tranferida para o método de setup;

		@Before
		public void setup() { }
		
Depois criaremos uma querie que simule a busca da lista de respostas.
Podemos testar se o id do Aluno é um id válido. Se não, um ArgumentNotValidException ou NullPointerException
podem ser assertados.
Podemos depois conferir o tamanho da lista caso a quantidade de respostas seja maior que zero.

		// o arranjo deve estar aqui em cima...

		public void DeveRetornarUmaLitaNaoNulaDeRespostas() {

			assertThat(manager.findAll(Resposta.class, resposta.getAlunoId())
				.isEqualTo(ListaRespostas.toArray());
		}

Podemos testar também se existe um aluno com aquele Id, se aquele aluno tem Avaliações e se as avaliações
tem respostas.	



Primeiramente eu usaria o Structural Tests + branches porque creio que o caso indicado pede tanto
cobertura por linha quanto por condicionais. Visto que o caso indicado, o primeiro bloco de código
apresenta até 5 possibilidades de resultados e o segundo bloco, até 7 resultados diferentes, o ideal
seria que abordássemos as duas técnicas para que essa feature seja coberta ao máximo por apresentar
uma instabilidade no resultado final.

No método aceitaPalavra(String str) { }, dentro do primeiro bloco de código:

Se a String é nula
Se a String é vazia
Se o tamnaho da String é menor que 5 (igual à 4, por exemplo)
Se o tamanho da String é igual à 5
Se o tamanho da String é maior que 5

					
No segundo bloco, na codicional if(Character.isLetter())
							
Se o primeiro caracter é uma letra e termina com 's';
Se o primeiro caracter é uma letra e tem tamanho maior ou igual à dez
Se o primeiro caracter é uma letra, não termina em "s" e tem tamanho menor que dez.
Se o primeiro caracter é uma letra, termina em 's' e tem tamanho igual ou maior à dez.
Se o primeiro caracter é uma letra, não termina em 's' e tem valor menor que dez
Se o primeiro caracter é uma letra, não termina em 's' e não tem valor menor que dez.
Se o primeiro caracter não é uma letra
							
							

Especialista:

Conteúdo mais profundo sobre testes



Cenário:

Descreva quais testes você faria para o método abaixo.
O que seria bom ver nessa resposta?

Peso 6: Quatro testes ou mais por conta da utilização do MC/DC ou Path Coverage com técnica de cobertura.
Peso 2: Utilização do valor 5 e 4 para testar os valores no segundo if
Peso 2: Utilização dos valores 9 e 10 por conta do boundary testing no segundo if

Resposta do Especialista:

Para o primeiro if
Já pensei que teria que fazer 3 testes. Por conta do MC/DC
Um teste com string nula
Um teste com string de 4 caracteres
Um teste com string de 5 caracteres
Para o segundo if
Já pensei que teria que fazer 4 testes. Por conta do MC/DC
Montei a tabela verdade com as condições
Preciso descobrir os pares que me permitem inverter o resultado de uma das condições e que afete o resultado da expressão como um todo

		Tests        a          b         c          resultado

			1        T          T         T        	T                    

			2        T          T        F         	T                    

			3        T          F        T        	T                    

			4        T          F        F        	F                    

			5        F          T        T        	F                    

			6        F          T        F        	F                    

		7        F        F        T        F

		8        F        F        F        F


* a -> (1,5),(2,6),(3,7) -> altero só o a e muda o resultado da expressão

* b -> (2,4) -> altero só o b e muda o resultado da expressão

* c -> (3,4)  -> altero só o c e muda o resultado da expressão


  Possíveis resultados:


* 2,3,4,6
* 3,7,2,4
* 1,5,2,4,3 (tem mais testes do que precisa para o mc/dc)

Testes derivados usando a combinação de MC/DC e boundary testing.


* 2 - Palavra começando com letra, terminando com s e com tamanho 9

* 3 - Palavra começando com letra, terminando com y e com tamanho 10

* 4 - Palavra começando com letra, terminando com y e com tamanho 9

* 6 - Palavra começando com número, terminando com s e com tamanho 9

































