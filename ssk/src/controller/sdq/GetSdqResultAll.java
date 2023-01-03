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

import model.dao.SdqReplyDAO;
import model.dao.SdqResultAnalysisDAO;
import model.dao.SdqTestLogDAO;
import model.dto.SdqReply;
import model.dto.SdqResultAnalysis;
import model.dto.SdqTestLog;
import model.dto.User;
import util.process.SdqProcessor;

/**
 * @author Jiwon Lee
 * Sdq 모든 검사 결과 가져오기
 * Sdq 드롭다운에서 선택한 검사 결과 가져오기(default : 가장 최근 결과를 뷰로 전달)
 */
@WebServlet("/GetSdqResultAll")
public class GetSdqResultAll extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetSdqResultAll() {
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
		
		/*해당 회원의 모든 SDQ 검사 기록 가져오기*/
		ArrayList<SdqTestLog> sdqTestLogList = SdqTestLogDAO.getSdqTestLogAllByUserId(conn, currUser.getUserId());
		
		int selectedSdqTestLogId = Integer.parseInt(request.getParameter("selectedSdqTestLogId"));
		SdqTestLog selectedSdqTestLog = null;
		ArrayList<SdqReply> sdqReplyList = new ArrayList<SdqReply>();
		
		if(selectedSdqTestLogId==0) {
			selectedSdqTestLog = sdqTestLogList.get(sdqTestLogList.size()-1);
			sdqReplyList = SdqReplyDAO.getSdqReplyListBySdqTestLogId(conn, selectedSdqTestLog.getSdqTestLogId());
		}else {
			sdqReplyList = SdqReplyDAO.getSdqReplyListBySdqTestLogId(conn, selectedSdqTestLogId);
		}
		
		// 코드/DB 리팩토링 필요
		String[] sdqTypeList = {"사회지향행동", "과잉행동","정서증상","품행문제","또래문제"};
		int[] scoreList = SdqProcessor.getSdqReplyListToSdqResult(sdqReplyList);
		ArrayList<SdqResultAnalysis> sdqResultAnalysisList = new ArrayList<SdqResultAnalysis>();

		for(int i=0;i<sdqTypeList.length;i++) {
			sdqResultAnalysisList.add(SdqResultAnalysisDAO.findSdqResultAnalysisByTypeAndValue(conn, sdqTypeList[i],scoreList[i]));
		}
		
		request.setAttribute("sdqResultAnalysisList", sdqResultAnalysisList);
		request.setAttribute("sdqScoreList", scoreList);
		request.setAttribute("sdqTestLogList", sdqTestLogList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/sdqResultAll.jsp");
		rd.forward(request, response);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
