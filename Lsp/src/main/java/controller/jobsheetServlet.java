package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import DTO.JobsheetDTO;
import DAO.JobsheetDAO;

@WebServlet("/sheet.do")
public class jobsheetServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String m_num = request.getParameter("m_num");
		String date = request.getParameter("date");
		String text_area1 = request.getParameter("text_area1");
		String text_area2 = request.getParameter("text_area2");
		
		JobsheetDTO jDTO = new JobsheetDTO();
		jDTO.setM_num(m_num);
		jDTO.setSheet_date(date);
		jDTO.setText_area1(text_area1);
		jDTO.setText_area2(text_area2);
		
		
		JobsheetDAO jDAO = new JobsheetDAO();
		jDAO.insertSheet(jDTO);
		
		
		
		
		request.getRequestDispatcher("jobsheet.jsp").forward(request, response);
		
	}
		
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	 request.setCharacterEncoding("utf-8");
	 response.setCharacterEncoding("utf-8");
	 response.setContentType("sheet/xml");
	 String getdate=request.getParameter("getdate");  //검색 날짜
	 String m_num = request.getParameter("m_num");
	 System.out.println(getdate);
	 JobsheetDAO jDAO = new JobsheetDAO();
	 String msg = jDAO.showText(getdate , m_num);
	 System.out.println(msg);
	 
	 
	 String responseText="작성일자: "+getdate+", 내용: "+msg;   //DB에서 받아온 데이터 여기에 넣어주세요!!!
	 PrintWriter out=response.getWriter();
	 out.println(responseText);
	 out.close();
	 ;
	}

}
