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
			PreparedStatement pstmt = conn.prepareStatement(SQL); //conn�� ����Ǿ� �ִ� ��ü�� SQL���� ����
			rs = pstmt.executeQuery();
			if(rs.next()) { //������ ��¥�� �״�� ��ȯ
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //DB ERROR
	}
	
	/* Board Number */
	public int getNext() {
		String SQL = "SELECT boardID FROM BOARD ORDER BY boardID DESC"; //���� �������� �� �۹�ȣ�� ã��
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; //���� �������� ����� �۹�ȣ�� +1�� �Ͽ� ���ο� �۹�ȣ�� ����
			}
			return 1; //�Խñ��� �ϳ��� �������� �ʴ� ��� ù ��° �Խñ����� �˸��� �۹�ȣ 1�� ��ȯ
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
			pstmt.setInt(1, getNext()); //�۹�ȣ
			pstmt.setString(2, boardTitle); //������
			pstmt.setString(3, userID); //�ۼ���
			pstmt.setString(4, getDate()); //�ۼ���¥
			pstmt.setString(5, boardContent); //�۳���
			pstmt.setInt(6, 1); //Available = ������ ���� ���� ���´� 1
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
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10); //���������� �ۼ��� �Խñ��� ��ȣ ������ ���� �������� �Խñ��� 10������ ���
			rs = pstmt.executeQuery();
			while(rs.next()) { //����� �Խñ��� �ϳ��� �ҷ����� ����
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
			pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10); //���������� �ۼ��� �Խñ��� ��ȣ ������ ���� �������� �Խñ��� 10������ ���
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}
