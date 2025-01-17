package controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import DAO.MemberDAO;
import DTO.MemberDTO;
import com.oreilly.servlet.*;
import com.oreilly.servlet.multipart.*;


@WebServlet("/mypage.do")
public class mypageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();
		String m_num = (String)session.getAttribute("m_num");
		MemberDAO mDAO = MemberDAO.getInstance();
		MemberDTO mDTO = new MemberDTO();
		mDTO = mDAO.showMember(m_num);
		
		request.setAttribute("mDTO", mDTO);
		request.getRequestDispatcher("mypage.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		ServletContext context = getServletContext();
		String path = context.getRealPath("/img");
		int maxSize = 10*1024*1024;
		String encType = "utf-8";
		
		MultipartRequest multi = new MultipartRequest(request , path, maxSize, encType,new DefaultFileRenamePolicy());
		MemberDTO mDTO = new MemberDTO();
		MemberDAO mDAO = MemberDAO.getInstance();
		
		String m_num = multi.getParameter("m_num");
		String pw = multi.getParameter("pw");
		String phone = multi.getParameter("phone");
		String email = multi.getParameter("email");
		String address = multi.getParameter("address");
		String photo = multi.getFilesystemName("photo");
		
		String originPhoto = multi.getParameter("originPhoto");
		if(photo == null) {
			photo = originPhoto;
		}else {
			photo = "/img/"+photo;
		}
		
		System.out.println("사번" +m_num);
		System.out.println("pw : "+pw);
		System.out.println("phone: "+phone);
		System.out.println("email : "+email);
		System.out.println("address : "+address);
		
		System.out.println(photo);
		
		mDTO.setM_num(m_num);
		mDTO.setPw(pw);
		mDTO.setPhone(phone);
		mDTO.setEmail(email);
		mDTO.setPhoto(photo);
		mDTO.setAddress(address);
		
		
		
		int updateResult = mDAO.updateMember(mDTO);
		System.out.println(updateResult);
		request.getRequestDispatcher("main.jsp").forward(request, response);
				
	}

}
