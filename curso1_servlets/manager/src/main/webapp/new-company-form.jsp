<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url value="/new-company" var="rootPath" />


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register a new company</title>
</head>
<body>
	<form action="${ rootPath }" method="POST">
		Name: <input type="text" name="name">
		Register Date: <input type="text" name="date">
		<input type="submit" style=display:block>
	</form>
</body>
</html>