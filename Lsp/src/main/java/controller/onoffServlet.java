package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import java.sql.*;
import DTO.MemberDTO;
import DAO.MemberDAO;


@WebServlet("*.one")
public class onoffServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("onoff.jsp").forward(request,response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		MemberDAO mDAO = MemberDAO.getInstance();
		HttpSession session = request.getSession();
		String m_num = (String)session.getAttribute("m_num");
		String uri = request.getRequestURI();
		System.out.print(m_num);
		int lastSlash = uri.lastIndexOf("/");
		
		String commandStr = uri.substring(lastSlash);
		
		
		if(commandStr.equals("/on.one")) {
			System.out.println("출근");
			mDAO.insertOnoff(m_num, 1);
			request.getRequestDispatcher("onoff.jsp").forward(request, response);
		}else if(commandStr.equals("/off.one")) {
			System.out.println("퇴근");
			mDAO.insertOnoff(m_num, 2);
			request.getRequestDispatcher("onoff.jsp").forward(request, response);
		}
	}

}
