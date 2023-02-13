package controller.admin;

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

import model.dao.UserDAO;
import model.dto.User;
import model.dto.UserPaging;

/**
 * Admin 홈 - 모든 전문가 끌어오기
 */
@WebServlet("/GetAdminHome")
public class GetAdminHome extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetAdminHome() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    ServletContext sc = getServletContext();
	 	Connection conn= (Connection) sc.getAttribute("DBconnection");
	 	
		// 전문가 pagination 초기화
	 	int curPage = 1;
	 	if(request.getParameter("curPage")==null) {
	 		curPage = 1;
	 	}else {
	 		curPage = Integer.parseInt(request.getParameter("curPage"));
	 	}
	 	
		UserPaging userPaging = new UserPaging();
		userPaging.makeLastPageNum(conn);
		userPaging.makeBlock(curPage);//첫 페이지로 시작
		System.out.println(userPaging.getBlockStartNum());
		System.out.println(userPaging.getBlockEndNum());
		System.out.println(userPaging.getLastPageNum());
		
		//페이지에 해당하는 아동 목록 불러오기 - default 정렬 : 등록일 순
		int length = UserPaging.getListRange();
		int startIndex = (curPage-1)*length;
		System.out.println("start : "+startIndex);
		
		ArrayList<User> currUserList = UserDAO.getUserListByUserRoleOrderByRegistrationDateLimit(conn, "EXPERT", startIndex, length);
		
		request.setAttribute("userPaging",userPaging);
		request.setAttribute("currPageNum", curPage);
		request.setAttribute("currUserList", currUserList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/adminHome.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
