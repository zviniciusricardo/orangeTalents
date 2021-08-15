package zup.manager.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "update-company", urlPatterns = { "/update-company" })
public class UpdateCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		System.out.println("Updating company");
		
		String companyName = request.getParameter("name");
		String paramRegisterDate = request.getParameter("date");
		String paramId = request.getParameter("id");
		Integer id = Integer.valueOf(paramId);
		
		Date registerDate = null;
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyy");
			registerDate = sdf.parse(paramRegisterDate);
		} catch (ParseException e) {
			throw new ServletException(e); // pattern catch and re-throw
		}
		
		var db = new FakeDatabase();
		var company = db.getCompanyById(id);
		company.setName(companyName);
		company.setRegisterDate(registerDate);
		
		response.sendRedirect("list-companies");
		
	}

}
