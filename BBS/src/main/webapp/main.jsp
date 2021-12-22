<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Login Page</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class = "navbar navbar-default">
		<!-- Navbar Menu -->
		<div class = "navbar-header">
			<button type = "button" class="navbar-toggle collapsed" data-toggle="collapse" data-target = "#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class = "navbar-brand" href="main.jsp">JSP WEB PAGE</a>
		</div>
		
		<!-- Right Navbar Button -->
		<div class = "collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class = "nav navbar-nav">
				<li class = "active"><a href="main.jsp">메인</a>
				<li><a href="board.jsp">게시판</a>
			</ul>
			
			<!-- 현재 login되지 않은 상태일 경우 -->
			<%
				if(userID == null) {
			%>
				<ul class = "nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown" data-toggle="dropdown" role="button" aria-hashpopup="true" aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.jsp">로그인</a>
							<li><a href="join.jsp">회원가입</a>
						</ul>
					</li>
				</ul>
			<%		
				} else {
			%>
			<!-- 현재 로그인이 된 상태라면 Right NavBar의 역할이 달라질 수 있음 -->
				<ul class = "nav navbar-nav navbar-right">
					<li class="dropdown">
						<a href="#" class="dropdown" data-toggle="dropdown" role="button" aria-hashpopup="true" aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="test.jsp">게임실행</a>
							<li><a href="logoutAction.jsp">로그아웃</a>
						</ul>
					</li>
				</ul>
			<%
				}
			%>
		</div>
	</nav>
	
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>