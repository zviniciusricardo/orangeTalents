Resposta Curso HTTP 2.0
Vinícius Ricardo - Turma 8

Para a requisição de pesquisa, o mais indicado seria o método GET, pois ele é o método responsável por
listar grupos de dados.

REQUEST VIA URI:

		https://www.flyawesome.com/tickets/destination/brasil/mg/1/schedule/?living=living-date-format&?comming=comeback-date-format
		
Na requisição acima, utilizamos o método dentro da barra de busca via URI, mas em se tratando de Web Services, poderíamos
nos utilizar de requisições JSON do tipo GET, como:


		HTTP Headers:
		
		GET /destination/brasil/mg/1/schedule/  HTTP/1.1
		Host: flyawesome.com
		Accept: text/html;charset=UTF-8, application/json, application/x-www-form-urlencoded
		
		JSON GET

		{	
			method: 'GET',
			headers: {
				"Content-Type": "application/application-json",
				"Accept": application/json;charset=UTF-8
				
			}
		
			"destination": {
				"country": "brasil",
				"district": "mg",
				"city": "belo horizonte
				
				"schedule": {
					"living": "07/08/2021",
					"comming": "10/08/2021"
				}	
			
		}
		
Em se tratando de web services, a abordagem com json possibilita integrações com outras API's REST.


No caso de cadastros de usuários, utilizaremos o formulário e requisições do tipo POST, já que 
lidaremos com dados sensíveis e não queremos que nossos usuários o tenham expostos numa url, por exemplo.

		HTTP Headers:
		
		POST /register HTTP/2.0
		Host: flyawesome.com
		Accept: application/x-www-form-urlencoded, application/json,
		vary: Accept-Encoding
		
		
		JSON POST
		
		{	
			method: 'POST',
			headers: {
				Content-Type: "application/application-json",
				Accept: "application/json;charset=UTF-8, application/x-www-form-urlencoded;charset=UTF-8",
				version: HTTP/2.0
				
			}
		
			"register": {
				"email": "someemail@somemailservice.com.br",
				"cpf": 873652815422,
				"password": " ********* ",
				"valid-password": " ********* "
			}
			
		}

No caso do cadastro, declaramos nos headers da applicação o protocolo HTTP/2.0, já que esse vem 
com criptografia GZIP por default. Também declaramos o Accept-Encoding, por precaução, caso a requisição
se utilizasse do HTTP/1.1. Nosso cadastro aceita requisições do tipo POST via form-encoded e via json
dependendo do cliente utilizando o serviço, mas não aceita parâmetros via URI. 

