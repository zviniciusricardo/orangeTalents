# Java e JPA


JDBC como funciona?
ContaDao (Data Access Object)
reflection --> criar queries DLL dinamicamente

1- Criar projeto maven
2- Criar arquivo  em src/main/resources --> META-INF --> persistence.xml 
TODAS AS ENTIDADES SERÃO ESPECIFICADAS LÁ (especificacao de CONFIGURAÇÃO DA JPA)
3- Configurar o persistence com drivers do banco usado, no caso MySQL

4- Criar a class
obs: A enumeração GenerationType.IDENTITY garante que o MySQL / MariaDB 
use uma chave sequencial do tipo auto-increment.

5- Usar todos os imports da especificação JPA

No persistence.xml, teremos uma <class> que aponta para um 
fully-qualified name do nosso modelo. Toda operação precisa de estar 
dentro de uma transação getTransaction().begin();

em.persist();

getTransaction().commit();

Os estados de uma entidade são: Managed, Detached, Transient e Removed
Os métodos do EntityManager, como persist, merge ou remove alteram 
o estado da entidade

		import javax.persistence.Entity;
		import javax.persistence.GeneratedValue;
		import javax.persistence.GenerationType;
		import javax.persistence.Id;

		@Entity
		public class Aluno {
			@Id
			@GeneratedValue(strategy = GenerationType.IDENTITY)
			private Long id;
			@Column(unique=true, nullable=false)
			private String email;
			@Column(nullable=false)
			private String nome;
			@Min(1)
			@Max(100)
			private Integer idade;
		}

TRABALHAR COM DINHEIRO - BIGDECIMAL TYPE

Relacionamentos entre entidades precisam ser configurados pelas anotações no atributo 
que define o relacionamento na classe. Um relacionamento do tipo Muitos-para-Um
deve usar anotação a @ManyToOne. A anotação @ManyToOne causa a criação de uma 
chave estrangeira A JPA carrega automaticamente o relacionamento ao carregar a entidade


Por convenção, o Hibernate ainda precisará usar o construtor padrão da categoria para instanciar 
seus objetos; então o criaremos sem argumentos na classe Categoria que não executará nenhuma ação.

Para indicar que este construtor será usado somente para a infraestrutura e não pelos desenvolvedores,
escreveremos a anotação @Deprecated.


Como relacionar uma entidade com uma coleção de uma outra entidade
Para tal, temos as anotações @OneToMany e @ManyToMany, dependendo da cardinalidade
Um relacionamento @ToMany precisa de uma tabela extra para a representação no banco de dados
Aprendemos também como relacionar uma entidade com uma outra entidade
Para tal, temos as anotações @OneToOne e @ManyToOne, dependendo da cardinalidade
Ao persistir uma entidade, devemos persistir as entidades transientes do relacionamento


JPA CRITERIA ---> QUERIES DINÂMICAS
JPQL --> ESCREVER QUERY OOP (CLASSES, ATRIBUTOS E RELACIONAMENTOS)
OUTRAS USAM TABELAS E COLUNAS


O dialeto também serve como forma de escolhermos recursos do banco que serão usados. Por exemplo, no MySQL, podemos utilizar o MyISAM (storage strategy), que não possui transações e integridade referencial (foreign key constraint).


Relatório com 5 campos onde ele pode pesquisar pelo relatório de forma dinâmica.

Specification --> consultas dinâmicas no Spring Data;
Se depende do input do usuário Criteria e/ou Specification;

JPQL é orientado a objetos, enquanto SQL não

JPQL - Java Persistence Query language
usa o nome das classes e atributos ao invés de tabelas e colunas
Quem usa o jpql é o EntityManager




Quando trabalhamos com JDBC, usamos parâmetros para não precisar concatenar String na query.
Dessa forma, o próprio JDBC é capaz de validar os dados entrados pelo usuário, evitando assim 
SQL Injection. Na prática, teremos algo assim:


		PreparedStatement ps = conn.prepareStatement("select * from Usuario where id = ?");
		ps.setInt(1, usuario.getId());




TesteJPQL

public class TesteJPQLMovimentacaoDeUmaCategoria {
    public static void main(String[] args) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("alura");
        EntityManager em = emf.createEntityManager();

        String sql = "select m from Movimentacao m join m.categorias c  where c = :pCategoria";

        Categoria categoria = new Categoria();
        categoria.setId(2L);

        TypedQuery<Movimentacao> query = em.createQuery(sql, Movimentacao.class);
        query.setParameter("pCategoria", categoria);

        List<Movimentacao> movimentacoes = query.getResultList();
        for (Movimentacao movimentacao : movimentacoes) {
            System.out.println("Descrição: " + movimentacao.getDescricao());
            System.out.println("Valor: " + movimentacao.getValor());
            System.out.println("Tipo: " + movimentacao.getTipoMovimentacao());
        }
    }
}


Categoria viagem = ...
Query query = 
    em.createQuery("select m from Movimentacao m join m.categoria c where c = :pCategoria and m.valor > 500 and m.tipoMovimentacao = :pTipoMovimentacao");
query.setParameter("pCategoria", viagem);
query.setParameter("pTipoMovimentacao", TipoMovimentacao.SAIDA);

Alternativa correta! Dessa forma, traremos as movimentações de saída que são mais caras do que R$ 500 e são relacionadas com viagem.

A linguagem JPQL é bem parecida com SQL, no entanto orientada a objetos
Com JPQL, usamos as classes e atributos (no lugar das tabelas e colunas) para definir a pesquisa
O objeto do tipo javax.persistence.Query encapsula a query
javax.persistence.TypedQuery é a versão tipada do javax.persistence.Query



A lição mais importante do curso é que trabalhar com JPA é também se afastar ao máximo do mundo relacional.

Para isso, vimos várias abstrações do banco de dados criadas pela JPA que nos permite trabalhar no mundo orientado a objetos que é sincronizado automaticamente com o banco.

Então pudemos ver que todas as querys criadas pela JPA são consequência das transições de estado, e não de analogias com persist(), insert() e update() comumente difundidas.

Também aprendemos como mapear relacionamentos entre as classes e como sincronizá-los com o banco e refleti-los na tabela.

Vimos como criar as tabelas usando JPA e as querys mais alto nível utilizando JPQL, sem precisarmos conhecer a fundo os detalhes dos relacionamentos entre as tabelas.

Basta somente conhecermos os relacionamento entre as nossas classes e objetos.


a method annotated as @Transient, and will be ignored by the entity manager.















