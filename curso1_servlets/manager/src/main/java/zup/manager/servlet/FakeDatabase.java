package zup.manager.servlet;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class FakeDatabase {
	
	private static List<Company> companiesList = new ArrayList<>();
	private static Integer sequencekey = 1;
	
	static {
		var company = new Company();
		company.setId(sequencekey++);
		company.setName("Zup");
		var company2 = new Company();
		company2.setId(sequencekey++);
		company2.setName("Alura");
		companiesList.add(company);
		companiesList.add(company2);
	}
	
	public void add(Company company) {
		company.setId(FakeDatabase.sequencekey++);
		FakeDatabase.companiesList.add(company);
	}
	
	public List<Company> getCompanies() {
		return FakeDatabase.companiesList;
	}

	/**
	 * Quando tentamos iterar e modificar um objeto de um ArrayList() ao mesmo
	 * tempo, recebemos o erro ""java.util.ConcurrentModificationException"" 
	 * Desse modo, precisamos evitar esse tipo de abordagem, nos utilizando
	 * da Classe Iterator para nos movimentarmos por uma lista do tipo Collections
	 */
	public void removeCompany(Integer id) {
		Iterator<Company> it = companiesList.iterator();
		
		while(it.hasNext()) {
			Company comp = it.next();
			if(comp.getId() == id) {
				it.remove();
			}
		}
		
	}

	public Company getCompanyById(Integer id) {
		for (Company comp : companiesList) {
			if (comp.getId() == id) {
				return comp;
			}
		}
		return null;
	}

}
