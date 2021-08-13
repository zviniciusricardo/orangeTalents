package zup.manager.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = { "/listcompanies" })
public class ListCompaniesServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		FakeDatabase db = new FakeDatabase();
		List<Company> companies = db.getCompanies();
		PrintWriter out = response.getWriter();
		
		out.println("<html><body>");
		out.println("<ul>");
		
		for (Company company : companies) {
			out.println("<li>" + company.getName() + "</li>");
		}
		
		out.println("</ul>");
		out.println("</body></html>");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		doGet(request, response);
	}

}
