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


## Testes

Nesta aula, aprendemos que:

É possível escrever testes automatizados de classes que são beans do Spring, como Controllers e Repositories.
É possível utilizar injeção de dependências nas classes de testes automatizados.
A anotação @SpringBootTest deve ser utilizada nas classes de testes automatizados para que o Spring inicialize o servidor e disponibilize os beans da aplicação.
Ao testar uma interface Repository devemos, preferencialmente, utilizar a anotação @DataJpaTest.
Por padrão, os testes automatizados dos repositories utilizam um banco de dados em memória, como o h2.
É possível utilizar outro banco de dados para os testes automatizados, utilizando a anotação @AutoConfigureTestDatabase(replace = AutoConfigureTestDatabase.Replace.NONE).
É possível forçar um profile específico para os testes automatizados com a utilização da anotação @ActiveProfiles.
Para conseguir injetar o MockMvc devemos anotar a classe de teste com @AutoConfigureMockMvc.


## Arquivos .war
Quais alterações devemos fazer na aplicação para que o build dela produza um arquivo .war ao invés de .jar?
Alterar a classe main da aplicação para herdar da classe SpringBootServletInitializer, além de nela também sobrescrever o método configure.
É necessário realizar essa alteração para que o Spring Boot seja inicializado corretamente no servidor de aplicação externo.

Adicionar a tag <packaging>war</packaging> no pom.xml da aplicação.

Declarar a dependência do tomcat como provided no pom.xml.
Em um deploy tradicional com arquivo .war a biblioteca do tomcat não deve ser embutida na aplicação.


Nesta aula, aprendemos que:

O build da aplicação é realizado via maven, com o comando mvn clean package.
Ao realizar o build, por padrão será criado um arquivo .jar.
É possível passar parâmetros para as configurações da aplicação via variáveis de ambiente.
É possível alterar o build para criar um arquivo .war, para deploy em servidores de aplicações.


## Docker e containers

Criar o docker file

- Dockerfile >> dentro da pasta root

Nesta aula, aprendemos que:

É possível utilizar o Docker para criação de imagens e de containers para aplicações que utilizam Java com Spring Boot.
Devemos criar um arquivo Dockerfile no diretório raiz da aplicação, para ensinar ao Docker como deve ser gerada a imagem dela.
É possível passar as variáveis de ambiente utilizadas pela aplicação para o container Docker.
É possível realizar o deploy de aplicações Java com Spring Boot em ambientes Cloud, como o Heroku.
Cada provedor Cloud pode exigir diferentes configurações adicionais a serem realizadas na aplicação, para que ela seja executada sem nenhum tipo de problema.

customizadas

_____________________________________________________________________________________________________________________
Resposta

Todas as respostas dadas pelos alunos e alunas do programa Orange Talent podem ser acessadas por mentores e programa managers que acompanham as turmas. Mas, como esse endereço reside no mesmo sistema onde os próprios alunos e alunas respondem às avaliações, é necessário controlarmos o acesso. Tanto aluno, como mentor, como program manager fazem login no mesmo sistema mas, por conta do nível de acesso, tem acessos a endereços diferentes. 

Além disso, agora, para cada resposta dada por um aluno ou aluna, o sistema deve enviar um email para os(as) program managers avisando do evento. Só que tem um detalhe, em ambiente de desenvolvimento esse envio deve ser apenas de brincadeira, um mero print exibindo o email que deveria ser enviado. Só que em produção, o email deveria ser enviado usando o provedor de envio de emails que a Zup utiliza. 

* Descreva quais seriam os passos para você, usando o Spring Security, proteger os acessos em função do nível de acesso(roles) de cada tipo de usuário logado no sistema. 

Em primeiro lugar eu configuraria o role de usuário nas configurações de segurança (hasRole(“NOME_DO_ROLE”)). Depois, eu definiria quais contextos
cada role poderia acessar e quais métodos http poderiam ser usados por cada role.

* Descreva quais seriam os passos para você implementar o suporte a envios de emails de maneiras diferentes em função do ambiente de execução.
O Spring Boot te dá a possibilidade de configurar diversos profiles que representam diferentes ambientes de desenvolvimento.
Ao anotar as classes com @Configuration e, em alguns casos @Bean, o Spring gerencia aquelas dependências disponibilizando diferentes configurações
para cada ambiente. Por exemplo, se quisesse evitar envio de emails ao testar/implementar uma feature, bastaria desabilitar o Manager de segurança para o meu profile de desenvolvimento, além de desabilitar as classes ou pacote de serviço de email, criando uma espécie de mock.
Dessa forma, não precisaríamos poluir a caixa de email dos amiguinhos (e a nossa própria) e poderíamos implementar testes unitários.


O que seria bom ver nessa resposta?



Peso 2: Definição de role para cada tipo de usuário que teria acesso ao sistema.
Peso 2: Associação das roles para os endereços, de forma a controlar o acesso.
Peso 6: Descrição detalhada do uso dos profiles para definir qual bean seria carregado em função do ambiente.
Peso 3: Utilização da annotation Profile para ter beans carregados diferentes ou uso do próprio Environment para a tomada de decisão.
Peso 3: Passagem do argumento indicando o profile desejado para load da aplicação


Resposta do Especialista:

Definição de Roles: Para cada novo usuário do sistema já seria associada uma Role diferente. Exemplo: Aluno, Mentor, Program Manager. Essa Role é uma implementação da interface GrantedAuthority.
Definição de Roles: Para cada endereço mapeado para ser protegido, vai ter também agora a associação das roles que tem acesso. No endereço de análise das respostas, as roles que terão acesso são as de Mentor e Program Manager.
Sobre os profiles: Criaria uma classe anotada com @Configuration com um método marcado com @Bean que receberia como argumento um Environment. A partir desse argumento o código faria um if para decidir qual implementação de email seria criada. Uma outra opção seria criar dois métodos diferentes anotados com @Profile referenciando os ambientes definidos pelo projeto.
Sobre os profiles: Eu deixaria o profile default no arquivo application.properties e passaria como argumento de produção o profile correto a ser utilizado em tal ambiente. Outra opção seria sempre passar o argumento de definição por linha de comando, mesmo em ambiente de dev. As ides suportam isso.








