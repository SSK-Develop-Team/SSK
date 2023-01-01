package controller.sdq;

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

import model.dao.SdqResultAnalysisDAO;
import model.dto.SdqReply;
import model.dto.SdqResultAnalysis;
import model.dto.User;
import util.process.SdqProcessor;

/**
 * @author Jiwon Lee
 * 
 * SDQ 검사 직후 결과를 보여주는 서블릿
 */
@WebServlet("/GetSdqResult")
public class GetSdqResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetSdqResult() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		   
		HttpSession session = request.getSession(true);
		  
		// for DB Connection
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		User currUser = (User)session.getAttribute("currUser");
		
		ArrayList<SdqReply> sdqReplyList = (ArrayList<SdqReply>)request.getAttribute("sdqReplyList");
		
		// 코드/DB 리팩토링 필요
		String[] sdqTypeList = {"사회지향행동", "과잉행동","정서증상","품행문제","또래문제"};
		int[] scoreList = SdqProcessor.getSdqReplyListToSdqResult(sdqReplyList);
		ArrayList<SdqResultAnalysis> sdqResultAnalysisList = new ArrayList<SdqResultAnalysis>();
		for(int i=0;i<5;i++) {
			System.out.println(scoreList[i]);
		}
		for(int i=0;i<sdqTypeList.length;i++) {
			sdqResultAnalysisList.add(SdqResultAnalysisDAO.findSdqResultAnalysisByTypeAndValue(conn, sdqTypeList[i],scoreList[i]));
			System.out.println(sdqResultAnalysisList.get(i).getSdqType());
		}
		
		request.setAttribute("sdqResultAnalysisList", sdqResultAnalysisList);
		request.setAttribute("sdqScoreList", scoreList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/sdqResult.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
