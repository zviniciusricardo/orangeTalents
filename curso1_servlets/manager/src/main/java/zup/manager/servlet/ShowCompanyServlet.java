package zup.manager.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/show-company")
public class ShowCompanyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
				
		String paramId = request.getParameter("id");
		Integer id = Integer.valueOf(paramId);
		
		var db = new FakeDatabase();
		
		Company company = db.getCompanyById(id);
		
		request.setAttribute("company", company);
		RequestDispatcher rd = request.getRequestDispatcher("/update-company-form.jsp");
		
		rd.forward(request, response);
		
	}

}
