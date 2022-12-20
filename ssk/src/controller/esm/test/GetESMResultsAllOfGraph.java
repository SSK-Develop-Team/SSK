package controller.esm.test;

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

import model.dao.EsmReplyDAO;
import model.dto.EsmReply;
import model.dto.User;

/**
 * @author Seo Ji Woo
 *
 */

@WebServlet("/GetESMResultsAllOfGraph")
public class GetESMResultsAllOfGraph extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetESMResultsAllOfGraph() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");

		User focusUser = new User();
		int userid = 0;
		// esm 결과값 userid 로 전체 불러오기
		ArrayList<EsmReply> results = new ArrayList<EsmReply>();
		if((User)session.getAttribute("selectedChild")!=null) {
			focusUser = (User)session.getAttribute("selectedChild");
			userid = focusUser.getUserId();
			results = (ArrayList<EsmReply>) EsmReplyDAO.getESMResultsAll(conn, userid);		
			if(results.isEmpty()) {
				PrintWriter out = response.getWriter();
				out.println("<script>alert('기록을 먼저 진행해주세요.'); history.go(-1);</script>");
				out.flush();
			}
			
		}else {
			focusUser = (User)session.getAttribute("currUser");
			userid = focusUser.getUserId();
			results = (ArrayList<EsmReply>) EsmReplyDAO.getESMResultsAll(conn, userid);		
			if(results.isEmpty()) {
				PrintWriter out = response.getWriter();
				out.println("<script>alert('기록을 먼저 진행해주세요.'); location.href='../EwhaSSK/esmtestmain.jsp';</script>");
				out.flush();
			}
		}
		
		boolean isTesting = false;
		session.setAttribute("isTesting", isTesting);
		
		
		session.setAttribute("results", results);
		
		// ESM 결과 dates session
		ArrayList<String> dates = (ArrayList<String>) EsmReplyDAO.getEsmTestDates(conn, userid);
		session.setAttribute("dates", dates);
		
		ArrayList<String> times = (ArrayList<String>) EsmReplyDAO.getEsmTestTimes(conn,  userid);
		
		// 최근 날짜 ESMResult ArrayList 전달
		int indexOfDay = dates.size() - 1;

		session.setAttribute("maxIndex", indexOfDay);
		
		ArrayList<EsmReply> resultsOfDay = new ArrayList<EsmReply>();
		ArrayList<String> timeOfDay = new ArrayList<String>();
		ArrayList<Integer> positiveOfDay = new ArrayList<Integer>();
		ArrayList<Integer> negativeOfDay = new ArrayList<Integer>();
		for(int i = 0; i < results.size(); i++) {
			if(dates.get(i).equals(dates.get(indexOfDay))) {
				resultsOfDay.add(results.get(i));
			}
		}
		System.out.println("GetESMResultsAllOfGraph :: resultsOfDay : " + resultsOfDay);
		
		int positive = 0;
		int negative = 0;
		for(int i = 0; i < resultsOfDay.size(); i++) {
			if(resultsOfDay.get(i).getEsmEmotionId() <= 5) {
				positive += resultsOfDay.get(i).getEsmReplyContent();
			}
			else {
				negative += resultsOfDay.get(i).getEsmReplyContent();
			}
			if(i % 10 == 0) {
				timeOfDay.add(times.get(i));
				System.out.println("GetESMResultsAllOfGraph :: timeOfDay : " + timeOfDay);
			}
			if((i + 1) % 10 == 0) {
				positiveOfDay.add(positive);
				negativeOfDay.add(negative);
				positive = 0;
				negative = 0;
			}
		}
		System.out.println(timeOfDay);
		System.out.println(positiveOfDay);
		System.out.println(negativeOfDay);
		request.setAttribute("timeOfDay", timeOfDay);
		request.setAttribute("positiveOfDay", positiveOfDay);
		request.setAttribute("negativeOfDay", negativeOfDay);
		
		request.setAttribute("resultsOfDay", resultsOfDay);
		System.out.println(resultsOfDay);

		System.out.println(indexOfDay);
		// 날짜 index request 전달 (가장 최근 날짜 index 전달)
		request.setAttribute("indexOfDay", indexOfDay);
		
		RequestDispatcher rd = request.getRequestDispatcher("esmresultgraph.jsp");
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
