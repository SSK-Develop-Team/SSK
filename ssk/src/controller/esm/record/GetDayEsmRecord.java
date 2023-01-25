package controller.esm.record;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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
import model.dto.EsmRecord;
import model.dto.User;
import util.process.EsmRecordProcessor;

/**
 * @author Lee Ji Won
 * 사용자가 날짜 클릭 시 해당 날짜의 ESM Record 목록 전달
 */
@WebServlet("/GetDayEsmRecord")
public class GetDayEsmRecord extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public GetDayEsmRecord() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession(true);
	    
	    String selectedDateStr = request.getParameter("selectedDateStr");
	    
	 	ServletContext sc = getServletContext();
	 	Connection conn= (Connection) sc.getAttribute("DBconnection");
	 	User currUser = (User)session.getAttribute("currUser");
	 	
	 	Date selectedDateValue = Date.valueOf(selectedDateStr);
	 	
	 	//해당 날짜의 기록 조회
	 	ArrayList<EsmRecord> currEsmRecordList = (ArrayList<EsmRecord>)EsmRecordDAO.getEsmRecordListByDate(conn, currUser.getUserId(), selectedDateValue);
		
	 	request.setAttribute("currEsmRecordList", currEsmRecordList);
	 	request.setAttribute("currDateStr", selectedDateStr);
	 	
	 	RequestDispatcher rd = request.getRequestDispatcher("/viewEsmRecord.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}