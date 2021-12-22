<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LogOut Page</title>
</head>
<body>
	<%
		session.invalidate(); //현재 소유하고 있는 세션을 무효화
	%>
	<script>
		location.href = 'main.jsp';
	</script>
</body>
</html>