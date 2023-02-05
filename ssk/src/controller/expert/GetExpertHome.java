package controller.expert;

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

import model.dao.UserDAO;
import model.dto.User;

/**
 * 전문가 홈 - 모든 아동 리스트 조회 페이지
 */
@WebServlet("/GetExpertHome")
public class GetExpertHome extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetExpertHome() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession(true);
	    
	    ServletContext sc = getServletContext();
	 	Connection conn= (Connection) sc.getAttribute("DBconnection");
	 	
		//모든 아동 리스트 가져오기 
		ArrayList<User> childList = UserDAO.getUserListByUserRole(conn, "CHILD");
		
		request.setAttribute("childList",childList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/expertHome.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
