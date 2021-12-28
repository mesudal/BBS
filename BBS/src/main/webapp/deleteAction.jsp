<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "board.BoardDAO" %>
<%@ page import = "board.Board" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		/* 현재 로그인되어 있는 상태인 경우 해당 로그인 세션을 userID 변수에 저장 */
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String)session.getAttribute("userID");
		}
		
		if(userID == null) { //로그인이 되어 있지 않는 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근권한이 없습니다. 로그인 후 시도해주세요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		} 
		
		
		/* 게시글 번호를 이용하여 게시글을 불러올 때 사용됨 */
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
		/* 작성자의 ID와 일치하지 않은 ID로 수정에 시도할 경우 */
		Board board = new BoardDAO().getBoard(boardID);
		if(!userID.equals(board.getUserID())) { 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('접근권한이 없습니다.')");
			script.println("location.href = 'board.jsp'");
			script.println("</script>");
		} else { //로그인이 정상적으로 되어 있는 경우
			BoardDAO boardDAO = new BoardDAO();
			int result = boardDAO.delete(boardID);
			if(result == -1) { //-1의 경우 DB ERROR
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글삭제에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'board.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>