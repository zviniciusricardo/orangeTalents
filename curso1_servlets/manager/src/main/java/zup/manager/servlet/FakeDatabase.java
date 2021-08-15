package zup.manager.servlet;

import java.util.ArrayList;
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

	public void removeCompany(Integer id) {
		for (Company company : companiesList) {
			if(company.getId() == id) {
				companiesList.remove(company);
			}
		}
		
	}

}
