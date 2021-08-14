package zup.manager.servlet;

import java.util.ArrayList;
import java.util.List;

public class FakeDatabase {
	
	private static List<Company> companiesList = new ArrayList<>();
	
	static {
		var company = new Company();
		company.setName("Zup");
		var company2 = new Company();
		company2.setName("Alura");
		companiesList.add(company);
		companiesList.add(company2);
	}
	
	public void add(Company company) {
		FakeDatabase.companiesList.add(company);
	}
	
	public List<Company> getCompanies() {
		return FakeDatabase.companiesList;
	}

}
