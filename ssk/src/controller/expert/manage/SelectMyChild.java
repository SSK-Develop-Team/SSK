package controller.expert.manage;

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
 * @author Lee Ji Won
 * 전문가가 아동 선택 시 아동의 페이지로 전환
 */
@WebServlet("/SelectMyChild")
public class SelectMyChild extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SelectMyChild() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//아동 세션 설정
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		User currUser = (User)session.getAttribute("currUser");
		int expertId = currUser.getUserId();
		int childId = Integer.parseInt(request.getParameter("selectedChildId"));
		
		User selectedChild = UserDAO.getUserById(conn, childId);
		
		session.setAttribute("selectedChild", selectedChild);
		RequestDispatcher rd = request.getRequestDispatcher("/childInfo.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
