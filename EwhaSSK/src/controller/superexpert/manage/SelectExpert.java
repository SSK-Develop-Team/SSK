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
 * 슈퍼 전문가 - 전문가 선택
 * selectedExpert 설정
 */
@WebServlet("/SelectExpert")
public class SelectExpert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SelectExpert() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		
		session.removeAttribute("selectedChild");//기존에 선택했던 전문가의 아동 세션 삭제
		
		int expertId = Integer.parseInt(request.getParameter("selectedExpertId"));
		
		User selectedExpert = UserDAO.getUserById(conn, expertId);
		ArrayList<User> selectedExpertChildList = UserDAO.getUserListByExpert(conn, expertId);
		
		session.setAttribute("selectedExpert", selectedExpert);
		request.setAttribute("selectedExpertChildList",selectedExpertChildList);
		
		RequestDispatcher rd = request.getRequestDispatcher("selectedExpert.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
