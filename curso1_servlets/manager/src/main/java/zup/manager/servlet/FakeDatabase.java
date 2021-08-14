package zup.manager.servlet;

import java.util.ArrayList;
import java.util.List;

public class FakeDatabase {
	
	private static List<Company> companiesList = new ArrayList<>();
	
	public void add(Company company) {
		FakeDatabase.companiesList.add(company);
	}
	
	public List<Company> getCompanies() {
		return FakeDatabase.companiesList;
	}

}
