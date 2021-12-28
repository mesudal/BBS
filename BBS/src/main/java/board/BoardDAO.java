package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	private Connection conn;
	private ResultSet rs;
	
	/* mysql Connect */
	public BoardDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS";
			String dbID = "root";
			String dbPassword = "0008";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* Current time */
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //conn에 연결되어 있는 객체에 SQL문을 대입
			rs = pstmt.executeQuery();
			if(rs.next()) { //현재의 날짜를 그대로 반환
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //DB ERROR
	}
	
	/* Board Number */
	public int getNext() {
		String SQL = "SELECT boardID FROM BOARD ORDER BY boardID DESC"; //제일 마지막에 쓴 글번호를 찾음
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; //가장 마지막에 저장된 글번호에 +1을 하여 새로운 글번호를 배정
			}
			return 1; //게시글이 하나도 존재하지 않는 경우 첫 번째 게시글임을 알리는 글번호 1을 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB ERROR
	}
	
	/* Board Write */
	public int write(String boardTitle, String userID, String boardContent) {
		String SQL = "INSERT INTO BOARD VALUES(?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); //글번호
			pstmt.setString(2, boardTitle); //글제목
			pstmt.setString(3, userID); //작성자
			pstmt.setString(4, getDate()); //작성날짜
			pstmt.setString(5, boardContent); //글내용
			pstmt.setInt(6, 1); //Available = 삭제가 되지 않은 상태는 1
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB ERROR
	}
	
	/* Only 10 post list on the current page */
	public ArrayList<Board> getList(int pageNumber) {
		String SQL = "SELECT * FROM Board WHERE boardID < ? AND boardAvailable = 1 ORDER BY boardID DESC LIMIT 10";
		ArrayList<Board> list = new ArrayList<Board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10); //마지막으로 작성된 게시글의 번호 단위에 따라 페이지당 게시글은 10개씩만 출력
			rs = pstmt.executeQuery();
			while(rs.next()) { //저장된 게시글을 하나씩 불러오고 저장
				Board board = new Board();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	/* NextPage Function */
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM Board WHERE boardID < ? AND boardAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10); //마지막으로 작성된 게시글의 번호 단위에 따라 페이지당 게시글은 10개씩만 출력
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/* View Function */
	public Board getBoard(int boardID) {
		String SQL = "SELECT * FROM Board WHERE BoardID = ?"; //클릭한 게시글의 정보를 하나하나 출력
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Board board = new Board();
				board.setBoardID(rs.getInt(1));
				board.setBoardTitle(rs.getString(2));
				board.setUserID(rs.getString(3));
				board.setBoardDate(rs.getString(4));
				board.setBoardContent(rs.getString(5));
				board.setBoardAvailable(rs.getInt(6));
				return board;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/* Post Update Function */
	public int update(int boardID, String boardTitle, String boardContent) {
		String SQL = "UPDATE BOARD SET boardTitle = ?, boardContent = ? WHERE boardID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setInt(3, boardID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB ERROR
	}
	
	/* Post Delete Function */
	public int delete(int boardID) {
		String SQL = "UPDATE BOARD SET boardAvailable = 0 WHERE boardID = ?"; //Available을 0으로 바꾸는 이유는 나중에 삭제된 게시글을 복구하거나 조회할 수 있게끔 하기 위함이다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB ERROR
	}
}
