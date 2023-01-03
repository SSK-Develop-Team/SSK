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

import model.dao.LangQuestionDAO;
import model.dto.LangQuestion;
import model.dto.User;

import model.dao.AgeGroupDAO;

import java.sql.Date;
import java.time.LocalDate;
import java.time.Period;
import java.time.ZoneId;

/**
 * 해당 아동의 연령에 맞는 질문 가져오기
 */


@WebServlet("/GetLangTest")
public class getLangTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public getLangTest() {
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
		
		LocalDate now = LocalDate.now();
		LocalDate userLocalBirth = userBirth.toLocalDate();
		
		Period diff = Period.between(userLocalBirth, now);
		int nowAge = diff.getYears() * 12 + diff.getMonths();
		
		int curAgeGroup = AgeGroupDAO.getCurrAge(con, nowAge);

		ArrayList<LangQuestion> currQuestionList = LangQuestionDAO.getLangQuestionListByAgeGroupId(con, curAgeGroup);
		
		session.setAttribute("currQuestionList", currQuestionList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/langTest.jsp");
		rd.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}