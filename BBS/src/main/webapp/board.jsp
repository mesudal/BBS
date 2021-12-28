<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "board.BoardDAO" %>
<%@ page import = "board.Board" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Board WEB PAGE</title>
</head>
<body>
	<%
		/* 현재 로그인한 상태인지 알기 위한 변수 */
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		/* 현재의 페이지를 카운트하기 위함 */
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null) { //DAO에 있는 pageNumber값이 Null이 아닌 경우 pageNumber 변수에 저장
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				<li><a href="main.jsp">메인</a>
				<li class = "active"><a href="board.jsp">게시판</a>
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
	
	<!-- Board Form -->
	<div class="container">
		<div class="row"> <!-- 하나의 행 -> 가로줄 -->
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead> <!-- 테이블의 헤더, 제목부분 -->
					<tr>
						<th style="backgroun-color:#eeeeee; text-align:center;">번호</th>
						<th style="backgroun-color:#eeeeee; text-align:center;">제목</th>
						<th style="backgroun-color:#eeeeee; text-align:center;">작성자</th>
						<th style="backgroun-color:#eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						BoardDAO boardDAO = new BoardDAO();
						ArrayList<Board> list = boardDAO.getList(pageNumber); //BoardDAO의 getList 객체를 이용하여 pageNumber까지의 글을 list 배열에 저장
						for(int i=0; i<list.size(); i++) {
					%>
						<tr>
							<td><%=list.get(i).getBoardID() %></td>
							<td><a href="view.jsp?BoardID=<%=list.get(i).getBoardID() %>"><%=list.get(i).getBoardTitle() %></a></td>
							<td><%=list.get(i).getUserID() %></td>
							<td><%=list.get(i).getBoardDate()%></td>
						</tr>
					<%	
						}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber != 1) { //PageNumber가 1 이상인 경우 즉, 게시글이 11개 이상인 경우
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber-1 %>" class = "btn btn-success btn-arraw-left">이전</a>
			<%
				} if(boardDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="board.jsp?pageNumber=<%=pageNumber+1 %>" class = "btn btn-success btn-arraw-right">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>