package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import DAO.BoardDAO;
import DTO.BoardDTO;

@WebServlet("/board_modify.do")
public class board_1_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//게시글 수정
		request.setCharacterEncoding("utf-8");
		int num =Integer.parseInt(request.getParameter("num"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		BoardDTO bDTO = new BoardDTO();
		bDTO.setNum(num);
		bDTO.setTitle(title);
		bDTO.setContent(content);		
		BoardDAO dao=BoardDAO.getInstance();
		dao.updateboard(bDTO);
		response.sendRedirect("board.do?currentPage=1&recordsPerPage=5");
	}

}
