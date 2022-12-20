package controller.expert.manage;

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
 * 전문가가 관리하는 아동 리스트 가져오기
 * 선택한 아동 세션 삭제
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

			    User currUser = (User)session.getAttribute("currUser");
			    
			    ArrayList<User> userChildList = (ArrayList<User>)UserDAO.getUserListByExpert(conn, currUser.getUserId());
		       
			    session.setAttribute("userChildList", userChildList);
			    session.removeAttribute("selectedChild");
			    RequestDispatcher rd = request.getRequestDispatcher("/expertHome.jsp");
			    rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
