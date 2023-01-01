package controller.esm.record;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.dao.EsmRecordDAO;
import model.dto.User;
import util.process.EsmRecordProcessor;
import org.json.simple.JSONObject;

/**
 * @author Lee Ji Won
 * 메인 페이지에서 ESM Record 페이지 접속 시
 * 사용자의 모든 ESM Record 목록을 가져와 FullCalendar에 표시
 */

@WebServlet("/GetEsmRecord")
public class GetEsmRecord extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetEsmRecord() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession(true);
	    
	    ServletContext sc = getServletContext();
	 	Connection conn= (Connection) sc.getAttribute("DBconnection");
	 	
	 	User currUser = (User)session.getAttribute("currUser");
	 	
		/*사용자의 EsmRecord 목록 가져오기 -> session events JSON 객체로 저장*/ 
		ArrayList<Date> esmRecordDateList = (ArrayList<Date>)EsmRecordDAO.getEsmRecordDateList(conn, currUser.getUserId());
		JSONObject eventsJsonObject = EsmRecordProcessor.EsmRecordDateListToJSON(esmRecordDateList);
		session.setAttribute("eventsJsonObject",eventsJsonObject);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date now = new Date(System.currentTimeMillis());

		//현재 날짜로 세팅
		request.setAttribute("currDateStr", sdf.format(now));
		/*달력에 View*/
		RequestDispatcher rd = request.getRequestDispatcher("/esmRecord.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}