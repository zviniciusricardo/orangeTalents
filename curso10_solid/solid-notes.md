# SOLID e boas práticas

* Atualmente existe uma classe em um sistema dentro do Orange Talents com um método chamado
analisaDadosResposta que recebe como argumento objeto cujo tipo é uma classe criada no 
próprio sistema para se conectar com formulários do google forms. Só que agora esse método
precisa analisar dados que também podem vir do Microsoft Forms. 
No futuro, também pode ser necessário analisar dados que vão vir via TypeForms. 
Qual seria solução/alteração para que o método analisaDadosResposta não precisasse ser 
modificado em função das novas fontes de dados do futuro?


* Existe um outro método aqui nos sistemas da Orange Talent, analisaMomentoAtual, que recebe como argumento um objeto do tipo Aluno. Dentro deste método, o único método chamado a partir de um objeto do tipo Aluno, é o getCursosFeitos(). Neste momento, qualquer alteração na classe Aluno pode influenciar no comportamento do método analisaMomentoAtual. Como você faria para que o método analisaMomentoAtual possa continuar a receber um Aluno, mas através de uma interface mais estável? Só para deixar claro, a ideia é que o ponto do código onde temos algo como analisaMomentoAtual(aluno) continue do mesmo jeito. A invocação do método em si não precisa ser alterada. Isso é bem desafiador. 


Nos poderíamos criar uma interface do tipo ConectaFormulário com um método para conexão e depois criar
quantas classes forem preciso que extendam a essa interface. Cada classe implementaria a 
conexão da sua maneira, encapsulando o código e tornando-o coeso, ao passo que, nosso método analisaDadosResposta
passaria a receber um tipo ConectaFormulário. A interface traz estabilidade às classes que deverão retornar 
os mesmos valores que inicialmente eram devolvidos pela classe de conexão no Google Forms.

Evitando de usar métodos intercalados. Dessa forma, nosso método não fica dependente da classe aluno, podendo
extrair os dados de aluno dentro do método.




Resposta {

	public void analisaDadosResposta(ConectaGoogleForms form) {
		
	}
}



