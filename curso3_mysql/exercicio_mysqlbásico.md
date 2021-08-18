SQL inicial
Vinícius - Turma 8


Para criar a tabela, o seguinte script dá o nome alunos e depois configura os parâmetros de cada coluna, adicionando constraints, definindo comportamentos, chave primária, etc.
Se atentando a normalização de dados e uso correto de typos, a idade foi representada com um TINYINT e foi adicionado uma constraint que impede que valores maiores que 100 sejam cadastrados.
		
		CREATE TABLE alunos (
		id INTEGER NOT NULL AUTO_INCREMENT,
		email VARCHAR(30) UNIQUE NOT NULL,
		nome VARCHAR(30) NOT NULL,
		idade TINYINT NULL,
		PRIMARY KEY(id)
		);

		ALTER TABLE alunos 
		ADD CHECK (idade > 0 AND idade <= 100);

Caso o usuário tente inserir uma idade maior que 100, o monitor irá devolver a seguinte mensagem de erro:
		
		ERROR 3819 (HY000): Check constraint 'alunos_chk_1' is violated.

O seguinte script insere dados na tabela alunos representando somente os dados que não tenham atributos autoincrement ou mesmo que exijam a existência de um determinado campo com o NOT NULL.
As constraints de unicidade (UNIQUE) garantem que não haverá usuários repetidos na tabela.

		insert into alunos 
		(email, nome, idade) values 
		('email@zup.com.br', 'José da Silva', 34),
		('email@itau.com.br', 'Maria Antonia', 23),
		('email@jpql.com', 'John Silver', 39);


O script abaixo seleciona todos os alunos da tabela.
	
		SELECT * FROM alunos;
		
O script abaixo deleta todos os dados referentes a tabela aluno usando como filtro o nome.

		DELETE FROM alunos WHERE alunos.nome = 'Um bonito nome aqui';

O script abaixo busca por padrões de substring via regular expression para trazer todos os alunos que tenham '@zup' na coluna email.

		SELECT nome, email FROM alunos WHERE email LIKE '%@zup%';

O script abaixo seleciona as colunas nome e idade da tabela alunos e organiza em ordem crescente (ascendent). 

		SELECT nome, idade FROM alunos 
			ORDER BY idade ASC;












