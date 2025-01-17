package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;


import DTO.BoardDTO;

public class BoardDAO {
	private BoardDAO() {
	}	
	private static BoardDAO instance=new BoardDAO();   
	//싱글톤 
	public static BoardDAO getInstance() {
		return instance;
	}	
	//커넥션 연결처리
	public Connection getConnection() throws Exception{
		Connection conn=null;
		String url="jdbc:mysql://127.0.0.1:3306/team";
		String db_id="root";
		String db_pw="iotiot";
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn=DriverManager.getConnection(url, db_id, db_pw);
		return conn;
	}
	//게시글 입력-post
	public void insertboard(BoardDTO bDTO) {
		BoardDAO dao=BoardDAO.getInstance();
		Connection conn =null;
		PreparedStatement pstmt = null;
		try {
			int num=0;
			String insertQuery="select max(num) from board";
			conn = dao.getConnection();
			pstmt=conn.prepareStatement(insertQuery);
			ResultSet result=pstmt.executeQuery(); 
			while(result.next()){
				num=result.getInt("max(num)")+1;
			}
			String sql = "insert into board values(?,?,?,?,?);";			
			pstmt = conn.prepareStatement(sql);
			String a="관리자";						
			pstmt.setInt(1, bDTO.getNum());
			pstmt.setString(2, bDTO.getTitle());
			pstmt.setString(3, a);
			pstmt.setString(4, bDTO.getContent());
			pstmt.setString(5, bDTO.getReg_date());
			pstmt.execute();			
		}catch(Exception e) {
			System.out.println("insertboar 접속 error"+e);
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("insertboar 접속 해제 error"+ex);
			}
		}
	}
	//게시글 수정-post
	public void updateboard(BoardDTO bDTO) {   
		BoardDAO dao=BoardDAO.getInstance();
		Connection conn =null;
		PreparedStatement pstmt = null;
		try {			
			String sql="update board set title=?, content=? where num=?";
			conn = dao.getConnection();
			pstmt = conn.prepareStatement(sql);									
			pstmt.setString(1, bDTO.getTitle());
			pstmt.setString(2, bDTO.getContent());
			pstmt.setInt(3, bDTO.getNum());
			pstmt.execute();			
		}catch(Exception e) {
			System.out.println("updateboard 접속 error"+e);
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("updateboard 접속 해제 error"+ex);
			}
		}
	}
	
	//아래로 페이징처리하면서 전체 조회-get
	public List<BoardDTO> findList(int currentPage, int recordsPerPage) {  
		int start=currentPage*recordsPerPage-recordsPerPage;  		
		List<BoardDTO> list=new ArrayList<BoardDTO>();  
		String sql="select*from board order by num desc, num limit ?, ?;";    
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;		
		BoardDAO dao=BoardDAO.getInstance();
		try {
			conn=dao.getConnection();
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, recordsPerPage);
			rs=pstmt.executeQuery();
			while(rs.next()) {  
				int num=rs.getInt("num");  
				String title=rs.getString("title");				
				String writer=rs.getString("writer");
				String content=rs.getString("content");
				String reg_date=rs.getString("reg_date");
				BoardDTO dto=new BoardDTO();
				dto.setNum(num);
				dto.setTitle(title);
				dto.setWriter(writer);
				dto.setContent(content);
				dto.setReg_date(reg_date);
				list.add(dto);
			}
		}catch(Exception e){
			System.out.println("findList() 접속 중 오류발생: "+e);
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception ex) {
				System.out.println("findList() 접속 해제 중 오류발생: "+ex);
			}
		}
		return list;
	}

	//전체 게시물 수를 가져오는 메서드-get
	public int getCount() {
		int result=0;
		String sql="select count(num) from board;";
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardDAO dao=BoardDAO.getInstance();
		try {
			conn=dao.getConnection();
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			rs.next();
			result=Integer.parseInt(rs.getString(1));
		}catch(Exception e){
			System.out.println("getCount() 접속 중 오류발생: "+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
			}catch(Exception ex){
				System.out.println("getCount() 접속 해제 중 오류발생: "+ex);
			}
		}		
		return result;
	}
	
	public List<BoardDTO> adminList() {
		List<BoardDTO> list = new ArrayList<BoardDTO>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from board where writer='admin';";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardDTO bDTO = new BoardDTO();
				bDTO.setNum(rs.getInt("num"));
				bDTO.setTitle(rs.getString("title"));
				bDTO.setContent(rs.getString("content"));
				bDTO.setWriter(rs.getString("writer"));
				bDTO.setReg_date(rs.getString("reg_date"));
				list.add(bDTO);
			}
			
		}catch(Exception e) {
			System.out.println("adminList ing error"+e);
		}finally {
			try {
				if(rs!=null)rs.close();
				if(pstmt!=null)pstmt.close();
				if(conn!=null)conn.close();
				
			}catch(Exception ex) {
				System.out.println("adminList end error"+ex);
			}
		}
		
		
		
		
		return list;
	}
	
}//메인끝
