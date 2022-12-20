package controller.sdq.test;

import java.io.IOException;
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

@WebServlet("/GetSDQResultSelected")
public class GetSDQResultSelected extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetSDQResultSelected() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		// for DB Connection
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		

		String time = (String) request.getParameter("time");
		String date = time.split(" ")[0];
		time = time.split(" ")[1];
		System.out.println("GetSDQResultSelected :: Selected date and time : " + date + " // " + time);
		
		User focusUser = new User();
		if((User)session.getAttribute("selectedChild")!=null) {
			focusUser = (User)session.getAttribute("selectedChild");
		}else {
			focusUser = (User)session.getAttribute("currUser");
		}
		int userid = focusUser.getUserId();
		session.setAttribute("currUser", focusUser);
		//int testNum = currUser.getTotalNumberOfSdqTest() - 1;
		
		ArrayList<SdqReply> results = (ArrayList<SdqReply>) SdqReplyDAO.getSDQResultValue(conn, userid, date, time);
		ArrayList<Integer> scoreList = new ArrayList<Integer>();
		
		for(int i = 0; i < 10; i++){
			String result = results.get(i).getSdqReplyContent();
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
		
		// 선택된 결과 분야별 확인
		/*System.out.println("social : " + social);
		System.out.println("excessive : " + excessive);
		System.out.println("emotion : " + emotion);
		System.out.println("behavior : " + behavior);
		System.out.println("peer : " + peer);*/
		
		RequestDispatcher rd = request.getRequestDispatcher("/sdqresultprofile.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
