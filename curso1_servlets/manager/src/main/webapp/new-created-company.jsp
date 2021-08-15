<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Company Created</title>
</head>
<body>
	
	<c:if test="${ not empty company }">
		<h2>A new company ${ company.name } was created!</h2>
	</c:if>
	
	<c:if test="${ empty company.name }">
		No company registered!
	</c:if>
	
</body>
</html>	