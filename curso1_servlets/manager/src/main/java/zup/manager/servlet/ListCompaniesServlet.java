package zup.manager.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/list-companies" })
public class ListCompaniesServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		FakeDatabase db = new FakeDatabase();
		List<Company> companiesList = db.getCompanies();
		
		// "companies" é o nome do atributo(alias) passado para o JSP via  
		// RequestDispatcher e rd.forward(req, resp)
		request.setAttribute("companies", companiesList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/list-companies.jsp");
		rd.forward(request, response);
	}
}
