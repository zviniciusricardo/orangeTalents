# Segurança em Ambientes Cloud

### Resposta

Uma aplicação cloud deve se preparar para os ambientes mais diversos
e assim, precisa implementar segurança e observabilidade por design.
Cada feature deve ser criada ou extendida juntamente com o 
seu correspondente tratamento de segurança.

Em aplicações de operações de alta complexidade e sensíveis
como instituições financeiras, precisamos tomar ainda o cuidado
de trabalhar com permissões, autenticações e controle de acessos
voltada a filosofia do Mínimo Acesso Viável onde poderíamos
indicar explicitamente qual o tipo de cliente ou serviço
pode acessar determinado endpoint.

Outra coisa importante é nunca logar dados informacionais
em produção. Logs devem ser tratados como mais um asset
da aplicação e precisam receber tratamento de ofuscamento de 
dados e e encriptação em outros.

Informações como nome de clientes, endereço e outros, precisam 
ser ofuscados.
Informações como CPF, conta de banco e senha precisam ser 
encriptados.

É importante que o ambiente de desenvolvimento seja pensado
de forma a, no começo da aplicação já definir quem pode o quê,
quando e de que forma.

Usando essa tática mais a tática de logs, eu consigo aplicar
mais confiabilidade e segurança aos dados, como também
terei mais chances de identificar falhas de segurança e bugs
de negócio com o auxílio dos logs (e dos testes).

### Caminho cognitivo

<b>O que seria bom ver nessa resposta?</b>

Peso 3: Ofuscamento dos dados em logs
Peso 5: Utilização do Spring Security para autenticação e autorização
Peso 2: Utilização de criptografia de rede na comunicação entre as APIs

<b>Resposta do Especialista:</b>

Objetivo de aprendizado: 
Levar em consideração a segurança da nossa API, 
principalmente em relação a dados sensíveis trafegados e manipulados por 
ela utilizando criptografia e ofuscamento dos dados.

Motivo da escolha: 
Geralmente utilizamos ferramentas de log nas aplicações
e ofuscar os dados apresentados se torna necessário para minimizar a 
possibilidade do vazamento de dados sensíveis. Como há comunicação entre 
API através da rede, devemos também nos preocupar com a possível interceptação
das informações no caminho entre origem e destino.

* Para os logs da aplicação, ofusco os dados que possam identificar os nossos 
clientes e/ou permitir que um agente malicioso faça utilização imprópria 
dos mesmos.
* Para que a comunicação entre as aplicações seja feita de forma segura 
utilizo Spring Security para a configuração e a realização de autenticação 
e autorização de quem for utilizar as funcionalidades da nossa API.
* Para a camada de rede, implemento um suporte a HTTPS para criptografar 
os dados trafegados.
* Os dados persistidos em banco também podem ser criptografados. Geralmente 
bancos de dados já possuem funcionalidades para isso. Assim, qualquer pessoa 
que acesse o banco de dados não obterá as informações de maneira legível.






