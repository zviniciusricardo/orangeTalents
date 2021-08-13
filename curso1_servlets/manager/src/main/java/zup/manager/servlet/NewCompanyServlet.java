package zup.manager.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns="/new-company")
public class NewCompanyServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String companyName = request.getParameter("name");
		PrintWriter out = response.getWriter();
		out.println("<html><body>Request " + companyName + " realizada com sucesso</body></html>");
		System.out.println("Query GET company");
	}
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		System.out.println("Register a new company");
		
		String companyName = request.getParameter("name");
		var company = new Company();
		company.setName(companyName);
		
		Database db = new Database();
		db.add(company);
		
		PrintWriter out = response.getWriter();
		out.println("<html><body>Empresa " + companyName + " cadastrada com sucesso</body></html>");
		
		
	}

}