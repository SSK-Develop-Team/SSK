package controller.user;

import java.io.IOException;
import java.sql.Connection;

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
 * 
 */
@WebServlet("/GetExpertToChildHome")
public class GetExpertToChildHome extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public GetExpertToChildHome() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession(true);
	    
	    ServletContext sc = getServletContext();
	 	Connection conn= (Connection) sc.getAttribute("DBconnection");
	 	

	 	User selectedChild = new User();
	 	if(request.getParameter("userId")!=null) {
	 		selectedChild = UserDAO.getUserById(conn, Integer.parseInt(request.getParameter("userId")));
	 	}else {
	 		System.out.println("user not selected");
	 	}
	 	
	 	request.setAttribute("selectedChild",selectedChild);
	 	
	 	RequestDispatcher rd = request.getRequestDispatcher("/expertToChildHome.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
