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

import model.dao.LangQuestionDAO;
import model.dto.LangQuestion;
import model.dto.User;

/**
 * @author Minseo Jeong, Jiwon Lee
 * 선택 연령에 대한 질문 정보 가져오기(AgeGroup에 맞는 LangQuestionList)
 * */

@WebServlet("/GetLangTest")
public class GetLangTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetLangTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(true);

		ServletContext sc = getServletContext();
		Connection con = (Connection)sc.getAttribute("DBconnection");
		
		User currUser = (User)session.getAttribute("currUser");
		int curAge = currUser.getCurrentAge();
		
		
		/**
		 * childHome의 selectModal에서 option값을 받아온 후, value에 맞는 selectAge를 할당, 세션에 저장
		 * */
		String selectOption="";
		if(request.getParameter("ageGroup")!=null) selectOption = request.getParameter("ageGroup"); 
		
		int selectAge = 0;
		
		if(selectOption.equals("prev2Age")) selectAge = curAge - 2;
		else if(selectOption.equals("prevAge")) selectAge = curAge - 1;
		else if(selectOption.equals("curAge")) selectAge = curAge;
		
		else if(selectOption.equals("0")) selectAge = 0;
		else if(selectOption.equals("1")) selectAge = 1;
		else if(selectOption.equals("2")) selectAge = 2;
		else if(selectOption.equals("3")) selectAge = 3;
		else if(selectOption.equals("4")) selectAge = 4;
		else if(selectOption.equals("5")) selectAge = 5;
		else if(selectOption.equals("6")) selectAge = 6;
		else if(selectOption.equals("7")) selectAge = 7;
		else if(selectOption.equals("8")) selectAge = 8;
		else if(selectOption.equals("9")) selectAge = 9;
		else if(selectOption.equals("10")) selectAge = 10;
		else if(selectOption.equals("11")) selectAge = 11;
		else if(selectOption.equals("12")) selectAge = 12;
		else if(selectOption.equals("13")) selectAge = 13;
		
		else selectAge = curAge;

		session.setAttribute("selectAge", selectAge);

		ArrayList<LangQuestion> currQuestionList = LangQuestionDAO.getLangQuestionListByAgeGroupId(con, selectAge);
		
		session.setAttribute("currQuestionList", currQuestionList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/languageTest.jsp");
		rd.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
