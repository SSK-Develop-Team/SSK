package controller.lang;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import model.dto.LangGame;
import model.dto.User;

import model.dao.LangGameDAO;

/**
 * 선택한 문항마다 게임(직접 평가)으로 연결
 */


@WebServlet("/GetLangGame")
public class getLangGame extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public getLangGame() {
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
		System.out.println("GameID : " + gameID);
		
		session.setAttribute("langGameIndex", gameID);
		
		ArrayList<LangGame> currLangGameList = LangGameDAO.getLangGameListByLangQuestionId(con, gameID);
		System.out.println("langGame 목록 수 : "+currLangGameList.size());
		session.setAttribute("currLangGameList", currLangGameList);
		session.setAttribute("currLangGameIndex", 0);
		
		RequestDispatcher rd = request.getRequestDispatcher("/langGame.jsp");
		rd.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}