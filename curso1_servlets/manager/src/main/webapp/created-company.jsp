<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Company Created</title>
</head>
<body>
	
	<c:if test="${ not empty companiesList }">
		<h2>A new company ${ companiesList } was created!</h2>
	</c:if>
	
	<c:if test="${ empty companiesList }">
		No company registered!
	</c:if>
	
</body>
</html>	