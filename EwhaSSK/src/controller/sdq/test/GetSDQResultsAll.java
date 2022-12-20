package controller.sdq.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.SdqReplyDAO;
import model.dto.SdqReply;
import model.dto.User;

/**
 * @author Seo Ji Woo
 *
 */

@WebServlet("/GetSDQResultsAll")
public class GetSDQResultsAll extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetSDQResultsAll() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		User focusUser = new User();
		String locationUrl = "";
		if((User)session.getAttribute("selectedChild")!=null) {
			focusUser = (User)session.getAttribute("selectedChild");
			locationUrl = "../EwhaSSK/childInfo.jsp";
		}else {
			focusUser = (User)session.getAttribute("currUser");
			locationUrl = "../EwhaSSK/sdqtestmain.jsp";
		}
		int userid = focusUser.getUserId();
		int sdqNum = SdqReplyDAO.getTimesOfSdqTest(conn, userid);
		ArrayList<SdqReply> results = (ArrayList<SdqReply>) SdqReplyDAO.getSDQResultsAll(conn, userid);
		if(results.isEmpty()) {
			PrintWriter out = response.getWriter();
			out.println("<script>alert('테스트를 먼저 진행해주세요.'); location.href='"+locationUrl+"';</script>");
			out.flush();
		}
		else {
			session.setAttribute("results", results);
			
			ArrayList<Integer> scoreList = new ArrayList<Integer>();
	    	int testlogid = SdqReplyDAO.getRecentSdqTestId(conn, userid);
			
			
			for(int i = 0; i < 10; i++){
				String result = SdqReplyDAO.getSDQ(conn, testlogid, i+1).getSdqReplyContent();
				if(result.equals("전혀아니다")){
					scoreList.add(0);
				}
				else if(result.equals("조금그렇다")){
					scoreList.add(1);
				}
				else if(result.equals("그렇다")){
					scoreList.add(2);
				}
				else if(result.equals("매우그렇다")){
					scoreList.add(3);
				}
			}
			//System.out.println("sdqNum : " + sdqNum);
			System.out.println("Recent Result");
			System.out.println(scoreList);
			
			int social = 0;
			int excessive = 0;
			int emotion = 0;
			int behavior = 0;
			int peer = 0;
			
			for(int i = 0; i < 10; i++){
				if(i < 2){
					social += scoreList.get(i);
				}
				else if(i < 4){
					excessive += scoreList.get(i);
				}
				else if(i < 6){
					emotion += scoreList.get(i);
				}
				else if(i < 8){
					behavior += scoreList.get(i);
				}
				else if(i < 10){
					peer += scoreList.get(i);
				}
			}
			

			request.setAttribute("social", social);	
			request.setAttribute("excessive", excessive);	
			request.setAttribute("emotion", emotion);	
			request.setAttribute("behavior", behavior);
			request.setAttribute("peer", peer);		
			
			ArrayList<String> sdqTestDates = (ArrayList<String>) SdqReplyDAO.getSdqTestDates(conn, userid);
			System.out.println("GetSDQResultsAll :: sdqTestDates : " + sdqTestDates);
			ArrayList<String> sdqTestTimes = (ArrayList<String>) SdqReplyDAO.getSdqTestTimes(conn, userid);
			System.out.println("GetSDQResultsAll :: sdqTestTimes : " + sdqTestTimes);
			
			session.setAttribute("sdqTestDates", sdqTestDates);
			session.setAttribute("sdqTestTimes", sdqTestTimes);
			
			RequestDispatcher rd = request.getRequestDispatcher("/sdqresultprofile.jsp");
			rd.forward(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
