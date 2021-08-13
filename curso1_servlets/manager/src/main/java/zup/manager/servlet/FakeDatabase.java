package zup.manager.servlet;

import java.util.ArrayList;
import java.util.List;

public class FakeDatabase {
	
	private static List<Company> list = new ArrayList<>();
	
	public void add(Company company) {
		FakeDatabase.list.add(company);
	}
	
	public List<Company> getCompanies() {
		return FakeDatabase.list;
	}

}
