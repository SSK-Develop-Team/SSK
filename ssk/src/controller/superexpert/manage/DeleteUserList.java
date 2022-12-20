package controller.superexpert.manage;

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

/**
 * @author Lee Ji Won
 * 사용자 리스트 삭제
 * - 슈퍼 전문가가 전문가를 삭제하는 경우
 * - 슈퍼 전문가가 아동을 삭제하는 경우
 */
@WebServlet("/DeleteUserList")
public class DeleteUserList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteUserList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    ServletContext sc = getServletContext();
	 	Connection conn= (Connection) sc.getAttribute("DBconnection");
	 	
		String[] expertSelect = request.getParameterValues("expertSelect"); 
		String[] childSelect = request.getParameterValues("childSelect"); 
		if (expertSelect!=null) {//삭제할 사용자로 expert가 선택됐을 경우
			for(int i = 0 ; i<expertSelect.length;i++) {
				UserDAO.deleteUser(conn, Integer.parseInt(expertSelect[i]));
			}
			RequestDispatcher rd = request.getRequestDispatcher("/GetSuperExpertHome");
			rd.forward(request, response);
		}else if(childSelect!=null) {//삭제할 사용자로 child가 선택됐을 경우
			for(int i = 0 ; i<childSelect.length;i++) {
				UserDAO.deleteUser(conn, Integer.parseInt(childSelect[i]));
			}
			RequestDispatcher rd = request.getRequestDispatcher("/GetExpertSelected");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
