package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.JobsheetDAO;
import DTO.JobsheetDTO;


@WebServlet("/sheetwrite.do")
public class sheetwriteSevlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String m_num = request.getParameter("m_num");
		String sheet_date = request.getParameter("date");
		String text_area1 = request.getParameter("text_area1");
		String text_area2 = request.getParameter("text_area2");
		
		JobsheetDTO jDTO = new JobsheetDTO();
		jDTO.setM_num(m_num);
		jDTO.setSheet_date(sheet_date);
		jDTO.setText_area1(text_area1);
		jDTO.setText_area2(text_area2);
		
		JobsheetDAO jDAO = new JobsheetDAO();
		jDAO.insertSheet(jDTO);
		
		request.getRequestDispatcher("jobsheet.jsp").forward(request, response);
	}

}
