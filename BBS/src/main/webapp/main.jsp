<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>Main Page</title>
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
	
	<!-- Main Page Explanation -->
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>웹 사이트 소개</h1>
				<p>이 웹 사이트는 제가 유튜버 "동빈나"님의 JSP 강의를 시청하며 학습한 내용입니다. 동빈나님의 유튜브 채널에는 좋은 영상이 많으니 한 번쯤 찾아가셔서 시청하시는걸 적극 추천드립니다!</p>
				<p><a class="btn btn-primary btn-pull" href="#" role="button">자세히 알아보기</a></p>
			</div>
		</div>
	</div>
	
	<!-- Main Page Images -->
	<div class="container">
		<div id="myCarousel" class="carousel" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
				<li data-target="#myCarousel" data-slide-to="1"></li>
			</ol>
			<div class="carousel-inner">
				<div class="item active">
					<img src="images/Sudal_1.jpg" width="100%">
				</div>
				<div class="item">
					<img src="images/Bichon.jfif" width="100%">
				</div>
			</div>
			<a class="left carousel-control" href="#myCarousel" data-slide="prev"> <!-- 사진을 이전으로 넘기는 버튼 -->
				<span class="glyphicon glyphicon-chevron-left"></span>
			</a>
			<a class="right carousel-control" href="#myCarousel" data-slide="next"> <!-- 사진을 다음으로 넘기는 버튼 -->
				<span class="glyphicon glyphicon-chevron-right"></span>
			</a>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>