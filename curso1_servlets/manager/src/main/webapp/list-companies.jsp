<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, zup.manager.servlet.Company"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Companies list</title>
</head>
<body>

	<c:if test="${ not empty company }">
		<h2>The company ${ company } was registered successfully!</h2> <br />
	</c:if>

	<h2>Companies list:</h2> <br/>
	
	<ul> 
		<c:forEach items="${ companies }" var="company">
			
			<li>
			
			${ company.name } -	<fmt:formatDate value="${ company.registerDate }" pattern="dd/MM/yyy"/> 
			<a href="/manager/show-company?id=${ company.id }">edit</a>
			<a href="/manager/remove-company?id=${ company.id }">delete</a>
			
			</li>
		</c:forEach>
	</ul>
	
</body>
</html>