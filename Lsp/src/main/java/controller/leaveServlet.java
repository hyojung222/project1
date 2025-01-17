package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import DTO.VacationDTO;
import DAO.VacationDAO;


@WebServlet("*.leave")
public class leaveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("leave.jsp").forward(request,response);
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		VacationDTO vDTO = new VacationDTO();
		VacationDAO vDAO = new VacationDAO();
		String m_num = (String)session.getAttribute("m_num");
		int leavetype = Integer.parseInt(request.getParameter("leavetype"));
		String leave_start = request.getParameter("leave_start");
		String leave_end = request.getParameter("leave_end");
		String reason = request.getParameter("reason");
		String bancha_time = request.getParameter("bancha_time");
		
		System.out.println(m_num);
		System.out.println(leavetype);
		System.out.println(leave_start);
		System.out.println(leave_end);
		System.out.println(reason);
		
		vDTO.setM_num(m_num);
		vDTO.setLeavetype(leavetype);
		vDTO.setLeave_start(leave_start);
		vDTO.setLeave_end(leave_end);
		vDTO.setReason(reason);
		vDTO.setBancha_time(bancha_time);
		vDAO.insertVacation(vDTO);
		
		/*String uri = request.getRequestURI();
		int lastSlash = uri.lastIndexOf("/");
		String commandStr = uri.substring(lastSlash);
		
		if(commandStr=="/data1.leave") {
			
		}else if(commandStr=="/data2.leave") {
			
		}else if(commandStr=="/data3.leave") {
			
		}else if(commandStr=="/data4.leave") {
			
		}*/
		
		int a=vDAO.vacation_check(m_num); //연차 사용 갯수
		int b=vDAO.bancha_check(m_num); //반차 사용 갯수
		int c=vDAO.annaul_number_check(m_num); //전체 연가 갯수
		double d=c-(a+(b*0.5));
		String d_d = Double.toString(d);
		session.setAttribute("e", d_d);
		
		request.getRequestDispatcher("leave.jsp").forward(request,response);
		
	}

}
