package controller;

import java.io.*;
import java.time.LocalDate;
import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;


import DAO.BoardDAO;
import DTO.BoardDTO;


@WebServlet("/board.do")
public class boardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {		
		//페이징 처리		
		int currentPage=Integer.parseInt(request.getParameter("currentPage"));
		int recordsPerPage=Integer.parseInt(request.getParameter("recordsPerPage"));				
		BoardDAO dao=BoardDAO.getInstance();		
		List<BoardDTO> list=dao.findList(currentPage, recordsPerPage);		
		List<BoardDTO> adminList = dao.adminList();
		request.setAttribute("data", list);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("recordsPerPage", recordsPerPage);		
		request.setAttribute("adminList", adminList);
		int count=dao.getCount();  
		int npage=count/recordsPerPage;  
		if(count%recordsPerPage>0) {   
			npage++;                   
		}
		request.setAttribute("npage", npage);  		
		RequestDispatcher dis=request.getRequestDispatcher("notice.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 입력
		request.setCharacterEncoding("utf-8");			
		BoardDTO bDTO = new BoardDTO();		
		int num=0;
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		LocalDate now = LocalDate.now();		     
		String reg_date = now.toString();		
		bDTO.setNum(num);
		bDTO.setTitle(title);
		bDTO.setContent(content);
		bDTO.setReg_date(reg_date);		
		BoardDAO dao=BoardDAO.getInstance();
		dao.insertboard(bDTO);
		response.sendRedirect("board.do?currentPage=1&recordsPerPage=5");
	}

}
