package controller.lang;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.NoSuchElementException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import model.dto.LangGame;
import model.dto.LangTestLog;
import model.dto.SdqResultOfType;
import model.dto.SdqTestLog;
import model.dto.User;

import model.dao.LangGameDAO;
import model.dao.LangTestLogDAO;
import model.dao.SdqReplyDAO;
import model.dao.SdqTestLogDAO;

/**
 * 해당 user의 모든 langTest 결과를 확인
 * 드롭다운 메뉴에서 age / date 별 선택 가능
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
		Connection con = (Connection)sc.getAttribute("DBconnection");
		User currUser = (User)session.getAttribute("currUser");
		
		request.setCharacterEncoding("utf-8");

		int gameID = Integer.parseInt(request.getParameter("langGameID"));

		ArrayList<Integer> langProgList = new ArrayList<Integer>();
		langProgList.add(Integer.parseInt(request.getParameter("langTestProgress1")));
		langProgList.add(Integer.parseInt(request.getParameter("langTestProgress2")));
		langProgList.add(Integer.parseInt(request.getParameter("langTestProgress3")));
		langProgList.add(Integer.parseInt(request.getParameter("langTestProgress4")));
		langProgList.add(Integer.parseInt(request.getParameter("langTestProgress5")));
		
		session.setAttribute("langProgList", langProgList);
		session.setAttribute("langGameID", gameID);
		
		ArrayList<LangGame> currLangGameList = LangGameDAO.getLangGameListByLangQuestionId(con, gameID);
		session.setAttribute("currLangGameList", currLangGameList);
		session.setAttribute("currLangGameIndex", 0);
		
		RequestDispatcher rd = request.getRequestDispatcher("/langGame.jsp");
		rd.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
