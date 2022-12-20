package controller.esm.record;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import model.dao.EsmRecordDAO;
import model.dto.User;
import util.esm.record.EsmRecordProcessor;

/**
 * @author Lee Ji Won
 * 사용자가 ESM Record 작성
 */

@WebServlet("/CreateEsmRecord")
public class CreateEsmRecord extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public CreateEsmRecord() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/*기록 작성*/
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession(true);
	    
	 	ServletContext sc = getServletContext();
	 	Connection conn= (Connection) sc.getAttribute("DBconnection");
	 	
	 	User focusUser = new User();
	 	if((User)session.getAttribute("selectedChild")==null) {//아동을 선택했을 때
	 		focusUser = (User)session.getAttribute("currUser");
	 	}else {//본인일 때
	 		focusUser=(User)session.getAttribute("selectedChild");
	 	}

	 	String esmRecordText = request.getParameter("newRecordText");
	 	Date esmRecordDate = Date.valueOf(request.getParameter("newRecordDateStr"));
	 	Date nowDate = new Date(System.currentTimeMillis());
	 	Time esmRecordTime = null;
	 	
	 	if(esmRecordDate.toString().equals(nowDate.toString())) esmRecordTime = Time.valueOf(LocalTime.now());
	 	boolean insertEsmRecord = EsmRecordDAO.insertEsmRecord(conn, esmRecordText, esmRecordDate, esmRecordTime, focusUser.getUserId());
	 	
	 	if(insertEsmRecord==true)System.out.println("EsmRecord 생성");
	 	else System.out.println("EsmRecord 생성 실패");
	 	
	 	/*사용자의 EsmRecord 목록 가져오기 -> session events JSON 객체로 저장*/ 
		ArrayList<Date> esmRecordDateList = (ArrayList<Date>)EsmRecordDAO.getEsmRecordDateList(conn, focusUser.getUserId());
		JSONObject eventsJsonObject = (JSONObject)EsmRecordProcessor.EsmRecordDateListToJSON(esmRecordDateList);
		
		session.setAttribute("eventsJsonObject",eventsJsonObject);
	 	request.setAttribute("currDateStr", request.getParameter("newRecordDateStr"));
	 	RequestDispatcher rd = request.getRequestDispatcher("/esmRecord.jsp");
		rd.forward(request, response);
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
