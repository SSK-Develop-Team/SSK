package controller.superexpert.manage;

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
 * @author Lee Ji Won
 * 슈퍼 전문가 - 전체 사용자(전문가, 아동) 가져오기
 */
@WebServlet("/GetSuperExpertHome")
public class GetSuperExpertHome extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetSuperExpertHome() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
	    Connection conn= (Connection) sc.getAttribute("DBconnection");

	    User currUser = (User)session.getAttribute("currUser");
	    
	    ArrayList<User> expertList = new ArrayList<User>();
	    expertList = UserDAO.getUserListByExpert(conn, currUser.getUserId());
	    
	    ArrayList<User>[] childList = new ArrayList[expertList.size()]; 
	    for(int i = 0; i<expertList.size();i++) {
	    	childList[i] = (ArrayList<User>)UserDAO.getUserListByExpert(conn, expertList.get(i).getUserId());
	    }
	    
	    request.setAttribute("expertList", expertList);
	    request.setAttribute("childList", childList);
	    
	    RequestDispatcher rd = request.getRequestDispatcher("/superExpertHome.jsp");
	    rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
