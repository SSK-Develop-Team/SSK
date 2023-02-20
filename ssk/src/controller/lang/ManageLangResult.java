package controller.lang;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.NoSuchElementException;

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
import model.dto.User;

/**
 * 
 * 언어 발달 평가 저장 및 호출 준비
 */
@WebServlet("/ManageLangResult")
public class ManageLangResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ManageLangResult() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection)sc.getAttribute("DBconnection");
		
		User currUser = (User)session.getAttribute("currUser");
		ArrayList<LangQuestion> langQuestionList = (ArrayList<LangQuestion>)session.getAttribute("currQuestionList");
		
		//1. 테스트 로그 저장
		Date now = new Date(System.currentTimeMillis());
		
		LangTestLog langTestLog = new LangTestLog();
		langTestLog.setUserId(currUser.getUserId());
		langTestLog.setLangTestDate(now);
		langTestLog.setLangTestTime(new Time(now.getTime()));
		
		LangTestLogDAO.insertLangTestLog(conn, langTestLog);
		
		//2. 테스트 결과 저장
		ArrayList<LangReply> langReplyList = new ArrayList<LangReply>();
		for(int i =0 ; i<5; i++) {
			if(request.getParameter("reply"+i)!= null){
				LangReply langReply = new LangReply();
				langReply.setLangTestLogId(langTestLog.getLangTestLogId());
				langReply.setLangQuestionId(langQuestionList.get(i).getLangQuestionId());
				langReply.setLangReplyContent(Integer.parseInt(request.getParameter("reply"+i)));
				if(LangReplyDAO.insertLangReply(conn, langReply)) {
					System.out.println(i+"번째 응답 삽입 성공");
					langReplyList.add(langReply);
				}else {
					System.out.println(i+"번째 응답 삽입 실패");
				}
			} else {
				response.setContentType("text/html; charset=UTF-8");
			    PrintWriter out = response.getWriter();
			    out.println("<script>alert('입력되지 않은 항목이 있습니다.'); history.go(-1);</script>");
			    out.flush();
			    response.flushBuffer();
			    out.close();
				
			}
		}
		
		
		request.setAttribute("langTestLog", langTestLog);
		request.setAttribute("langReplyList", langReplyList);
		request.setAttribute("langQuestionList",  langQuestionList);

		
		request.setAttribute("currLangTestLogId",langTestLog.getLangTestLogId());
		
		
		response.sendRedirect(getServletContext().getContextPath()+"/AllLangResult?isTesting=1");

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
