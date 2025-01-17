package DAO;
import DTO.VacationDTO;
import java.sql.*;
import DAO.MemberDAO;


public class VacationDAO {
	//vacation테이블에 데이터 삽입
	public void insertVacation(VacationDTO vDTO) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		MemberDAO mDAO = MemberDAO.getInstance();
		
		String sql = "insert into vacation(m_num,leavetype,leave_start,leave_end,reason,bancha_time)";
		sql+= "values(?,?,?,?,?,?)";
		
		try {
			conn = mDAO.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vDTO.getM_num());
			pstmt.setInt(2, vDTO.getLeavetype());
			pstmt.setString(3,vDTO.getLeave_start());
			pstmt.setString(4, vDTO.getLeave_end());
			pstmt.setString(5, vDTO.getReason());
			pstmt.setString(6, vDTO.getBancha_time());
			
			pstmt.execute();
			
			
		}catch(Exception e) {
			System.out.println("insertVacation(vDTO) ing error"+e);
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("insertVacation(vDTO) end error "+ex);
			}
		}
		
	}//insertVacation
	
	//깃 확인
	
	
	//연차 사용 갯수 조회 메서드
	public int vacation_check(String m_num) {
		int result = 0;		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDAO mDAO = MemberDAO.getInstance();
		String sql = "select count(*) from vacation where m_num =? and leavetype=1;";
		try {
			conn = mDAO.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_num);
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt("count(*)");
		}catch(Exception e) {
			System.out.println("acation_check ing error "+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();				
			}catch(Exception ex) {
				System.out.println("acation_check end error "+ex);
			}
		}
		return result;
	}
	
	//반차 사용 갯수 조회 메서드
	public int bancha_check(String m_num) {
		int result = 0;		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDAO mDAO = MemberDAO.getInstance();
		String sql = "select count(*) from vacation where m_num =? and leavetype=2;";
		try {
			conn = mDAO.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_num);
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt("count(*)");
		}catch(Exception e) {
			System.out.println("bancha_check ing error "+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();				
			}catch(Exception ex) {
				System.out.println("bancha_check end error "+ex);
			}
		}
		return result;
	}
	
	//멤버테이블에서 전체 연가 갯수 조회 메서드
	public int annaul_number_check(String m_num) {
		int result = 0;		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDAO mDAO = MemberDAO.getInstance();
		String sql = "select annual_number from member where m_num =?";
		try {
			conn = mDAO.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_num);
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt("annual_number");
		}catch(Exception e) {
			System.out.println("annaul_number_check ing error "+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();				
			}catch(Exception ex) {
				System.out.println("annaul_number_check end error "+ex);
			}
		}
		return result;
	}

}
