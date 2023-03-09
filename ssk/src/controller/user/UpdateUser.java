package controller.user;

import model.dao.UserDAO;
import model.dto.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;

/**
 * @author Jiwon Lee
 * - 관리자, 전문가가 아동 계정을 수정하는 경우
 * - 관리자가 전문가 계정을 수정하는 경우
 */
@WebServlet(name = "UpdateUser", value = "/UpdateUser")
public class UpdateUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
       
        ServletContext sc = getServletContext();
        Connection conn= (Connection) sc.getAttribute("DBconnection");
        
        int userid = Integer.parseInt(request.getParameter("originUserId"));
        String userloginid = request.getParameter("userId");
	    String userpw = request.getParameter("userPw");
		String username = request.getParameter("userName");
		String userEmail = request.getParameter("userEmail");
		String userRole = request.getParameter("userRole");
		String usergender = request.getParameter("userGender");
		String userbirth = request.getParameter("userBirth");

		Date birth=null;
		Date registrationDate = new Date(System.currentTimeMillis());
		
		if(userbirth!=null) {
			String year = userbirth.split("-")[0];
			String month = userbirth.split("-")[1];
			String day = userbirth.split("-")[2];
			
			//전문가는 따로 관리, 추후 삭제할 코드 주석 처리
			birth = Date.valueOf(Integer.parseInt(year)+"-"+Integer.parseInt(month)+"-"+Integer.parseInt(day));
		}
		
		User user = new User();
				user.setUserId(userid);
				user.setUserLoginId(userloginid);
				user.setUserPassword(userpw);
				user.setUserName(username);
				user.setUserEmail(userEmail);
				user.setUserRole(userRole);
				user.setRegistrationDate(registrationDate);
				user.setUserGender(usergender);
				user.setUserBirth(birth);
				user.setUserIcon("");
				
		boolean update_result = false;

				
		update_result = UserDAO.updateUser(conn, user);
		String update_msg = update_result?"계정이 수정되었습니다.":"계정 수정에 실패했습니다.";

		String location=userRole.equals("CHILD")?"GetManageChild":"GetAdminHome";

		PrintWriter out = response.getWriter();
		out.println("<script>alert('"+update_msg+"'); location.href='"+location+"';</script>");
		out.flush();

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
