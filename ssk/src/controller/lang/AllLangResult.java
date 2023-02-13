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
import model.dao.SdqTestLogDAO;
import model.dto.LangQuestion;
import model.dto.LangReply;
import model.dto.LangTestLog;
import model.dto.SdqTestLog;
import model.dto.User;

/**
 * 
 * 언어 평가 전체 결과 호출
 */
@WebServlet("/AllLangResult")
public class AllLangResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AllLangResult() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection)sc.getAttribute("DBconnection");
		
		User currUser = (User)session.getAttribute("currUser");

		//All Log
		ArrayList<LangTestLog> langTestLogList = LangTestLogDAO.getLangTestLogByUserId(conn, currUser.getUserId());
		if(langTestLogList.size() == 0) {
			PrintWriter out = response.getWriter();
			out.println("<script>location.href='../ssk/langTestMain.jsp';alert('언어 평가 기록이 없습니다.');</script>");
 			out.flush();
		}
		
		LangTestLog selectedLangTestLog = null;
		
		//Select Log
		if((request.getParameter("langTestLogId")).equals("0")) {
			Comparator<LangTestLog> comparatorById = Comparator.comparingInt(LangTestLog::getLangTestLogId);
			selectedLangTestLog = langTestLogList.stream().max(comparatorById).orElseThrow(NoSuchElementException::new);
		}else {
			selectedLangTestLog = LangTestLogDAO.getLangTestLogById(conn, Integer.parseInt(request.getParameter("langTestLogId")));
		}

		request.setAttribute("langTestLogList", langTestLogList);
		request.setAttribute("selectedLangTestLog", selectedLangTestLog);
		
		//Age Group ID
		ArrayList<Integer> langTestAgeGroupId = (ArrayList<Integer>)LangReplyDAO.getLangAgeGroupIdByLogId(conn, selectedLangTestLog.getLangTestLogId());		
		
		//Select Result
		ArrayList<LangReply> selectLangReplyList = (ArrayList<LangReply>)LangReplyDAO.getLangReplyListByLangTestLogId(conn, selectedLangTestLog.getLangTestLogId());
		
		//Select Question 
		ArrayList<LangQuestion> selectLangQuestionList = (ArrayList<LangQuestion>)LangQuestionDAO.getLangQuestionListByAgeGroupId(conn, langTestAgeGroupId.get(0));
		
		request.setAttribute("langTestAgeGroupId", langTestAgeGroupId);
		
		request.setAttribute("selectLangReplyList",  selectLangReplyList);
		request.setAttribute("selectLangQuestionList",  selectLangQuestionList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/langTestResult.jsp");
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
