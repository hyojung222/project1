package DAO;
import DAO.MemberDAO;
import DTO.JobsheetDTO;
import java.sql.*;

public class JobsheetDAO {
	
	//jobsheet table에 데이터삽입
	public void insertSheet(JobsheetDTO jDTO) {
		MemberDAO mDAO = MemberDAO.getInstance();
		
		
		Connection conn =null;
		PreparedStatement pstmt = null;
		String sql = "insert into jobsheet values(?,?,?,?);";
		
		try {
			conn = mDAO.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, jDTO.getM_num());
			pstmt.setString(2, jDTO.getSheet_date());
			pstmt.setString(3, jDTO.getText_area1());
			pstmt.setString(4, jDTO.getText_area2());
			
			pstmt.execute();
			
		}catch(Exception e) {
			System.out.println("insertSheet(jDTO) ing error"+e);
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("insertSheet(jDTO) end error"+ex);
			}
		}
		
		
		
		
		
	}//insertsheet
	
	public String showText(String getdate , String m_num) {
		MemberDAO mDAO = MemberDAO.getInstance();
		String msg ="";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select text_area1 from jobsheet where sheet_date=? and m_num=?;";
		try {
			conn = mDAO.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, getdate);
			pstmt.setString(2, m_num);
			rs = pstmt.executeQuery();
			
			rs.next();
			msg = rs.getString("text_area1");
			
		}catch(Exception e) {
			System.out.println("showText(getDate) ing error "+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("showText(datedate) end error "+ex);
			}
		}
		return msg;
		
		
	}//showText

}//JobsheetDAO
