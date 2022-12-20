package controller.expert.manage;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.AgeGroupDAO;
import model.dao.UserDAO;
import model.dto.User;

/**
 * @author Lee Ji Won
 * 아동 회원가입 - 전문가가 아동 계정을 생성할 때
 */
@WebServlet("/DoRegisterChild")
public class DoRegisterChild extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DoRegisterChild() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");

		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		HttpSession session = request.getSession(true);
		User currUser = (User)session.getAttribute("currUser");
		
	    String userid = request.getParameter("userid");
	    String userpw = request.getParameter("userpw");
		String userpwchk = request.getParameter("userpwchk");
		String username = request.getParameter("username");
		String usergender = request.getParameter("usergender");
		String userbirth = request.getParameter("userbirth");
		
		//빈 칸 확인
		if (userid.equals("")) {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('아이디를 입력하세요.'); location.href='../EwhaSSK/registerChild.jsp';</script>");
			out.flush();
		}else if (userpw.equals("")) {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('패스워드를 입력해주세요.'); location.href='../EwhaSSK/registerChild.jsp';</script>");
			out.flush();
		}else if(userpwchk.equals("") ){
			PrintWriter out = response.getWriter();
			out.println("<script>alert('패스워드를 확인해주세요.'); location.href='../EwhaSSK/registerChild.jsp';</script>");
			out.flush();
		}else if(username.equals("") ){
			PrintWriter out = response.getWriter();
			out.println("<script>alert('아동 이름을 입력해주세요.'); location.href='../EwhaSSK/registerChild.jsp';</script>");
			out.flush();
		}else if(usergender.equals("") ){
			PrintWriter out = response.getWriter();
			out.println("<script>alert('아동 성별을 입력해주세요.'); location.href='../EwhaSSK/registerChild.jsp';</script>");
			out.flush();
		}else if(userbirth.equals("") ){
			PrintWriter out = response.getWriter();
			out.println("<script>alert('아동 생년월일을 입력해주세요.'); location.href='../EwhaSSK/registerChild.jsp';</script>");
			out.flush();
		}
		//비밀번호 확인
		if(!userpw.equals(userpwchk)) {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('비밀번호를 확인해주세요.'); location.href='../EwhaSSK/registerChild.jsp';</script>");
			out.flush();
		}
		
		String year = userbirth.split("-")[0];
		String month = userbirth.split("-")[1];
		String day = userbirth.split("-")[2];
		
		/*현재 개월 수(나이) 구하기*/
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		
		String nowDate = formatter.format(calendar.getTime());
		
		String nowYear = nowDate.split("-")[2];
		String nowMonth = nowDate.split("-")[1];
		
		int curYear = Integer.parseInt(nowYear);
		int curMonth = Integer.parseInt(nowMonth);
		
		int userYear = Integer.parseInt(year);
		int userMonth = Integer.parseInt(month);
		int userDay = Integer.parseInt(day);
		
		int nowAge = (curYear - userYear) * 12 + (curMonth - userMonth);
		
		/*현재 AgeGroup 받아오기*/
		int curAge = AgeGroupDAO.getCurrAge(conn, nowAge);
		
		String userIconStr = "";
		if(usergender.equals("male"))userIconStr = "./image/userIconBoy.png";
		else userIconStr = "./image/userIconGirl.png";
		
		Date birth = Date.valueOf(userYear+"-"+userMonth+"-"+userDay);
		
		User user = new User();
		user.setUserLoginId(userid);
		user.setUserPassword(userpw);
		user.setUserName(username);
		user.setUserGender(usergender);
		user.setUserBirth(birth);
		user.setUserRole("CHILD");
		user.setExpertId(currUser.getUserId());
		user.setUserIcon(userIconStr);
		user.setCurrentAge(curAge);
		
		boolean join_result = false;
				
		join_result = UserDAO.insertUser(conn, user);
		if(join_result == false) {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('아동 정보를 확인해주세요.'); location.href='../EwhaSSK/registerChild.jsp';</script>");
			out.flush();
		}
		else { 
			PrintWriter out = response.getWriter();
			out.println("<script>alert('아동 회원가입 성공'); location.href='../EwhaSSK/GetExpertHome';</script>");
			out.flush();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

