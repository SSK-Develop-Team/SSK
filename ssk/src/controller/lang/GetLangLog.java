package controller.lang;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.NoSuchElementException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.LangQuestionDAO;
import model.dao.LangReplyDAO;
import model.dao.LangTestLogDAO;
import model.dao.SdqTestLogDAO;
import model.dto.LangQuestion;
import model.dto.LangReply;
import model.dto.LangTestLog;
import model.dto.SdqTestLog;
import model.dto.User;

/**
 * 
 *
 */

@WebServlet("/GetLangLog")
public class GetLangLog extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetLangLog() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    
	    HttpSession session = request.getSession(true);
		
		ServletContext sc = getServletContext();
		Connection conn= (Connection)sc.getAttribute("DBconnection");
		
		User currUser = (User)session.getAttribute("currUser");

		int selectAgeGroup = Integer.parseInt(request.getParameter("ageGroupId"));

		ArrayList<Integer> tmpLogIdList = LangReplyDAO.getLangTestLogIdByAgeGroup(conn, selectAgeGroup, currUser.getUserId());
		ArrayList<Integer> langLogIdListByUser = new ArrayList<Integer>();
		
		for(int i=0; i<tmpLogIdList.size(); i++) {
			if(! langLogIdListByUser.contains(tmpLogIdList.get(i))) {
				langLogIdListByUser.add(tmpLogIdList.get(i));
			}
		}
		
		session.setAttribute("langLogIdListByUser", langLogIdListByUser);
		
		
		RequestDispatcher rd = request.getRequestDispatcher("/GetLangResultAll");
		rd.forward(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
