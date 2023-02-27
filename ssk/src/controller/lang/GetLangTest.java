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
import util.process.UserInfoProcessor;
import model.dao.AgeGroupDAO;

import java.sql.Date;

/**
 * 해당 아동의 연령에 맞는 질문 가져오기
 */


@WebServlet("/GetLangTest")
public class GetLangTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetLangTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession(true);

		ServletContext sc = getServletContext();
		Connection con = (Connection)sc.getAttribute("DBconnection");
		User currUser = (User)session.getAttribute("currUser");
		int nowAge = (int)session.getAttribute("curAge");

		
		/**
		 * childHome의 selectModal에서 option값을 받아온 후, value에 맞는 selectAge를 할당, 세션에 저장
		 * */
		
		
		String selectOption="";
		int selectAge = 0;
		
		if(request.getParameter("ageGroup")!=null) {
			selectOption = request.getParameter("ageGroup"); 

			if(selectOption.equals("prev2Age")) selectAge = nowAge - 2;
			else if(selectOption.equals("prevAge")) selectAge = nowAge - 1;
			else if(selectOption.equals("curAge")) selectAge = nowAge;		
		} else selectAge = nowAge;
		
		ArrayList<LangQuestion> currQuestionList = LangQuestionDAO.getLangQuestionListByAgeGroupId(con, selectAge);
		
		session.setAttribute("currQuestionList", currQuestionList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/langTest.jsp");
		rd.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}