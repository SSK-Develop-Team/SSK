package controller.esm.test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dto.EsmReply;
import model.dto.EsmResult;
import model.dto.User;

/**
 * @author Seo Ji Woo
 *
 */

/**
 * Servlet implementation class GetESMResultsAllOfWeekGraph
 */
@WebServlet("/GetESMResultsAllOfWeekGraph")
public class GetESMResultsAllOfWeekGraph extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetESMResultsAllOfWeekGraph() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		// for DB Connection
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		// currentUser
		User currUser = (User)session.getAttribute("currUser");
		int userid = currUser.getUserId();
		
		// isTesting = false
		boolean isTesting = false;
		session.setAttribute("isTesting", isTesting);
		
		// ESMResults 전체
		ArrayList<EsmReply> results = (ArrayList<EsmReply>)session.getAttribute("results");

		// 조회 기간 및 기간 동안의 positive, negative 값 ArrayList
		ArrayList<String> daysOfWeek = new ArrayList<String>();
		ArrayList<Integer> positive = new ArrayList<Integer>();
		ArrayList<Integer> negative = new ArrayList<Integer>();
		
		// 오늘 기준 주 간격
		int indexOfWeek = 1;
		
		// 오늘 날짜
		Calendar cal = Calendar.getInstance();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		
		// 주 간격에 따른 시작 날짜 설정
		System.out.println("today : " + cal.DAY_OF_MONTH);
		cal.add(Calendar.DATE, - (7 * indexOfWeek));
		System.out.println(cal);
		System.out.println("yesterday : " + dateFormat.format(cal.getTime()));
		
		// 조회 기간 설정 및 add
		for(int i = 0; i < 7; i++) {
			cal.add(Calendar.DATE, 1);
			System.out.println(i+"st : " + dateFormat.format(cal.getTime()));
			daysOfWeek.add(dateFormat.format(cal.getTime()));
		}
		
		// value, average, testSize
		int positiveValue = 0;
		int negativeValue = 0;
		int positiveAverage = 0;
		int negativeAverage = 0;
		int testSize = 0;
		/*String dateStandard = daysOfWeek.get(0);
		for(int i = 0; i < results.size(); i++) {
			for(int j = 0; j < daysOfWeek.size(); j++) {
				if(results.get(i).getReplyDate().toString().equals(daysOfWeek.get(j))){
					if(results.get(i).getEsmEmotionId() <= 5) {
						positiveValue += results.get(i).getUserReply();
						if(!dateStandard.equals(results.get(i).getReplyDate().toString()) && results.get(i).getEsmEmotionId() == 5) {
							positive.add(positiveValue);
							positiveValue = 0;
							dateStandard = daysOfWeek.get(j);
						}
					}
					else {
						negativeValue += results.get(i).getUserReply();
						if(results.get(i).getEsmEmotionId() == 10) {
							negative.add(negativeValue);
							negativeValue = 0;
						}
					}
					
				}
			}
		}*/
		
		// positiveAverage, negativeAverage add to ArrayList
		for(int i = 0; i < daysOfWeek.size(); i++) {
			positiveValue = 0;
			negativeValue = 0;
			positiveAverage = 0;
			negativeAverage = 0;
			testSize = 0;
			for(int j = 0; j < results.size(); j++) {
				if(results.get(j).getReplyDate().toString().equals(daysOfWeek.get(i))) {
					if(results.get(j).getEsmEmotionId() <= 5) {
						positiveValue += results.get(j).getUserReply();
					}
					else {
						negativeValue += results.get(j).getUserReply();
						if(results.get(j).getEsmEmotionId() == 10)
							testSize++;
					}
				}
			}

			if(positiveValue == 0)
				testSize = 1;
			positiveAverage = positiveValue / testSize;
			positive.add(positiveAverage);
			
			if(negativeValue == 0) {
				testSize = 1;
			}
			negativeAverage = negativeValue / testSize;
			negative.add(negativeAverage);
		}
		System.out.println(daysOfWeek);
		System.out.println("positive : " + positive);
		System.out.println("negative : " + negative);
		
		// request
		request.setAttribute("daysOfWeek", daysOfWeek);
		request.setAttribute("positive", positive);
		request.setAttribute("negative", negative);
		request.setAttribute("indexOfWeek", indexOfWeek);
		
		// 이동
		RequestDispatcher rd = request.getRequestDispatcher("esmResultProfileOfWeek.jsp");
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
