package controller.esm.test;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.EsmReplyDAO;
import model.dao.EsmTestLogDAO;
import model.dto.EsmReply;
import model.dto.EsmTestLog;
import model.dto.User;

/**
 * @author Jiwon Lee
 * 정서 반복 기록 시간별 데이터 
 */
@WebServlet("/GetEsmTestProfileByTime")
public class GetEsmTestProfileByTime extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    public GetEsmTestProfileByTime() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession(true);
	    
	 	ServletContext sc = getServletContext();
	 	Connection conn= (Connection) sc.getAttribute("DBconnection");
	 	
	 	User currUser = (User)session.getAttribute("currUser");
	 	
		// reply 날짜 데이터
		ArrayList<Date> esmTestDateList = (ArrayList<Date>) EsmTestLogDAO.getEsmTestLogDateByUserIdGroupByDate(conn, currUser.getUserId());
	 	ArrayList<EsmTestLog> selectedDateEsmTestLogList = new ArrayList<EsmTestLog>();

		String selectedDateStr = request.getParameter("date");
		
		if(selectedDateStr.equals("0")) {
			selectedDateEsmTestLogList = (ArrayList<EsmTestLog>) EsmTestLogDAO.getEsmTestLogByUserIdAndDate(conn, currUser.getUserId(), esmTestDateList.stream().map(i->i).max(Date::compareTo).get());
		}else {
            Date selectedDate = Date.valueOf(selectedDateStr);
            selectedDateEsmTestLogList = (ArrayList<EsmTestLog>) EsmTestLogDAO.getEsmTestLogByUserIdAndDate(conn, currUser.getUserId(), selectedDate);
		}
		int selectedIndexOfEsmTestDateList = esmTestDateList.indexOf(selectedDateEsmTestLogList.get(0).getEsmTestDate());
		
		// day를 기준으로 해당 데이터 가져오기
		ArrayList<Integer> positiveList = new ArrayList<Integer>();
		ArrayList<Integer> negativeList = new ArrayList<Integer>();
		
		for(int i=0;i<selectedDateEsmTestLogList.size();i++) {
			positiveList.add(EsmReplyDAO.getEsmReplyPositiveValueByEsmTestLogId(conn, selectedDateEsmTestLogList.get(i).getEsmTestLogId()));
			negativeList.add(EsmReplyDAO.getEsmReplyNegativeValueByEsmTestLogId(conn, selectedDateEsmTestLogList.get(i).getEsmTestLogId()));
		}
		
		request.setAttribute("esmTestDateList", esmTestDateList);//기록이 있는 일자 정보
		request.setAttribute("selectedIndexOfEsmTestDateList", selectedIndexOfEsmTestDateList);
		request.setAttribute("selectedEsmTestLogList", selectedDateEsmTestLogList);//선택된 일자의 기록 리스트
		request.setAttribute("positiveList", positiveList);
		request.setAttribute("negativeList", negativeList);

	 	RequestDispatcher rd = request.getRequestDispatcher("/esmTestProfileByTime.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
