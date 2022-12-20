package controller.esm.test;

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

import model.dao.EsmReplyDAO;
import model.dto.User;

/**
 * @author Seo Ji Woo
 *
 */

@WebServlet("/getESMResult")
public class GetESMResult extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetESMResult() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		// for DB Connection
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		User currUser = (User)session.getAttribute("currUser");
		int userid = currUser.getUserId();
		
		ArrayList<Integer> scoreList = new ArrayList<Integer>();
		int positive = 0;
		int negative = 0;
		
		for(int i = 0; i < 10; i++){
			int testlogid = EsmReplyDAO.getRecentEsmTestId(conn, userid);
			System.out.println("GetESMResult :: testlogid : " + testlogid);
			int result = EsmReplyDAO.getESMResult(conn, testlogid, i+1).getEsmReplyContent();
			scoreList.add(result);
		}
		System.out.println("(GetESMResult.java) " + scoreList);
		
		for(int i = 0; i < 5; i ++) {
			positive += scoreList.get(i);
		}
		for(int i = 5; i < 10; i++) {
			negative += scoreList.get(i);
		}
		
		request.setAttribute("positive", positive);
		request.setAttribute("negative", negative);
		
		RequestDispatcher rd = request.getRequestDispatcher("/esmresult.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
