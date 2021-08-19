# MySQL Avançado


### Preparando o ambiente

* criar base
* Clique com o Botão da direita do mouse sobre a lista das bases e escolha Create Schema.
* download do arquivo de scripts sql
* abrir o Workbench
* painel de controle -> Administation Data Export -> selecionar o diretório onde se encontra a pasta Dump
* selecionar a base onde será exportado os arquivos
* importar

- selecionar a aba schemas
- dois cliques na base que será usada
- queries


### Usar workbench para conhecer a base

navegar pela árvore de estrutura da base no workbench
estudar os relacionamentos através das informações de pk's, fk's, triggers, procedures, etc...


Mostrar o schema da base
Barra de ferramentas > Database > Reverse Engineering


#### Queries exemplo (sintaxe)

		select * from tabela_de_produtos where not (sabor = 'manga' and tamanho = '470 ml');

		select * from tabela_de_produtos where sabor in ('laranja', 'manga');
		
		select * from tabela_de_clientes where cidade in ('Rio de Janeiro', 'São Paulo' and idade => 20);
		
#### Like

		select * from tabela_de_produtos where sabor like '%maça%'

#### Distinct

		select distinct * from tabela_de_produtos

#### Limit

		select * from table limit 5
		
		select * from table limit 2,5 --> a partir do terceiro item e mais 5
		
#### Order By

		Order by campo1, campo2


#### Group By

		
		select * from tabela_de_clientes;
		
		select estado, limite_de_credito from tabela_de_clientes;
		
		
		
		select estado, sum(limite_de_credito) as limite_total from tabela_de_clientes group by estado;
		
		retorno:
					+--------+--------------+
					| estado | limite_total |
					+--------+--------------+
					| SP     |       810000 |
					| RJ     |       995000 |
					+--------+--------------+

		select embalagem, preco_de_lista from tabela_de_produtos;
		
		select embalagem, max(preco_de_lista) as maior_preco from tabela_de_produtos group by embalagem;

					+-----------+-------------+
					| embalagem | maior_preco |
					+-----------+-------------+
					| Garrafa   |      13.312 |
					| PET       |      38.012 |
					| Lata      |        4.56 |
					+-----------+-------------+

		select embalagem, count(*) as contador from tabela_de_produtos group by embalagem;

					+-----------+----------+
					| embalagem | contador |
					+-----------+----------+
					| Garrafa   |       11 |
					| PET       |       15 |
					| Lata      |        5 |
					+-----------+----------+


		select estado, bairro, sum(limite_de_credito) as limite from tabela_de_clientes group by estado, bairro;
		
				+--------+-----------------+--------+
				| estado | bairro          | limite |
				+--------+-----------------+--------+
				| SP     | Jardins         | 480000 |
				| RJ     | Água Santa      | 100000 |
				| RJ     | Tijuca          | 315000 |
				| RJ     | Inhauma         | 110000 |
				| RJ     | Humaitá         | 170000 |
				| SP     | Lapa            |  70000 |
				| SP     | Santo Amaro     | 140000 |
				| SP     | Brás            | 120000 |
				| RJ     | Cidade Nova     | 150000 |
				| RJ     | Piedade         |  60000 |
				| RJ     | Barra da Tijuca |  90000 |
				+--------+-----------------+--------+

#### Having

		filtro do resultado de uma agregação
		
		select estado, sum(limite_de_credito) as soma_limite from tabela_de_clientes group by estado having sum(limite_de_credito) > 900000;
				+--------+-------------+
				| estado | soma_limite |
				+--------+-------------+
				| RJ     |      995000 |
				+--------+-------------+

Having é usado depois do group by... se tentar usar o where, ocorrerá um erro, pois o group by ainda não aconteceu.


		SELECT CPF, COUNT(*) FROM notas_fiscais
			WHERE YEAR(DATA_VENDA) = 2016
			BY CPF
			HAVING COUNT(*) > 2000;
				
				+-------------+----------+
				| CPF         | COUNT(*) |
				+-------------+----------+
				| 3623344710  |     2012 |
				| 492472718   |     2008 |
				| 50534475787 |     2037 |
				+-------------+----------+


#### Case

Condição parecida com o switch. Testa um ou mais campos e, dependendo do valor, teremos um ou outro resultado.


		select x,
			case
				when y >= 8 and y <= 10 then 'Ótimo'
				when y >= 7 and y < 8 then 'Bom'
				
				else 'Ruim'
			end
			from table;


		select nome_do_produto, preco_de_lista,
			case 
				when preco_de_lista >= 12 then 'produto caro'
				when preco_de_lista >= 7 and preco_de_lista < 12 then 'produto em conta'
				else 'produto barato'
			end as status_preco
		from tabela_de_produtos;
+------------------------------------------+----------------+------------------+
| nome_do_produto                          | preco_de_lista | status_preco     |
+------------------------------------------+----------------+------------------+
| Sabor da Montanha - 700 ml - Uva         |          6.309 | produto barato   |
| Linha Citros - 1 Litro - Lima/Limão      |          7.004 | produto em conta |
| Videira do Campo - 700 ml - Cereja/Maça  |           8.41 | produto em conta |
| Videira do Campo - 1,5 Litros - Melância |          19.51 | produto caro     |
| Videira do Campo - 2 Litros - Cereja/Maça|          24.01 | produto caro     |
| Festival de Sabores - 2 Litros - Açai    |         38.012 | produto caro     |
| Clean - 2 Litros - Laranja               |         16.008 | produto caro     |
+------------------------------------------+----------------+------------------+ 
	...

Exercicio case:

Veja o ano de nascimento dos clientes e classifique-os como: Nascidos antes de 1990 são velhos,
nascidos entre 1990 e 1995 são jovens e nascidos depois de 1995 são crianças. Liste o nome 
do cliente e esta classificação.

		SELECT NOME,
		CASE WHEN YEAR(data_de_nascimento) < 1990 THEN 'Velho'WHEN YEAR(data_de_nascimento) >= 1990 AND
		YEAR(data_de_nascimento) <= 1995 THEN 'Jovens' 
		ELSE 'Crianças' END
		FROM tabela_de_clientes;



### Join

		SELECT YEAR(DATA_VENDA), SUM(QUANTIDADE * PRECO) AS FATURAMENTO
		FROM notas_fiscais NF INNER JOIN itens_notas_fiscais INF 
		ON NF.NUMERO = INF.NUMERO
		GROUP BY YEAR(DATA_VENDA)



#### Union

Simula um full join --> tabelas diferentes com mesma correspondência de tipos e nº de colunas.


### Subconsultas


tabela x, y

Desafio:
Contar ocorrências de vendas por cpf(vendedores) maiores que 2000 (duas mil vendas) em 2016

			mysql> SELECT CPF, COUNT(*) FROM notas_fiscais
				->   WHERE YEAR(DATA_VENDA) = 2016
				->   GROUP BY CPF
				->   HAVING COUNT(*) > 2000;
			+-------------+----------+
			| CPF         | COUNT(*) |
			+-------------+----------+
			| 3623344710  |     2012 |
			| 492472718   |     2008 |
			| 50534475787 |     2037 |
			+-------------+----------+

mysql> select x.cpf, x.contador from(select cpf, count(*) as contador from notas_fiscais
    -> where year(data_venda) = 2016
    -> group by cpf) x where x.contador > 2000;
+-------------+----------+
| cpf         | contador |
+-------------+----------+
| 3623344710  |     2012 |
| 492472718   |     2008 |
| 50534475787 |     2037 |
+-------------+----------+


### Views

Salvar uma consulta como uma tabela. Virtualização de tabelas.
Disponibilizar dados tratados para o cliente.


### Funções com datas

SELECT CONCAT('O cliente ', TC.NOME, ' faturou ', 
CAST(SUM(INF.QUANTIDADE * INF.preco) AS char (20))
 , ' no ano ', CAST(YEAR(NF.DATA_VENDA) AS char (20))) AS SENTENCA FROM notas_fiscais NF
INNER JOIN itens_notas_fiscais INF ON NF.NUMERO = INF.NUMERO
INNER JOIN tabela_de_clientes TC ON NF.CPF = TC.CPF
WHERE YEAR(DATA_VENDA) = 2016
GROUP BY TC.NOME, YEAR(DATA_VENDA)










