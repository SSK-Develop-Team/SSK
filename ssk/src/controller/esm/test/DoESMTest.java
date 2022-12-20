package controller.esm.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.EsmReplyDAO;
import model.dao.UserDAO;
import model.dto.EsmTestLog;
import model.dto.User;

/**
 * @author Seo Ji Woo
 *
 */

@WebServlet("/doESMTest")
public class DoESMTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public DoESMTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		boolean isTesting = false;
		session.setAttribute("isTesting", isTesting);
		
		User currUser = (User)session.getAttribute("currUser");
		
		int userid = currUser.getUserId();
		ArrayList<String> replyList = new ArrayList<String>();
		ArrayList<Integer> scoreList = new ArrayList<Integer>();
		
		replyList.add(request.getParameter("active"));
		replyList.add(request.getParameter("proud"));
		replyList.add(request.getParameter("passionate"));
		replyList.add(request.getParameter("interested"));
		replyList.add(request.getParameter("excited"));
		
		replyList.add(request.getParameter("afraid"));
		replyList.add(request.getParameter("scared"));
		replyList.add(request.getParameter("jittery"));
		replyList.add(request.getParameter("nervous"));
		replyList.add(request.getParameter("distressed"));
		
		//System.out.println(replyList);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String ss = sdf.format(new java.util.Date());
		java.sql.Date testDate = java.sql.Date.valueOf(ss);
		
		Date today = new Date();   

		@SuppressWarnings("deprecation")
		int hour = today.getHours(); 
		@SuppressWarnings("deprecation")
		int minute = today.getMinutes();
		@SuppressWarnings("deprecation")
		int second = today.getSeconds(); 
		String hours = Integer.toString(hour);
		String minutes = Integer.toString(minute);
		String seconds = Integer.toString(second);
		
		if(hour < 10) {
			hours = "0" + hours;
		}
		if(minute < 10) {
			minutes = "0" + minutes;
		}
		if(second < 10) {
			seconds = "0" + seconds;
		}
		
		String timeStr = hours + ':' + minutes  + ':' + seconds;
		System.out.println("testDateTime : " + testDate + " :: " + timeStr);

		// esm_test_log 삽입
		EsmTestLog log = new EsmTestLog();
		log.setUserId(userid);
		log.setEsmTestDate(testDate);
		log.setEsmTestTime(timeStr);
		boolean insertLog = EsmReplyDAO.insertESMTestLog(conn, log);
		
		for(int i = 0; i < 10; i++){
			
			switch(replyList.get(i)) {
				case "never":
					scoreList.add(1);
					break;
				case "no":
					scoreList.add(2);
					break;
				case "soso":
					scoreList.add(3);
					break;
				case "yes":
					scoreList.add(4);
					break;
				case "very":
					scoreList.add(5);
					break;
				default:
					break;
			}

			/*응답 삽입*/

			int testlogid = EsmReplyDAO.getRecentEsmTestId(conn, userid);
			boolean result = EsmReplyDAO.insertESMResult(conn, testlogid, i+1, scoreList.get(i));
			
			// 응답 삽입 확인
			/*if(result){
				System.out.println("success");
			}*/
			
		}
		
		
		request.setAttribute("replyLilst", replyList);
		
		PrintWriter out = response.getWriter();
		out.println("<script>location.href='../EwhaSSK/getESMResult';</script>");
		session.setAttribute("currUser", currUser);
		out.flush();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
