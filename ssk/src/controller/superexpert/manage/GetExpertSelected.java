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
 * 슈퍼 전문가 - 선택한 전문가의 관리 아동 목록 조회
 */
@WebServlet("/GetExpertSelected")
public class GetExpertSelected extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetExpertSelected() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");
		User selectedExpert = (User)session.getAttribute("selectedExpert");
		int expertId = selectedExpert.getUserId();
		ArrayList<User> selectedExpertChildList = UserDAO.getUserListByExpert(conn, expertId);

		request.setAttribute("selectedExpertChildList",selectedExpertChildList);
		
		RequestDispatcher rd = request.getRequestDispatcher("selectedExpert.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
