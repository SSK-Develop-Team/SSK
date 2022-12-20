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

import model.dao.LangGameDAO;
import model.dto.LangGame;

/**
 * @author Jiwon Lee
 * 언어 직접 평가 목록을 제어
 * 한 문항에 대한 언어 직접 평가(게임)을 가져오는 서블릿
 * 언어 직접 평가의 0번 컨텐츠를 jsp로 보내줌
 */
@WebServlet("/GetLangGame")
public class GetLangGame extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetLangGame() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		/*언어 직접 평가가 필요한 문항 정보 & 현재 수행한 문항 게임 번호*/
		ArrayList<Integer> dontKnowList = (ArrayList<Integer>)session.getAttribute("dontKnowList");
		
		int currDontKnowIndex = 0;
		if(session.getAttribute("currDontKnowIndex")!=null) currDontKnowIndex = (int)session.getAttribute("currDontKnowIndex")+1;
		
		if(currDontKnowIndex <= dontKnowList.size()-1) {
			ArrayList<LangGame> currLangGameList = LangGameDAO.getLangGameListByLangQuestionId(conn, dontKnowList.get(currDontKnowIndex));
			System.out.println("langGame 목록 수 : "+currLangGameList.size());
			session.setAttribute("currDontKnowIndex", currDontKnowIndex);
			session.setAttribute("currLangGameList", currLangGameList);
			session.setAttribute("currLangGameIndex", 0);
			
			RequestDispatcher rd = request.getRequestDispatcher("/langGame.jsp");
			rd.forward(request, response);
		}else {
			response.sendRedirect(request.getContextPath() +"/GetLangResult");
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
