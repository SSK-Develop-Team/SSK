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

import model.dao.UserDAO;

@WebServlet("/checkId")
public class CheckId extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CheckId() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
		
		// for DB Connection
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		String id = (String) request.getParameter("id");
		boolean result = UserDAO.checkId(conn, id);
		request.setAttribute("result", result);
		
		// 이동
		RequestDispatcher rd = request.getRequestDispatcher("/checkid.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
