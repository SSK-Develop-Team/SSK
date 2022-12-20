package controller.esm.test;

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

import model.dao.ESMResultDAO;
import model.dto.EsmResult;
import model.dto.User;

/**
 * @author Seo Ji Woo
 *
 */

@WebServlet("/GetESMResultsSelectedGraph")
public class GetESMResultsSelectedGraph extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetESMResultsSelectedGraph() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);

		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");

		User focusUser = new User();
		if((User)session.getAttribute("selectedChild")!=null) {
			focusUser = (User)session.getAttribute("selectedChild");
		}else {
			focusUser = (User)session.getAttribute("currUser");
		}
		int userid = focusUser.getUserId();
		
		// ESM 결과 전체 session
		ArrayList<EsmResult> results = ESMResultDAO.getESMResultsAll(conn, userid);		
		session.setAttribute("results", results);
		
		// ESM 결과 dates session
		ArrayList<String> dates = ESMResultDAO.getESMDates(conn, userid);
		session.setAttribute("dates", dates);
		
		// 최근 날짜 ESMResult ArrayList 전달
		int indexOfDay = Integer.parseInt(request.getParameter("indexOfDay"));
		ArrayList<EsmResult> resultsOfDay = new ArrayList<EsmResult>();
		ArrayList<String> timeOfDay = new ArrayList<String>();
		ArrayList<Integer> positiveOfDay = new ArrayList<Integer>();
		ArrayList<Integer> negativeOfDay = new ArrayList<Integer>();
		for(int i = 0; i < results.size(); i++) {
			System.out.println(i + "results getRecentdate: " + dates.get(indexOfDay));
			System.out.println(i + "results getReplydate: " + results.get(i).getReplyDate().toString());
			if((results.get(i).getReplyDate().toString()).equals(dates.get(indexOfDay))) {
				System.out.println("same");
				resultsOfDay.add(results.get(i));
			}
		}
		int positive = 0;
		int negative = 0;
		for(int i = 0; i < resultsOfDay.size(); i++) {
			if(resultsOfDay.get(i).getEsmEmotionId() <= 5) {
				positive += resultsOfDay.get(i).getUserReply();
			}
			else {
				negative += resultsOfDay.get(i).getUserReply();
			}
			if(i % 10 == 0) {
				timeOfDay.add(resultsOfDay.get(i).getReplyTime());
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
