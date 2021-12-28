<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "board.BoardDAO" %>
<%@ page import = "board.Board" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>Board Write Page</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int boardID = 0;
		if(request.getParameter("boardID") != null) { //클릭한 게시글의 boardID(게시글번호)를 저장하는 변수
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if(boardID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		Board board = new BoardDAO().getBoard(boardID); //만약 존재하는 boardID일 경우 Board 인스턴스 안에 저장
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
		<div class="row">
			<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글제목</td>
						<td colspan="2"><%= board.getBoardTitle() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">작성자</td>
						<td colspan="2"><%= board.getUserID() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">작성일</td>
						<td colspan="2"><%= board.getBoardDate() %></td>
					</tr>
					<tr>
						<td style="width: 20%;">내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left;"><%= board.getBoardContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replace(">", "&gt").replace("\n", "<br>") %></td>
						<!-- Content에서는 사용자가 공백(" ") 혹은 꺽새(>,<) 혹은 들여쓰기(\n) 등을 사용할 수 있게끔 해당 문자들은 모두 정상적으로 처리할 수 있게끔 해야 한다 -->
					</tr>
				</tbody>
			</table>
			<a href="board.jsp" class="btn btn-primary">목록</a>
			<%
				if(userID != null && userID.equals(board.getUserID())) { //현재 로그인한 아이디가 작성자의 아이디와 일치하는 경우
			%>
					<a href="update.jsp?boardID=<%=boardID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?boardID=<%=boardID %>" class="btn btn-primary">삭제</a>
			<%	
				}
			%>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>