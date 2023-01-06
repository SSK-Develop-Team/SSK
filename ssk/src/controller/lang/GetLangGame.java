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
		Connection con = (Connection)sc.getAttribute("DBconnection");
		User currUser = (User)session.getAttribute("currUser");
		
		request.setCharacterEncoding("utf-8");
		
		int langProg1 = 0;
		int langProg2 = 0;
		int langProg3 = 0;
		int langProg4 = 0;
		int langProg5 = 0;
		
		int gameID = Integer.parseInt(request.getParameter("langGameID"));

		
		if(request.getParameter("langTestProgress1")!=null) langProg1 = Integer.parseInt(request.getParameter("langTestProgress1"));
		if(request.getParameter("langTestProgress2")!=null) langProg2 = Integer.parseInt(request.getParameter("langTestProgress2"));
		if(request.getParameter("langTestProgress3")!=null) langProg3 = Integer.parseInt(request.getParameter("langTestProgress3"));
		if(request.getParameter("langTestProgress4")!=null) langProg4 = Integer.parseInt(request.getParameter("langTestProgress4"));
		if(request.getParameter("langTestProgress5")!=null) langProg5 = Integer.parseInt(request.getParameter("langTestProgress5"));
		
		session.setAttribute("langProg1", langProg1);
		session.setAttribute("langProg2", langProg2);
		session.setAttribute("langProg3", langProg3);
		session.setAttribute("langProg4", langProg4);
		session.setAttribute("langProg5", langProg5);
		
		System.out.println("GameID : " + gameID);
		System.out.println("getLangProg1 : " + langProg1);
		System.out.println("getLangProg2 : " + langProg2);
		System.out.println("getLangProg3 : " + langProg3);
		System.out.println("getLangProg4 : " + langProg4);

		
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