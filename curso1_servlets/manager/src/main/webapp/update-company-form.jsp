<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:url value="/update-company" var="rootPath" />


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Show company</title>
</head>
<body>
	<form action="${ rootPath }" method="POST">
		
		Name: <input type="text" name="name" value="${ company.name }" />
		Register Date: <input type="text" name="date" 
		value="<fmt:formatDate value="${ company.registerDate }" pattern="dd/MM/yyyy"/>" />
		<input type="hidden" name="id" value="${ company.id }">
		
		<input type="submit" style=display:block>
		
	</form>
</body>
</html>