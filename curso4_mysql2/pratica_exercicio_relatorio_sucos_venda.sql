Relatorio de venda de Sucos


Volume de compra - total máximo por mês de compras

juntar a tabela

		itens_notas_fiscais
				com
		notas_fiscais
		
		* na tabela notas_fiscais eu tenho o id do cliente (cpf)
		* na tabela itens_notas_fiscais eu tenho a quantidade


RELATÓRIO

select nf.cpf, nf.data_venda, inf.quantidade from notas_fiscais
nf inner join itens_notas_fiscais inf 
on nf.numero = inf.numero 
limit 35;


quanto eu vendi em termos de quantidade para cada cliente dentro de um mês
notas fiscais + itens

+-------------+------------+------------+
| cpf         | data_venda | quantidade |
+-------------+------------+------------+
| 7771579779  | 2015-01-01 |         63 |
| 7771579779  | 2015-01-01 |         26 |
| 7771579779  | 2015-01-01 |         67 |
| 7771579779  | 2015-01-01 |         66 |
| 50534475787 | 2015-01-01 |         35 |
| 50534475787 | 2015-01-01 |         65 |
| 8502682733  | 2015-01-01 |         84 |
| 8502682733  | 2015-01-01 |         37 |
| 8502682733  | 2015-01-01 |         74 |
| 5840119709  | 2015-01-01 |         29 |
| 1471156710  | 2015-01-01 |         66 |
| 94387575700 | 2015-01-01 |         98 |
| 94387575700 | 2015-01-01 |         57 |
| 94387575700 | 2015-01-01 |         82 |
| 3623344710  | 2015-01-01 |         19 |
| 3623344710  | 2015-01-01 |         11 |
| 3623344710  | 2015-01-01 |         24 |
| 5576228758  | 2015-01-01 |         91 |
| 5576228758  | 2015-01-01 |         12 |
| 5576228758  | 2015-01-01 |         60 |
| 19290992743 | 2015-01-01 |         70 |
| 94387575700 | 2015-01-01 |         18 |
| 94387575700 | 2015-01-01 |         85 |
| 94387575700 | 2015-01-01 |         11 |
| 5840119709  | 2015-01-01 |         24 |
| 5840119709  | 2015-01-01 |         24 |
| 5840119709  | 2015-01-01 |         84 |
| 492472718   | 2015-01-01 |         28 |
| 5840119709  | 2015-01-01 |         20 |
| 5840119709  | 2015-01-01 |         73 |
| 5840119709  | 2015-01-01 |         87 |
| 5840119709  | 2015-01-01 |         38 |
| 50534475787 | 2015-01-01 |         15 |
| 50534475787 | 2015-01-01 |         55 |
| 50534475787 | 2015-01-01 |         88 |
+-------------+------------+------------+


		select * from itens_notas_fiscais;

		select * from notas_fiscais;

		select * from notas_fiscais nf
		inner join itens_notas_fiscais inf
		on nf.numero = inf.numero;

/*		cliente = cpf
		data = data_venda (a data é diária)
		quantidade = quantidade*/

		select nf.cpf, nf.data_venda, inf.quantidade from notas_fiscais
		nf inner join itens_notas_fiscais inf 
		on nf.numero = inf.numero;



/* 		PRIMEIRA CONSULTA - VENDAS DE CLIENTES/MÊS 
		precisamos separar a data_venda retirando o dia para fazer a soma */
		
		select nf.cpf, DATE_FORMAT(nf.data_venda, '%Y-%m') AS MES_ANO,
		SUM( inf.quantidade) AS QUANTIDADE_VENDAS from notas_fiscais nf
		inner join itens_notas_fiscais inf 
		on nf.numero = inf.numero
		GROUP BY nf.cpf, DATE_FORMAT(nf.data_venda, '%Y-%m');


/* 		LIMITE DE COMPRA POR CLIENTE < 2000/MÊS */

		select * from tabela_de_clientes tc;

		select tc.cpf, tc.nome, tc.volume_de_compra as quantidade_limite
		from tabela_de_clientes tc;


		select nf.cpf, tc.nome, date_format(nf.data_venda, '%Y-%m') as mes_ano,
		sum(inf.quantidade) as quantidade_vendas,
		max(tc.volume_de_compra) as quantidade_limite from notas_fiscais nf
		inner join itens_notas_fiscais inf 
		on nf.numero = inf.numero
		inner join tabela_de_clientes tc
		on tc.cpf = nf.cpf
		GROUP BY nf.cpf, tc.nome, DATE_FORMAT(nf.data_venda, '%Y-%m');


		select x.cpf, x.nome, x.mes_ano, x.quantidade_vendas, x.quantidade_limite, 
		x.quantidade_limite - x.quantidade_vendas as diferenca,
		case 
			when (x.quantidade_limite - x.quantidade_vendas) < 0 then 'INVÁLIDA'
			else 'VÁLIDA' END as status_venda
		from (

		select nf.cpf, tc.nome, date_format(nf.data_venda, '%Y-%m') as mes_ano,
		sum(inf.quantidade) as quantidade_vendas,
		max(tc.volume_de_compra) as quantidade_limite from notas_fiscais nf
		inner join itens_notas_fiscais inf 
		on nf.numero = inf.numero
		inner join tabela_de_clientes tc
		on tc.cpf = nf.cpf
		GROUP BY nf.cpf, tc.nome, DATE_FORMAT(nf.data_venda, '%Y-%m')) x;



/*		RETIRANDO O CAMPO diferença DA TABELA, POIS NÃO PRECISAMOS MAIS DELE*/
		
		select x.cpf, x.nome, x.mes_ano, x.quantidade_vendas, x.quantidade_limite,
		case 
			when (x.quantidade_limite - x.quantidade_vendas) < 0 then 'INVÁLIDA'
			else 'VÁLIDA' END as status_venda
		from (

		select nf.cpf, tc.nome, date_format(nf.data_venda, '%Y-%m') as mes_ano,
		sum(inf.quantidade) as quantidade_vendas,
		max(tc.volume_de_compra) as quantidade_limite from notas_fiscais nf
		inner join itens_notas_fiscais inf 
		on nf.numero = inf.numero
		inner join tabela_de_clientes tc
		on tc.cpf = nf.cpf
		GROUP BY nf.cpf, tc.nome, DATE_FORMAT(nf.data_venda, '%Y-%m')) x;

























































