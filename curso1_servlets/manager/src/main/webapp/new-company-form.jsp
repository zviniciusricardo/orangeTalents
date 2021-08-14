<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:url value="/new-company" var="rootPath" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register a new company</title>
</head>
<body>
	<form action="${ rootPath }" method="POST">
		Nome: <input type="text" name="name">
		<input type="submit" style=display:block>
	</form>
</body>
</html>