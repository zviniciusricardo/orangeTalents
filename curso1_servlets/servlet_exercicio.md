Eu criaria a classe Autor()
atributos: nome e email
getters e setters de cada um
Essa classe representaria o model

A classe NovoAutorServlet()
Essa classe extende a classe HttpServlet
Ela implementaria o método DoPost para criação de novo recurso
A classe NovoAutorServlet seria anotada com a notation @WebServlet(urlPatterns="/novo-autor") onde definiria o endereço
http do recurso.
Usaria o request.getParameter() para obter as requests do cliente via formulário http do tipo POST
Instanciaria um objeto do tipo Autor com os parâmetros recebidos via POST no formulario .jsp.
Persistiria o dado no FakeDatabase(), uma classe previamente criada para simular persistência dos dados em memória.

usar o setAttribute para enviar os dados para o jsp via jstl.core
E um .sendRedirect() para a página lista-autores.jsp ou index.jsp, por exemplo.

O file JSP novo-autor.jsp
Com um form e um botão de envio
Os campos de nome e de email para requisições do tipo POST
Importaria a biblioteca jstl fazendo o download do jar dentro do repositório oficial.
Usaria as notations e os pacotes jstl como o core e o fmt para gerenciamento de contexto e para parseamento de dados sensíveis q que mudam de acordo com a localidade como data e hora, por exemplo.

definiria o path do recurso como POST /autor HTTP/1.1

O file JSP lista-autores com importação da biblioteca jstl.core e jstl.fmt para fazer um for loop numa página html, iterar sobre os dados da classe Autor e exibir na tela num formato amigável com jstl.fmt


A classe FakeDatabase
Uma classe que teria como atributo uma lista
Método de inserção e de deleção da lista
No método de inserção, iterar na lista de autores usando um Iterator it() para não causar problemas de concorrência


Ao realizar a inserção do dado no nosso banco de dados simulado, redirecionar o cliente para uma lista de autores existentes ou mesmo para a home da página para evitar multiplas persistencias de um mesmo conjunto de dados.





