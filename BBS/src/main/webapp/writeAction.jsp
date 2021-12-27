<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "board.BoardDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="board" class="board.Board" scope="page"/>
<jsp:setProperty name="board" property="boardTitle"/>
<jsp:setProperty name="board" property="boardContent"/>

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
		} else { //로그인이 정상적으로 되어 있는 경우
			if(board.getBoardTitle() == null || board.getBoardContent() == null) { //작성페이지에서 항목 하나를 입력하지 않았을 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력되지 않은 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				BoardDAO boardDAO = new BoardDAO();
				int result = boardDAO.write(board.getBoardTitle(), userID, board.getBoardContent());
				if(result == -1) { //-1의 경우 DB ERROR
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('DB에서 오류가 발생했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'board.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>