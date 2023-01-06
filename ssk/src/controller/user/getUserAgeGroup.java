package controller.user;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import model.dto.User;
import util.process.UserInfoProcessor;
import model.dao.AgeGroupDAO;

import java.sql.Date;

/**
 * 해당 아동의 AgeGroup 구하기
 */


@WebServlet("/GetUserAgeGroup")
public class getUserAgeGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public getUserAgeGroup() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(true);

		ServletContext sc = getServletContext();
		Connection con = (Connection)sc.getAttribute("DBconnection");
		User currUser = (User)session.getAttribute("currUser");
		
		Date userBirth = currUser.getUserBirth();
		int nowAge = UserInfoProcessor.getUserBirthToCurrAge(userBirth);
		
		int curAgeGroup = AgeGroupDAO.getCurrAge(con, nowAge);
		
		session.setAttribute("curAge", curAgeGroup);
		
		RequestDispatcher rd = request.getRequestDispatcher("/langTestMain.jsp");
		rd.forward(request, response);
		
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}