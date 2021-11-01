# Health Check

Um ambiente gerenciado, ou seja, uma plataforma que é capaz de detectar se algo não está funcionando conforme o esperado,
um crash de aplicação ou carga demasiada.
Depois de notar essas falhas, as plataformas são capazes de tomar algumas ações para tentar remediar a aplicação, reiniciar
ou mesmo desligar a aplicação e lançá-la novamente em outro servidor.

* um endpoint HTTP GET para esse fim. Esse endpoint deve verificar se o que a aplicação precisa para funcionar está 100%
operacional. Isso pode incluir banco de dados e serviços de mensageria, por exemplo.

* Se nossa aplicação é de processamento em lote ou batch, podemos expor uma funcionalidade via linha de comando, seguindo
os mesmos princípios, ou seja, validando conexões externas das nossas aplicações.

### Readiness Check ou Liveness Check

dois conceitos diferentes de health check:

aplicações consomem um determinado tempo para estarem aptas a receber um fluxo de trabalho
Esse processo de preparação pode compreender a configuração de uma fila, conexão com um banco de dados ou um determinado
pré-processamento.
é recomendado que nenhuma requisição seja redirecionada para a nossa aplicação em processo de preparação. Essa verificação
é chamada de Readiness Check e caso a plataforma verifique que a aplicação ainda não está pronta
Uma vez que a plataforma executa a verificação e nota que o status retornado foi de sucesso, as requisições começam a 
ser redirecionadas


obs: Utilizando o Liveness Check a plataforma identifica que a aplicação não é capaz de processar as requisições e 
reiniciará o container da aplicação na tentativa de restaurá-la

podemos usar um endpoints HTTP GET para estes fins

Esses endpoints devem permitir o Readiness Check e Liveness Check, ou seja, verificar se a aplicação está apta a receber
fluxo de trabalho ou requisições e se as requisições estão sendo processadas, respectivamente

O Spring Boot Actuator inclui vários recursos adicionais para ajudá-lo a monitorar e gerenciar sua aplicação

* Endpoint para monitoramento da saúde da aplicação (Health Check).
* Endpoint para expor métricas da aplicação.
* Endpoint para expor as propriedades da sua aplicação.

Configurar o Health Check

		<dependencies>
			<dependency>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-starter-actuator</artifactId>
			</dependency>
		</dependencies>


Entre no endereço:

		http://localhost:8080/actuator

No projeto:

Cria a classe de Checagem

		public class MeuHealthCheck {
			// Código omitido
		}


		public class MeuHealthCheck implements HealthIndicator {

			@Override
			public Health health() {
				// TODO Precisamos implementar o método
				return null;
			}

		}


Temos que implementar na interface, um método que retorna o objeto Health
Precisamos passar status do Health Check

* DOWN
* OUT_OF_SERVICE
* UNKOWN
* UP

Podemos passar detalhes do Health Check

* Versao
* Descrição
* IP

  	@Component 
  	public class MeuHealthCheck implements HealthIndicator {

  		@Override
  		public Health health() {
  			Map<String, Object> details = new HashMap<>();
  			details.put("versão", "1.2.3");
  			details.put("descrição", "Meu primeiro Health Check customizado!");
  			details.put("endereço", "127.0.0.1");
  			
  			return Health.status(Status.UP).withDetails(details).build();
  		}


  	}

> Pronto! Criamos nosso primeiro Health Check customizado 
utilizando Spring Boot Actuator!						
Para testar, basta abrir seu navegador e chamar o 		
endereço
http://localhost:8080/actuator/health

### Dicas

* Incorpore o padrão de Health Check nos seus serviços, de maneira que todo serviço seja produzido já o implemente.
* Tente minimizar o tempo de preparação da sua aplicação sempre que possível. Esse tempo pode impactar sua regra de 
* auto-scaling e alta-disponibilidade da sua aplicação, pois durante essa fase sua aplicação não pode receber fluxo de 
trabalho.
* É importante termos um trabalho de ajuste fino nessas configurações, pois elas impactam diretamente suas regras de 
alta-disponibilidade e auto-scaling
* Não deixe pública sua API, alinhe sempre com sua equipe as melhores práticas, como por exemplo:
* Adicionar autenticação
* Adicionar autorização
* Não negligencie as informações que você está expondo sobre a sua infraestrutura.

### Utilizando somente o necessário!

Sabemos que no Spring Boot Actuator existem vários Endpoints e que alguns podem expor informações sensíveis!
<b>Como eu posso remover ou desabilitar meus endpoints?</b>

Existem duas alternativas!

* 1º Habilitar somente o que é utilizado, para isto é necessário adicionar a propriedade:
  management.endpoints.web.exposure.include=health,metrics,prometheus

* 2º Remover os não utilizados, para isto é necessário adicionar a propriedade:
  management.endpoints.web.exposure.exclude=env,beans

### Utilizando CORS!

O CORS (Cross-origin Resource Sharing) é um mecanismo utilizado pelos navegadores para compartilhar recursos entre 
diferentes origens. O CORS é uma especificação do W3C e faz uso de headers do HTTP para informar aos navegadores se 
determinado recurso pode ser ou não acessado.

Permitindo receber somente de uma origem, aumenta demais a segurança das APIs do Spring Boot Actuator!

Para isto, basta adicionar as seguintes propriedades no arquivo application.properties:


		management.endpoints.web.cors.allowed-origins=https://example.com
		management.endpoints.web.cors.allowed-methods=GET


#### DICAS:

- Não negligencie as informações que você está expondo sobre a sua infraestrutura.
- Não deixe pública sua API, alinhe sempre com sua equipe as melhores práticas, como por exemplo:
- Adicionar autenticação
- Adicionar autorização


### Segurança de aplicações cloud-native



### Incorpore segurança no design

Segurança deve ser tratada igualmente como qualquer outra feature do seu sistema. Durante todo o processo de 
desenvolvimento preocupações inerentes a segurança devem ser levantadas e tratadas de maneira regular e com frequência.
Incorporar segurança no seu design é um princípio bastante importante

### O que é ofuscamento? Quando devo usalo?

logar uma informação passível de identificação, devemos ofuscar os dados
embaralhamos caracteres
o termo adequado é PII - PERSONAL INDETIFIABLE INFORMATION


### Logs. XI do 12 Factor Apps

Log de dados é um arquivo de texto gerado por um software para descrever eventos sobre o seu funcionamento, utilização 
por usuários ou interação com outros sistemas. 

O grande problema é que geralmente os logs são gerados em arquivos e há a necessidade de roteamento dos mesmos!

No 12 Factor Apps nunca devemos nos preocupar com o roteamento ou armazenagem do seu fluxo de saída. Nossa aplicação 
não deve tentar escrever ou gerir arquivos de logs. No lugar, cada aplicação em execução escreve seu próprio fluxo de 
evento, sem buffer, para o stdout.

Logando no stdout, cada fluxo de logs de cada aplicação serão capturados pelo ambiente de execução e direcionados para 
um ou mais destinos finais para visualização e arquivamento de longo prazo. Estes destinos de arquivamento não são 
visíveis ou configuráveis pelo aplicação, e ao invés disso, são completamente geridos pelo ambiente de execução. 
Agregadores de logs open source (Logstash, Fluentd, Fluent bit) estão disponíveis para este propósito.

### Json Log no Spring

Essas ferramentas de coleta de logs (Logstash, Fluentd, Fluent bit) geralmente trabalham melhor com a indexação no formato JSON!
Demais né! Vamos fazer isso utilizando o Spring?
Primeiro, precisamos adicionar algumas configurações no nosso pom.xml, conforme abaixo:

    <properties>
      <!-- Omitidas outras propriedades -->
      <ch.qos.logback.version>1.2.3</ch.qos.logback.version>
    </properties>

    <dependencyManagement>
      <dependencies>
          <dependency>
              <groupId>ch.qos.logback</groupId>
              <artifactId>logback-core</artifactId>
              <version>${ch.qos.logback.version}</version>
          </dependency>
          <dependency>
              <groupId>ch.qos.logback</groupId>
              <artifactId>logback-classic</artifactId>
              <version>${ch.qos.logback.version}</version>
          </dependency>
          <dependency>
              <groupId>ch.qos.logback</groupId>
              <artifactId>logback-access</artifactId>
              <version>${ch.qos.logback.version}</version>
          </dependency>
  
      </dependencies>
    </dependencyManagement>

Agora que está tudo configurado (Propriedades e Dependency Management), precisamos adicionar a seguinte dependência:
    
    <dependencies>
      <dependency>
        <groupId>net.logstash.logback</groupId>
        <artifactId>logstash-logback-encoder</artifactId>
        <version>6.4</version>
      </dependency>
    </dependencies>

Agora que está tudo configurado, precisamos adicionar o seguinte arquivo logback-spring.xml na pasta /src/main/resources/
logback-spring.xml

    <configuration>
    
        <appender name="consoleAppender" class="ch.qos.logback.core.ConsoleAppender">
          <encoder class="net.logstash.logback.encoder.LoggingEventCompositeJsonEncoder">
            <providers>
              <timestamp/>
              <version/>
              <loggerName/>
              <threadName/>
              <logLevel/>
              <mdc/>
              <message/>
              <stackTrace/>
            </providers>
          </encoder>
        </appender>
    
        <logger name="jsonLogger" additivity="false" level="DEBUG">
          <appender-ref ref="consoleAppender"/>
        </logger>
    
        <root level="INFO">
          <appender-ref ref="consoleAppender"/>
        </root>
    
    </configuration>

Para testar inicie sua aplicação conforme desejar ou utilizando o comando mvn clean spring-boot:run e verifique se 
os logs estão sendo escritos no formato JSON!
Um ponto importante! Além do log ser no formato JSON, nossa aplicação precisa logar no Stdout do nosso sistema, 
pois, é o lugar que os coletores de logs ficam esperando os mesmos para serem processados e também não precisamos 
que nossa aplicação tenha a responsabilidade de escrever em um determinado arquivo e gerir o roteamento do mesmo!


### Loggin

Spring Boot uses Commons Logging for all internal logging but leaves the underlying log implementation open. Default 
configurations are provided for Java Util Logging, Log4J2, and Logback. In each case, loggers are pre-configured to 
use console output with optional file output also available.

By default, if you use the “Starters”, Logback is used for logging. Appropriate Logback routing is also included to 
ensure that dependent libraries that use Java Util Logging, Commons Logging, Log4J, or SLF4J all work correctly.

<b>The following items are output:</b>

* Date and Time: Millisecond precision and easily sortable.
* Log Level: ERROR, WARN, INFO, DEBUG, or TRACE.
* Process ID.
> A --- separator to distinguish the start of actual log messages.
* Thread name: Enclosed in square brackets (may be truncated for console output).
* Logger name: This is usually the source class name (often abbreviated).
* The log message.

Color-coded Output
If your terminal supports ANSI, color output is used to aid readability. You can set spring.output.ansi.enabled 
to a supported value to override the auto-detection.

Color coding is configured by using the %clr conversion word. In its simplest form, the converter colors the output 
according to the log level, as shown in the following example:

    %clr(%5p)

The following table describes the mapping of log levels to colors:

Level	Color
FATAL   Red
ERROR   Red
WARN    Yellow
INFO    Green
DEBUG   Green
TRACE   Green

Alternatively, you can specify the color or style that should be used by providing it as an option to the conversion. 
For example, to make the text yellow, use the following setting:

    %clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){yellow}

The following colors and styles are supported:

    blue' | cyan' | faint' | green' | magenta' | red' | yellow'


### A handful of rules for logging:

* DO include a timestamp
* DO format in JSON
* DON’T log insignificant events
* DO log all application errors
* MAYBE log warnings
* DO turn on logging
* DO write messages in a human-readable form
* DON’T log informational data in production
* DON’T log anything a human can’t read or react to

Tool options

ELK, short for Elasticsearch, Logstash, and Kibana, is the most popular open source log aggregation tool on the market.
It’s used by Netflix, Facebook, Microsoft, LinkedIn, and Cisco.
When installing a production-level ELK stack, a few other pieces might be included, like Kafka, Redis, and NGINX

Graylog

Fluentd

### Identifying and Mapping the Attack Surface¶

You can start building a baseline description of the Attack Surface in a picture and notes. Spend a few hours reviewing
design and architecture documents from an attacker's perspective. Read through the source code and identify different 
points of entry/exit:

* User interface (UI) forms and fields
* HTTP headers and cookies
* APIs
* Files
* Databases
* Other local storage
* Email or other kinds of messages
* Runtime arguments
* ...Your points of entry/exit

The total number of different attack points can easily add up into the thousands or more. To make this manageable, break
the model into different types based on function, design and technology:

* Login/authentication entry points
* Admin interfaces
* Inquiries and search functions
* Data entry (CRUD) forms
* Business workflows
* Transactional interfaces/APIs
* Operational command and monitoring interfaces/APIs
* Interfaces with other applications/systems
* ...Your types

### Measuring and Assessing the Attack Surface

Once you have a map of the Attack Surface, identify the high risk areas. Focus on remote entry points – interfaces with 
outside systems and to the Internet – and especially where the system allows anonymous, public access.

Network-facing, especially internet-facing code Web formsFiles from outside of the network Backward compatible interfaces
with other systems – old protocols, sometimes old code and libraries, hard to maintain and test multiple versions

Custom APIs – protocols etc – likely to have mistakes in design and implementation
Security code: anything to do with cryptography, authentication, authorization (access control) and session management

___________________________________________________________________________________

## Resposta Health Check

Primeiramente eu habilitaria e incluiria as dependências de monitoramento do spring-boot-actuator no pom.xml.
Depois, eu criaria uma classe que implemente a interface HeathIndicator anotada com @Component (bean do spring)

Vamos sobrescrever o método health que vai nos possibilitar capturar dados da aplicação por meio de endpoints providos pelo actuator.

Na nossa máquina local, usamos:
http://localhost:8080/actuator/health

e podemos observar os dados disponíveis fornecidos pelo actuator e pela nosso componente de health checking;

			@Component 
		  	public class MeuHealthCheck implements HealthIndicator {

		  		@Override
		  		public Health health() {
		  			Map<String, Object> details = new HashMap<>();
		  			details.put("versão", "1.2.3");
		  			details.put("descrição", "Meu primeiro Health Check customizado!");
		  			details.put("endereço", "127.0.0.1");
		  			
		  			return Health.status(Status.UP).withDetails(details).build();


É importante observar que é importante ter um ambiente de desenvolvimento onde cada agente e ator tenha o mínimo acesso quanto for possível para o desenvolvimento das atividades.

Cada funcionalidade já deve ser pensada como uma parte gerenciada pelo healthCheck.

Precisamos implementar sistemas de log que nos ajudem a descobrir a saúde atual do nosso sistema, como também informações de segurança e eventos importantes do nosso negócio.

Configurar a exposição necessárias dos endpoints fornecidos pelo actuator limitando o acesso à eles ao serviço ou cliente que utilizará aquele serviço.
Exigir autenticação e adicionar autorizações como roles, users, managers.

você pode fazer isso via properties com

		management.endpoints.web.exposure.include="..."
		management.endpoints.web.exposure.exclude="..."

Ou podemos explicitamente declarar qual cliente ou serviço pode acessar aquele endpoint usando o CORS!

		management.endpoints.web.cors.allowed-origins=https://example.com
		management.endpoints.web.cors.allowed-methods=GET

Caso seja pertinente, também posso instalar uma api de logs json based para auxiliar na exposição dos dados e inclusive no formato da apresentação como diferentes cores para diferentes grupos de logs, um prefixo pré-configurado para cada tipo de log ERR, INFO, SERV, TRACE, etc.

Ao definir os endpoints que serão observados, a estrutura do projeto com segurança, autenticação e acessos estabelecidos, preciso usar uma estratégia para otimizar meus logs a serem uma parte integrante de mais outro fluxo dentro da minha aplicação.

Algumas convenções serão seguidas como:

* Incluir um timestamp em cada log
* Em formato Json
* Com mensagens user friendly
* logs essenciais do que for significativo à minha aplicação
* E, em caso de logs ou tráfego de dados sensíveis, ofuscar as informações.





