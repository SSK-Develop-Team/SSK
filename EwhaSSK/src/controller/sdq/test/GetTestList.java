package controller.sdq.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.SDQTestDAO;
import model.dto.SdqQuestion;
import model.dto.SdqTestLog;
import model.dto.User;

/**
 * @author Seo Ji Woo
 *
 */

@WebServlet("/GetTestList")
public class GetTestList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetTestList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(true);
		
		//DB 연결
		ServletContext sc = getServletContext();
		Connection con = (Connection)sc.getAttribute("DBconnection");
		
		User currUser = (User)session.getAttribute("currUser");
		//int totalNumberOfSdqTest = currUser.getTotalNumberOfSdqTest();

		session.setAttribute("currUser", currUser);
		//session.setAttribute("totalNumberOfSdqTest", totalNumberOfSdqTest);
		
		ArrayList<SdqQuestion> vlist = SDQTestDAO.getTestList(con);
		ArrayList<String> test_list = new ArrayList<String>();
		for(int i = 0; i<vlist.size();i++){
			test_list.add("'" + vlist.get(i).getSdqQuestionContent() + "'");
		}
		ArrayList<String> type_list = new ArrayList<String>();
		for(int i = 1; i < vlist.size(); i++){
			type_list.add("'" + vlist.get(i).getSdqType());
		}
		
		session.setAttribute("testlist", test_list);
		
		PrintWriter out = response.getWriter();
		out.println("<script>location.href='../EwhaSSK/sdqtestexpert.jsp';</script>");
		session.setAttribute("currUser", currUser);
		out.flush();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
