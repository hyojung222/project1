package DAO;
import java.sql.*;
import DTO.MemberDTO;

public class MemberDAO {
	private MemberDAO() {
		
	}//
	
	private static MemberDAO instance = new MemberDAO();
	
	public static MemberDAO getInstance() {
		return instance;
	}//싱글톤 구현
	
	public Connection getConnection()throws Exception {
		Connection conn = null;
		String url = "jdbc:mysql://127.0.0.1:3306/team";
		String db_id = "root";
		String db_pw = "iotiot";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(url,db_id,db_pw);
		return conn;
	}
	
	public int loginCheck(String m_num , String pw) {
		int result = -1; //  -1이면 회원정보없음 , 0이면 비밀번호틀림, 1이면 로그인
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select pw from member where m_num =?;";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_num);
			rs = pstmt.executeQuery();
			rs.next();
			if(pw.equals(rs.getString("pw"))){
				result=  1 ; //로그인 성공
			}else if(pw != rs.getString("pw")) {
				result =  0 ; //비밀번호 틀림
			}else {
				result = -1; //회원가입되어있지 않음
			}
			
			
			
			
		}catch(Exception e) {
			System.out.println("login.do 연결중 에러"+e);
			e.printStackTrace(); 
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex){
				System.out.println("login.do 접속해제중 에러"+ex);
			}
		}
		
		
		
		return result;
		
	}
	//onoff테이블에 데이터 넣기
	public void insertOnoff(String m_num, int i) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "insert into onoff(m_num, clicktime, clicktype, check_date) values(?,now(),?,now());";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_num );
			pstmt.setInt(2, i);
			pstmt.execute();
			
		}catch(Exception e) {
			System.out.println("insertOnoff 접속중 오류"+e);
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception ex) {
				System.out.println("insertOnoff 연결해제중 오류발생"+ex);
			}
		}
		
	}// insertOnoff
	
	
	//회원정보가져오기
	public MemberDTO showMember(String m_num) {
		MemberDTO mDTO = new MemberDTO();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from member where m_num=?;";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_num);
			rs = pstmt.executeQuery();
			rs.next();
			
			mDTO.setM_num(m_num);
			mDTO.setName(rs.getString("name"));
			mDTO.setPw(rs.getString("pw"));
			mDTO.setAddress(rs.getString("address"));
			mDTO.setPhone(rs.getString("phone"));
			mDTO.setEmail(rs.getString("email"));
			mDTO.setPhoto(rs.getString("photo"));
			
			
		}catch(Exception e) {
			System.out.println("showmember(m_num) ing error "+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("showmember(m_num) end error "+ex);
			}
		}
		
		
		
		return mDTO;
	}//showMember
	
	public int adminCheck(String m_num) {
		int result = 0;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select admin from member where m_num =?;";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, m_num);
			rs = pstmt.executeQuery();
			rs.next();
			result = rs.getInt("admin");
			
			
			
		}catch(Exception e) {
			System.out.println("adminCheck(m_num) ing error "+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("adminCheck(m_num) end error "+ex);
			}
		}
		
		
		
		return result;
	}
	
	public void registerMember(MemberDTO mDTO) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "insert into member(m_num,name,pw,join_date,address,phone,email,admin,photo,annual_number) values(?,?,?,?,?,?,?,?,?,?);";
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mDTO.getM_num());
			pstmt.setString(2, mDTO.getName());
			pstmt.setString(3, mDTO.getPw());
			pstmt.setInt(4, mDTO.getJoin_date());
			pstmt.setString(5, mDTO.getAddress());
			pstmt.setString(6, mDTO.getPhone());
			pstmt.setString(7, mDTO.getEmail());
			pstmt.setInt(8, mDTO.getAdmin());
			pstmt.setString(9, mDTO.getPhoto());
			pstmt.setInt(10, mDTO.getAnnual_number());
			
			pstmt.execute();
			
		}catch(Exception e) {
			System.out.println("registerMember(mDTO) ing error "+e);
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("registerMember(mDTO) end error"+ex);
			}
		}
		
		
		
	}//register
	
	public int updateMember(MemberDTO mDTO) {
		int result = 0;  //업데이트 실패하면 0, 성공하면 1
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		
		String sql = "update member set pw=? , address=? , email=?, photo=?";
		sql+= ", phone=? where m_num=?;";
		
		
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mDTO.getPw());
			pstmt.setString(2, mDTO.getAddress());
			pstmt.setString(3, mDTO.getEmail());
			pstmt.setString(4, mDTO.getPhoto());
			pstmt.setString(5, mDTO.getPhone());
			pstmt.setString(6, mDTO.getM_num());
			
			result = pstmt.executeUpdate();
			
			
			
		}catch(Exception e) {
			System.out.println("updateMember ing error"+e);
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("updateMember end error "+ex);
			}
		}
		
		
		
		
		
		
		return result;
	}
	
	
}
