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
// import javax.servlet.RequestDispatcher; ### using send.Redirect()

@WebServlet(urlPatterns="/new-company")
public class NewCompanyServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		System.out.println("Register a new company");
		
		String companyName = request.getParameter("name");
		String paramRegisterDate = request.getParameter("date");
		
		Date registerDate = null;
		
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyy");
			registerDate = sdf.parse(paramRegisterDate);
		} catch (ParseException e) {
			throw new ServletException(e); // pattern catch and re-throw
		}
		
		var company = new Company();
		company.setName(companyName);
		company.setRegisterDate(registerDate);
		
		FakeDatabase db = new FakeDatabase();
		db.add(company);
		
		request.setAttribute("company", company.getName());
		
//		usar o redirecionamento para outro servlet ao invés de uma página html/jsp
//		Client side redirecting
		response.sendRedirect("list-companies");
		

//		### modelo antigo de redirecionamento usando o RequestDispatcher ###		
//		RequestDispatcher rd = request.getRequestDispatcher("/list-companies");
//		request.setAttribute("company", company.getName());
//		rd.forward(request, response);
		
	}

}