<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "board.Board" %>
<%@ page import = "board.BoardDAO" %>
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
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근 권한이 없습니다.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		int boardID = 0;
		if(request.getParameter("boardID") != null) {
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if(boardID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		}
		Board board = new BoardDAO().getBoard(boardID);
		if(!userID.equals(board.getUserID())) { //작성자의 ID와 일치하지 않은 ID로 수정에 시도할 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근권한이 없습니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
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
		</div>
	</nav>
	
	<!-- Board Form -->
	<div class="container">
		<div class="row"> <!-- 하나의 행 -> 가로줄 -->
		<form method="post" action="updateAction.jsp?boardID=<%=boardID %>">
			<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">
				<thead> <!-- 테이블의 헤더, 제목부분 -->
					<tr>
						<th colspan="2" style="backgroun-color:#eeeeee; text-align:center;">게시판 글수정 양식</th>
					</tr>
				</thead>
				<tbody>
					<tr> <!-- 글제목과 글내용이 각각 가로 한 줄의 영역에 출력될 수 있도록 tr로 감싼다 -->
						<td><input type="text" class="form-control" placeholder="글제목" name="boardTitle" maxlength="50" value="<%=board.getBoardTitle() %>"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="글내용" name="boardContent" maxlength="2048" style="height:350px"><%=board.getBoardContent() %></textarea></td>
					</tr>
				</tbody>
			</table>
			<input type="submit" class="btn btn-primary pull-right" value="수정하기">
		</form>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>