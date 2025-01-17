package controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.*;

import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;
import DTO.MemberDTO;
import DAO.MemberDAO;



@WebServlet("/register.do")
public class registerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		ServletContext context = getServletContext();
		String path = context.getRealPath("/img");
		
		System.out.println(path);
		String encType="utf-8";
		int sizeLimit = 20*1024*1024;
		
		MultipartRequest multi = new MultipartRequest(request,path,sizeLimit,encType,new DefaultFileRenamePolicy());
		String m_num = multi.getParameter("m_num");
		String name= multi.getParameter("name");
		String pw = multi.getParameter("pw");
		
		int join_date = Integer.parseInt(multi.getParameter("join_date"));
		String address = multi.getParameter("address");
		String phone = multi.getParameter("phone");
		String email = multi.getParameter("email");
		String photo = multi.getFilesystemName("photo");
		int admin = Integer.parseInt(multi.getParameter("admin"));
		int annual_number =Integer.parseInt(multi.getParameter("annual_number"));
		
		MemberDTO mDTO = new MemberDTO();
		mDTO.setM_num(m_num);
		mDTO.setName(name);
		mDTO.setPw(pw);
		mDTO.setJoin_date(join_date);
		mDTO.setAddress(address);
		mDTO.setPhoto("/img/"+photo);
		mDTO.setPhone(phone);
		mDTO.setEmail(email);
		mDTO.setAdmin(admin);
		mDTO.setAnnual_number(annual_number);
		
		MemberDAO mDAO = MemberDAO.getInstance();
		mDAO.registerMember(mDTO);
		
		request.getRequestDispatcher("main.jsp").forward(request, response);
		
		
	}

}
