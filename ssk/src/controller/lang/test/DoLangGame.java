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

import model.dao.LangReplyDAO;
import model.dto.LangReply;

/**
 * @author Jiwon Lee
 * 한 게임의 결과를 입력하고 다음 게임으로 이동
 * 마지막 게임일 시 result 페이지로 이동
 */
@WebServlet("/DoLangGame")
public class DoLangGame extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DoLangGame() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection)sc.getAttribute("DBconnection");
		
		ArrayList<LangReply> langReplyList = (ArrayList<LangReply>)session.getAttribute("langReplyList");
		ArrayList<Integer> langGameResultList = (ArrayList<Integer>)session.getAttribute("langGameResultList");
		int currDontKnowIndex = (int)session.getAttribute("currDontKnowIndex");
		ArrayList<Integer> dontKnowList = (ArrayList<Integer>)session.getAttribute("dontKnowList");
		
		//언어 발달 평가(직접 평가) 결과 반영
		int result = langGameResultList.stream().mapToInt(Integer::intValue).sum()/langGameResultList.size();
		int index = 0;
		
		for(int i=0;i<langReplyList.size();i++) {
			if(langReplyList.get(i).getLangQuestionId()==dontKnowList.get(currDontKnowIndex))
				index=i;
		}
		langReplyList.get(index).setLangReplyContent(result);
		
		LangReply currLangReply = langReplyList.get(index);
		
		LangReplyDAO.updateLangReply(conn, currLangReply);
		
		session.setAttribute("langReplyList", langReplyList);
		session.removeAttribute("langGameResultList");
		session.removeAttribute("currLangGameList");
		session.removeAttribute("currLangGameIndex");
		
		//다음 게임 이동
		if(currDontKnowIndex<dontKnowList.size()-1){//다음 게임이 있을 경우
			response.sendRedirect(request.getContextPath() +"/GetLangGame");
		}else {//다음 게임이 없을 경우 - 마지막 게임일 경우
			request.setAttribute("currLangTestLogId",langReplyList.get(0).getLangTestLogId());
			session.removeAttribute("currDontKnowIndex");
			session.removeAttribute("dontKnowList");
			session.removeAttribute("langReplyList");

			RequestDispatcher rd = request.getRequestDispatcher("/GetLangResult");
			rd.forward(request, response);
		}
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
