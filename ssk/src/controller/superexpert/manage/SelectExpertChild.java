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
 * @author Lee Ji won
 * 슈퍼 전문가가 선택한 전문가의 아동 선택
 * selectedChild 설정
 */
@WebServlet("/SelectExpertChild")
public class SelectExpertChild extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SelectExpertChild() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		int childId = Integer.parseInt(request.getParameter("selectedExpertChildId"));
		
		User selectedChild = UserDAO.getUserById(conn, childId);
		
		session.setAttribute("selectedChild", selectedChild);
		
		RequestDispatcher rd = request.getRequestDispatcher("childInfo.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
