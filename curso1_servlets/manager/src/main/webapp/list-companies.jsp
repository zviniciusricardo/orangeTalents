<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, zup.manager.servlet.Company"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Servlet and Scriplet</title>
</head>
<body>
	
	<!-- ele não reconhece Company ainda. Precisa do Dispatcher -->
	<!-- Fazer o casting do parâmetro request.getAttribute para o tipo do -->
	<!-- dado passado via Dispatcher servidor --> 
	<ul> 
	<%	
		List<Company> companies = (List<Company>)request.getAttribute("companies");
		for (Company company : companies) { 
	%> 	
		<li><%= company.getName() %></li>
	<%
		}
	%>
	</ul>
	
</body>
</html>