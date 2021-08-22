select * from itens_notas_fiscais;

select * from notas_fiscais;

select * from notas_fiscais nf
inner join itens_notas_fiscais inf
on nf.numero = inf.numero;

/*
cliente = cpf
data = data_venda (a data é diária)
quantidade = quantidade
*/

select nf.cpf, nf.data_venda, inf.quantidade from notas_fiscais
nf inner join itens_notas_fiscais inf 
on nf.numero = inf.numero;

/* precisamos separar a data_venda retirando o dia para fazer a soma */

/* PRIMEIRA CONSULTA - VENDAS DE CLIENTES/MÊS */
select nf.cpf, DATE_FORMAT(nf.data_venda, '%Y-%m') AS MES_ANO,
SUM( inf.quantidade) AS QUANTIDADE_VENDAS from notas_fiscais nf
inner join itens_notas_fiscais inf 
on nf.numero = inf.numero
GROUP BY nf.cpf, DATE_FORMAT(nf.data_venda, '%Y-%m');


/* LIMITE DE COMPRA POR CLIENTE < 2000/MÊS */

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



select x.cpf, x.nome, x.mes_ano, x.quantidade_vendas, x.quantidade_limite, x.quantidade_limite - x.quantidade_vendas as diferenca,
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

/*RETIRANDO O CAMPO diferença DA TABELA, POIS NÃO PRECISAMOS MAIS DELE*/

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

