# Spring Profiles, testes unitários e deploy da aplicação

Qual a maneira correta de restringir o acesso a determinado endpoint, baseado no perfil do usuário?
Adicionando a chamada ao método hasRole(“NOME_DO_ROLE”) no código de configuração do endpoint na classe SecurityConfigurations.

Nesta aula, aprendemos que:

Para atualizar a versão do Spring Boot na aplicação, basta alterar a tag <version> da tag <parent>, no arquivo pom.xml.
É importante ler as release notes das novas versões do Spring Boot, para identificar possíveis quebras de compatibilidades ao atualizar a aplicação.
É possível restringir o acesso a determinados endpoints da aplicação, de acordo com o perfil do usuário autenticado, utilizando o método hasRole(“NOME_DO_ROLE”) nas configurações de segurança da aplicação.


Nesta aula, aprendemos que:

Profiles devem ser utilizados para separar as configurações de cada tipo de ambiente, tais como desenvolvimento, testes e produção.
A anotação @Profile serve para indicar ao Spring que determinada classe deve ser carregada apenas quando determinados profiles estiverem ativos.
É possível alterar o profile ativo da aplicação por meio do parâmetro -Dspring.profiles.active.
Ao não definir um profile para a aplicação, o Spring considera que o profile ativo dela e o profile de nome default.










_____________________________________________________________________________________________________________________
Resposta

Todas as respostas dadas pelos alunos e alunas do programa Orange Talent podem ser acessadas por mentores e programa managers que acompanham as turmas. Mas, como esse endereço reside no mesmo sistema onde os próprios alunos e alunas respondem às avaliações, é necessário controlarmos o acesso. Tanto aluno, como mentor, como program manager fazem login no mesmo sistema mas, por conta do nível de acesso, tem acessos a endereços diferentes. 

Além disso, agora, para cada resposta dada por um aluno ou aluna, o sistema deve enviar um email para os(as) program managers avisando do evento. Só que tem um detalhe, em ambiente de desenvolvimento esse envio deve ser apenas de brincadeira, um mero print exibindo o email que deveria ser enviado. Só que em produção, o email deveria ser enviado usando o provedor de envio de emails que a Zup utiliza. 

* Descreva quais seriam os passos para você, usando o Spring Security, proteger os acessos em função do nível de acesso(roles) de cada tipo de usuário logado no sistema. 

* Descreva quais seriam os passos para você implementar o suporte a envios de emails de maneiras diferentes em função do ambiente de execução.
