package controller.sdq.test;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.SDQResultAnalysisDAO;
import model.dto.User;

/**
 * @author Seo Ji Woo
 *
 */

@WebServlet("/GetSDQAnalysisSelected")
public class GetSDQAnalysisSelected extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetSDQAnalysisSelected() {
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
		String time = (String) request.getParameter("time");
		request.setAttribute("time", time);
		
		String socialType = "사회지향행동";
		String excessiveType = "과잉행동";
		String emotionType = "정서증상";
		String behaviorType = "품행문제";
		String peerType = "또래문제";
		
		String normalRes = "정상";
		String boundaryRes = "경계선";
		String interventionRes = "개입 필요";
		
		int socialIntervention = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, socialType, interventionRes);
		int socialBoundary = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, socialType, boundaryRes);
		int socialNormal = 6;
		
		int excessiveNormal = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, excessiveType, normalRes);
		int excessiveBoundary = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, excessiveType, boundaryRes);
		int excessiveIntervention = 6;
		
		int emotionNormal = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, emotionType, normalRes);
		int emotionBoundary = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, emotionType, boundaryRes);
		int emotionIntervention = 6;
		
		int behaviorNormal = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, behaviorType, normalRes);
		int behaviorBoundary = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, behaviorType, boundaryRes);
		int behaviorIntervention = 6;
		
		int peerNormal = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, peerType, normalRes);
		int peerBoundary = SDQResultAnalysisDAO.getSDQAnalysisMax(conn, peerType, boundaryRes);
		int peerIntervention = 6;
		
		// SDQ 결과 분석 기준 확인
		/*
		System.out.println("GETSDQanalysis");
		System.out.println("social : " + socialIntervention + " , " + socialBoundary + " , " + socialNormal);
		System.out.println("excessive : " + excessiveIntervention + " , " + excessiveBoundary + " , " + excessiveNormal);
		System.out.println("emotion : " + emotionIntervention + " , " + emotionBoundary + " , " + emotionNormal);
		System.out.println("behavior : " + behaviorIntervention + " , " + behaviorBoundary + " , " + behaviorNormal);
		System.out.println("peer : " + peerIntervention + " , " + peerBoundary + " , " + peerNormal);
		*/
		
		
		session.setAttribute("socialIntervention", socialIntervention);	
		session.setAttribute("socialBoundary", socialBoundary);	
		session.setAttribute("socialNormal", socialNormal);	
		session.setAttribute("excessiveIntervention", excessiveIntervention);	
		session.setAttribute("excessiveBoundary", excessiveBoundary);
		session.setAttribute("excessiveNormal", excessiveNormal);
		session.setAttribute("emotionIntervention", emotionIntervention);	
		session.setAttribute("emotionBoundary", emotionBoundary);	
		session.setAttribute("emotionNormal", emotionNormal);	
		session.setAttribute("behaviorIntervention", behaviorIntervention);	
		session.setAttribute("behaviorBoundary", behaviorBoundary);	
		session.setAttribute("behaviorNormal", behaviorNormal);		
		session.setAttribute("peerIntervention", peerIntervention);		
		session.setAttribute("peerBoundary", peerBoundary);		
		session.setAttribute("peerNormal", peerNormal);
		session.setAttribute("focusUser", focusUser);
		RequestDispatcher rd = request.getRequestDispatcher("/GetSDQResultsAll");
		rd.forward(request, response);

		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
