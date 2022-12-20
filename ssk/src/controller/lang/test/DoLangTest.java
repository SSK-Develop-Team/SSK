package controller.lang.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.LangReplyDAO;
import model.dao.LangTestLogDAO;
import model.dto.LangQuestion;
import model.dto.LangReply;
import model.dto.LangTestLog;
import model.dto.User;

/**
 * @author Minseo Jeong, Jiwon Lee
 * 사용자가 응답한 결과 저장
 * 언어 발달 검사(간접 평가) 결과 입력 & '잘 모르겠다' 문항 체크
 * */

@WebServlet("/DoLangTest")
public class DoLangTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public DoLangTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		session.setAttribute("isTesting", true);
		
		User currUser = (User)session.getAttribute("currUser");
		
		ArrayList<LangQuestion> langQuestionList = (ArrayList<LangQuestion>)session.getAttribute("currQuestionList");
		ArrayList<Integer> dontKnowList = new ArrayList<Integer>();
		
		/*햔재 날짜 구하기*/
		Date now = new Date(System.currentTimeMillis());
		
		/*lang test 기록 추가*/
		LangTestLog langTestLog = new LangTestLog();
		langTestLog.setUserId(currUser.getUserId());
		langTestLog.setLangTestDate(now);
		langTestLog.setLangTestTime(new Time(now.getTime()));
		
		LangTestLogDAO.insertLangTestLog(conn, langTestLog);
		
		
		/*lang reply 추가 - 모르겠다고 응답한 문항도 DB insert*/
		ArrayList<LangReply> langReplyList = new ArrayList<LangReply>();
		for(int i =0 ; i<5; i++) {
			LangReply langReply = new LangReply();
			langReply.setLangTestLogId(langTestLog.getLangTestLogId());
			langReply.setLangQuestionId(langQuestionList.get(i).getLangQuestionId());
			langReply.setLangReplyContent(Integer.parseInt(request.getParameter("reply"+i)));
			if(Integer.parseInt(request.getParameter("reply"+i))==0) {
				dontKnowList.add(langQuestionList.get(i).getLangQuestionId());
			}
			if(LangReplyDAO.insertLangReply(conn, langReply)) {
				System.out.println(i+"번째 응답 삽입 성공");
				langReplyList.add(langReply);
			}else {
				System.out.println(i+"번째 응답 삽입 실패");
			}
		}
		
			
		session.setAttribute("dontKnowList", dontKnowList);
		session.setAttribute("langReplyList", langReplyList);
		
		
		if(dontKnowList.isEmpty()) {
			request.setAttribute("currLangTestLogId",langTestLog.getLangTestLogId());
			RequestDispatcher rd = request.getRequestDispatcher("/GetLangResult");
			rd.forward(request, response);
		}
		else {
			RequestDispatcher rd = request.getRequestDispatcher("/langGameMain.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}

