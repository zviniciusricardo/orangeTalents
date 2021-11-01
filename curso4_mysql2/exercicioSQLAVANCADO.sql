/*
	Primeiramente, eu modelaria a tabela de alunos com os seguintes dados:
	O id seria chave primária e carregaria a identidade da nossa tabela.
	O email seria marcado com a restrição de unicidade pra garantir que não
	hajam dois registros iguais no banco.
	A coluna idade carrega um check de regra de negócios não permitindo que 
	o cliente cadastre uma idade menor que zero ou maior que cem.
	O campo ativo é uma expressão booleana que, em caso de desativação por algum
	motivo, poderá ser usada em filtros para não sobrecarregar o banco e para
	sabermos qual aluno está efetivamente matriculado.
*/


create table alunos(
id integer not null primary key auto_increment,
email varchar(30) unique not null,
nome varchar(30) not null,
idade integer null,
ativo boolean default true,
check (idade > 0 and idade <= 100)
);

/*
	A tabela avaliações terá uma estrutura simples com uma primary key para 
	referência de outras tabelas complementares. Esse tipo de tabela tem o 
	nome de tabela de referência ou lookup tables.
	os campos de titulo e descrição sao varchars comuns com um tamanho apropriado.
*/


create table avaliacoes (
id integer not null primary key auto_increment,
titulo varchar(30) not null,
descricao varchar(300) not null
);


/*
	A tabela "repostas_avaliações" será gerada pelos zuppers amados em "tempo de execução", digamos assim...
	Nela, teremos um identificador pra cada resposta dada, uma chave estrangeira que identifica
	o aluno por trás daquela resposta, outra chave que liga essa resposta à sua avaliação correspondente
	É nela onde a maioria dos relacionamentos sao criados.
	Isso tem a ver com o tipo de relacionamento que cada entidade possui.
	No caso de "respostas_avaliacoes" tem relacionamento many to many onde cada resposta tem diferentes
	avaliações e diferentes alunos.
*/


create table respostas_avaliacoes (
id integer not null primary key auto_increment,
aluno_id integer not null,
avaliacao_id integer not null,
resposta blob null,
foreign key(aluno_id) references alunos(id),
foreign key(avaliacao_id) references avaliacoes(id)
);


create table resposta_mentor (
id integer not null primary key auto_increment,
resposta_id integer not null,
correcao_resposta blob null,
nota tinyint not null,
check (nota > 0 and nota <= 10),
foreign key(resposta_id) references respostas_avaliacoes(id)
);



/* PRA SABER QUAL ALUNO RESPONDEU DETERMINADA AVALIAÇÃO: 

	A estrutura DLL abaixo faz inner join em três tabelas:
	alunos, respostas_avaliacoes e avaliacoes. 
	Através da foreign key da tabela de respostas você consegue
	buscar o curso específico via cláusula "where titulo é igual à" 
	filtrar somente aqueles alunos que já responderam checando
	se o campo é diferente de null.
*/

select al.nome from alunos al
inner join respostas_avaliacoes rsp
on al.id = rsp.avaliacao_id
inner join avaliacoes av
on rsp.avaliacao_id = av.id
where av.titulo = 'Um curso foda aqui' and rsp.resposta != null;


/* PRA SABER QUANTAS RESPOSTAS FORAM DADAS POR AVALIACAO
	Seleciono os titulos referentes às avaliações e conto o numero de respostas
	totais de todos os cursos. Pra saber a qual resposta pertence a qual avaliacao,
	eu agrupo todas as respostas por "avaliação_id"(foreign key) da
	tabela resposta. Depois faço um inner join com a tabela avaliação 
	somente pra buscar o nome da avaliação e junto, quantas respostas ela teve.
	
*/

select av.titulo, count(resp.resposta) as qty_resposta from respostas_avaliacoes resp 
inner join avaliacoes av on
av.id = resp.avaliacao_id
group by avaliacao_id;


/* NOTA MÉDIA POR AVALIAÇÃO
	Seleciono a soma de todas as notas dadas à correcao_resposta (auto-avaliacao)
	dividido pela quantidade de avaliações e depois agrupo-as por id.
	Assim consigo vizualizar a média de todas as pessoas por auto-avaliação.
	
*/

select (sum(ment.nota) / count(ment.nota)) as media_por_curso from resposta_mentor ment
inner join respostas_avaliacoes respav
on ment.resposta_id = respav.id
group by respav.avaliacao_id 
order by avaliacao_id asc;pais