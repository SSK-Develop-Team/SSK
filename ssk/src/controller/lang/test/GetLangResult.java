package controller.lang.test;

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

import model.dao.LangQuestionDAO;
import model.dao.LangReplyDAO;
import model.dao.LangTestLogDAO;
import model.dto.LangQuestion;
import model.dto.LangReply;
import model.dto.LangTestLog;

/**
 * @author Jiwon Lee
 * 언어 발달 평가의 최종 결과를 받아오는 서블릿
 */
@WebServlet("/GetLangResult")
public class GetLangResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetLangResult() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection)sc.getAttribute("DBconnection");
		
		int langTestLogId = (int)request.getAttribute("currLangTestLogId");
		
		LangTestLog langTestLog = LangTestLogDAO.getLangTestLogById(conn, langTestLogId);
		
		ArrayList<LangReply> langReplyList = LangReplyDAO.getLangReplyListByLangTestLogId(conn, langTestLogId);
		
		ArrayList<LangQuestion> langQuestionList  = new ArrayList<LangQuestion>();
		
		for(int i=0;i<langReplyList.size();i++) {//langType을 받아오기
			langQuestionList.add(LangQuestionDAO.getLangQuestionById(conn, langReplyList.get(i).getLangQuestionId()));
		}
		
		request.setAttribute("langTestLog", langTestLog);
		request.setAttribute("langReplyList", langReplyList);
		request.setAttribute("langQuestionList",  langQuestionList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/langTestResult.jsp");
		rd.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
