+------------------------+                                        
| Tables_in_sucos_vendas |                                        
+------------------------+                                        
| itens_notas_fiscais    |                                        
| notas_fiscais          |                                        
| tabela_de_clientes     |                                        
| tabela_de_produtos     |                                        
| tabela_de_vendedores   |                                        
+------------------------+



tabela_de_produtos;
+-------------------+-------------+------+-----+---------+-------+
| Field             | Type        | Null | Key | Default | Extra |
+-------------------+-------------+------+-----+---------+-------+
| CODIGO_DO_PRODUTO | varchar(10) | NO   | PRI | NULL    |       |
| NOME_DO_PRODUTO   | varchar(50) | YES  |     | NULL    |       |
| EMBALAGEM         | varchar(20) | YES  |     | NULL    |       |
| TAMANHO           | varchar(10) | YES  |     | NULL    |       |
| SABOR             | varchar(20) | YES  |     | NULL    |       |
| PRECO_DE_LISTA    | float       | NO   |     | NULL    |       |
+-------------------+-------------+------+-----+---------+-------+

notas_fiscais;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| CPF        | varchar(11) | NO   | MUL | NULL    |       |
| MATRICULA  | varchar(5)  | NO   | MUL | NULL    |       |
| DATA_VENDA | date        | YES  |     | NULL    |       |
| NUMERO     | int         | NO   | PRI | NULL    |       |
| IMPOSTO    | float       | NO   |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+

itens_notas_fiscais;
+-------------------+-------------+------+-----+---------+-------+
| Field             | Type        | Null | Key | Default | Extra |
+-------------------+-------------+------+-----+---------+-------+
| NUMERO            | int         | NO   | PRI | NULL    |       |
| CODIGO_DO_PRODUTO | varchar(10) | NO   | PRI | NULL    |       |
| QUANTIDADE        | int         | NO   |     | NULL    |       |
| PRECO             | float       | NO   |     | NULL    |       |
+-------------------+-------------+------+-----+---------+-------+

tabela_de_vendedores;
+---------------------+--------------+------+-----+---------+-------+
| Field               | Type         | Null | Key | Default | Extra |
+---------------------+--------------+------+-----+---------+-------+
| MATRICULA           | varchar(5)   | NO   | PRI | NULL    |       |
| NOME                | varchar(100) | YES  |     | NULL    |       |
| PERCENTUAL_COMISSAO | float        | YES  |     | NULL    |       |
| DATA_ADMISSAO       | date         | YES  |     | NULL    |       |
| DE_FERIAS           | bit(1)       | YES  |     | NULL    |       |
| BAIRRO              | varchar(50)  | YES  |     | NULL    |       |
+---------------------+--------------+------+-----+---------+-------+

tabela_de_clientes;
+--------------------+--------------+------+-----+---------+-------+
| Field              | Type         | Null | Key | Default | Extra |
+--------------------+--------------+------+-----+---------+-------+
| CPF                | varchar(11)  | NO   | PRI | NULL    |       |
| NOME               | varchar(100) | YES  |     | NULL    |       |
| ENDERECO_1         | varchar(150) | YES  |     | NULL    |       |
| ENDERECO_2         | varchar(150) | YES  |     | NULL    |       |
| BAIRRO             | varchar(50)  | YES  |     | NULL    |       |
| CIDADE             | varchar(50)  | YES  |     | NULL    |       |
| ESTADO             | varchar(2)   | YES  |     | NULL    |       |
| CEP                | varchar(8)   | YES  |     | NULL    |       |
| DATA_DE_NASCIMENTO | date         | YES  |     | NULL    |       |
| IDADE              | smallint     | YES  |     | NULL    |       |
| SEXO               | varchar(1)   | YES  |     | NULL    |       |
| LIMITE_DE_CREDITO  | float        | YES  |     | NULL    |       |
| VOLUME_DE_COMPRA   | float        | YES  |     | NULL    |       |
| PRIMEIRA_COMPRA    | bit(1)       | YES  |     | NULL    |       |
+--------------------+--------------+------+-----+---------+-------+





























