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
 * 
 * 세션 정리 필요 
 */
@WebServlet("/GetLangResultAll")
public class GetLangResultAll extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetLangResultAll() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection)sc.getAttribute("DBconnection");
		
		User currUser = (User)session.getAttribute("currUser");
		int curAge = (int)session.getAttribute("curAge");

		//All
		ArrayList<LangTestLog> langTestLogList = LangTestLogDAO.getLangTestLogByUserId(conn, currUser.getUserId());
		int logListSize = langTestLogList.size();
		
		if(logListSize == 0) {
			PrintWriter out = response.getWriter();
			out.println("<script>location.href='langTestMain.jsp';alert('언어 평가 기록이 없습니다.');</script>");
 			out.flush();
		}
		
		ArrayList<Integer> langTestLogIDList = new ArrayList<Integer>();
		for(int i =0 ;i < logListSize; i++) {
			langTestLogIDList.add(langTestLogList.get(i).getLangTestLogId());
		}
		
		ArrayList<ArrayList<LangReply>> allLangReplyList = new ArrayList<ArrayList<LangReply>>();
		for(int j=0; j< logListSize; j++) {
			ArrayList<LangReply> langReplyElement = LangReplyDAO.getLangReplyListByLangTestLogId(conn, langTestLogIDList.get(j));
				allLangReplyList.add(langReplyElement);
		}
		
		ArrayList<Integer> allAgeGroupIDList = new ArrayList<Integer>();
		ArrayList<Integer> ageGroupSet = new ArrayList<Integer>();
		for(int k=0; k< logListSize; k++) {
			int ageGroupIDElement = LangReplyDAO.getLangAgeGroupIdByLogId(conn, langTestLogIDList.get(k));	
			if(ageGroupIDElement !=-1) {
				allAgeGroupIDList.add(ageGroupIDElement);
				if(!ageGroupSet.contains(ageGroupIDElement)) {
					ageGroupSet.add(ageGroupIDElement);
				}
			}
			
			
		}
		
		
		//Age Select After
		@SuppressWarnings("unchecked")
		ArrayList<Integer> langLogIdListByUser = (ArrayList<Integer>)session.getAttribute("langLogIdListByUser");
		ArrayList<LangTestLog> langLogListByUser = new ArrayList<LangTestLog>();
		ArrayList<ArrayList<LangReply>> langReplyContentListByUser = new ArrayList<ArrayList<LangReply>>();
		
		if(langLogIdListByUser != null) {//결과보기창에서 AgeGroup을 선택한 경우
			for(int i=0; i<langLogIdListByUser.size(); i++) {
				langLogListByUser.add(LangTestLogDAO.getLangTestLogById(conn, langLogIdListByUser.get(i)));
				langReplyContentListByUser.add(LangReplyDAO.getLangReplyListByLangTestLogId(conn, langLogIdListByUser.get(i)));
			}
		}
		
		
		//Selected Lang Test Log  - 결과창에 띄울 그래프의 테스트 로그 데이터 선정
		LangTestLog selectedLangTestLog = null;
		int selectIndex = 0;
		
		if(request.getAttribute("selectIndex") != null) selectIndex = (int)request.getAttribute("selectIndex");
		
		boolean isTesting = false;
		
		/*결과 보기 버튼으로 바로 접속 시 selectedLangTestLog가 저장되지 않아 아래 코드를 추가함. 로직 확인 필요!*/
		Comparator<LangTestLog> comparatorById = Comparator.comparingInt(LangTestLog::getLangTestLogId);
		selectedLangTestLog = langTestLogList.stream().max(comparatorById).orElseThrow(NoSuchElementException::new);
		/*결과 보기 버튼으로 바로 접속 시 selectedLangTestLog가 저장되지 않아 코드를 추가함. 로직 확인 필요!*/
		
		
		if((request.getParameter("isTesting"))!=null) {//검사 직후 결과보기인 경우 = 가장 최근 결과를 지정
			//Comparator<LangTestLog> comparatorById = Comparator.comparingInt(LangTestLog::getLangTestLogId);
			//selectedLangTestLog = langTestLogList.stream().max(comparatorById).orElseThrow(NoSuchElementException::new);
			isTesting = true;
		}else {//결과 보기 버튼으로 접속했을 경우 
			if(langLogIdListByUser != null) {
				if(request.getAttribute("selectIndex") != null) {
					selectedLangTestLog = langLogListByUser.get(selectIndex);
					request.setAttribute("selectIndex", selectIndex);
				}
				else{
					selectedLangTestLog = langLogListByUser.get(0);
				}
				
			} else {
				if(allAgeGroupIDList.contains(curAge))
					selectedLangTestLog = langTestLogList.get(allAgeGroupIDList.lastIndexOf(curAge));
				else {
					//Comparator<LangTestLog> comparatorById = Comparator.comparingInt(LangTestLog::getLangTestLogId);
					//selectedLangTestLog = langTestLogList.stream().max(comparatorById).orElseThrow(NoSuchElementException::new);
				}
			}
		}
		
		
		int langTestAgeGroupId = (int)LangReplyDAO.getLangAgeGroupIdByLogId(conn, selectedLangTestLog.getLangTestLogId());		
		ArrayList<LangReply> selectLangReplyList = (ArrayList<LangReply>)LangReplyDAO.getLangReplyListByLangTestLogId(conn, selectedLangTestLog.getLangTestLogId());
		ArrayList<LangQuestion> selectLangQuestionList = (ArrayList<LangQuestion>)LangQuestionDAO.getLangQuestionListByAgeGroupId(conn, langTestAgeGroupId);
		
		
		
		request.setAttribute("langTestLogIDList", langTestLogIDList);
		request.setAttribute("allLangReplyList",  allLangReplyList);
		request.setAttribute("allAgeGroupIDList",  allAgeGroupIDList);
		request.setAttribute("ageGroupSet",  ageGroupSet);
		
		request.setAttribute("langLogListByUser", langLogListByUser);
		request.setAttribute("langReplyContentListByUser", langReplyContentListByUser);
		
		request.setAttribute("langTestLogList", langTestLogList);
		request.setAttribute("selectedLangTestLog", selectedLangTestLog);
		request.setAttribute("isTesting", isTesting);
		
		request.setAttribute("selectAgeGroupId", langTestAgeGroupId);
		request.setAttribute("selectLangReplyList",  selectLangReplyList);
		request.setAttribute("selectLangQuestionList",  selectLangQuestionList);
		
		
		RequestDispatcher rd = request.getRequestDispatcher("/langTestResult.jsp");
		rd.forward(request, response);
		

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
