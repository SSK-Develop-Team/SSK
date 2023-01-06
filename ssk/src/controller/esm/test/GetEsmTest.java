package controller.esm.test;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dao.EsmEmotionDAO;
import model.dto.EsmEmotion;

/**
 * @author Jiwon Lee
 * ESM - 정서 반복 기록 : 감정 문항 불러와서 뷰로 전달 
 * 
 */
@WebServlet("/GetEsmTest")
public class GetEsmTest extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetEsmTest() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
	    request.setCharacterEncoding("UTF-8");
	    HttpSession session = request.getSession(true);
	    
	 	ServletContext sc = getServletContext();
	 	Connection conn= (Connection) sc.getAttribute("DBconnection");
	 	
	 	String esmType = request.getParameter("currEsmType");
	 	
	 	if(esmType.equals("none")) {//기록 시작
	 		esmType = "positive";
	 	}else if(esmType.equals("positive")){//긍정 감정 기록 종료 시
	 		ArrayList<EsmEmotion> esmEmotionTargetList = (ArrayList<EsmEmotion>)EsmEmotionDAO.getEsmEmotionListByEsmType(conn, esmType);
	 		HashMap<Integer, Integer> esmEmotionRecordMap = new HashMap<Integer, Integer>();//emotion번호, 결과
	 		for(int i=0;i<esmEmotionTargetList.size();i++) {
	 			esmEmotionRecordMap.put(esmEmotionTargetList.get(i).getEsmEmotionId(), Integer.parseInt(request.getParameter(esmEmotionTargetList.get(i).getEsmEmotion())));
	 		}
	 		session.setAttribute("esmEmotionRecordMap", esmEmotionRecordMap);
	 		esmType = "negative";
	 	}else if(esmType.equals("negative")) {//부정 감정 기록 종료 시 
	 		ArrayList<EsmEmotion> esmEmotionTargetList = (ArrayList<EsmEmotion>)EsmEmotionDAO.getEsmEmotionListByEsmType(conn, esmType);
	 		
	 		@SuppressWarnings("unchecked")
			HashMap<Integer, Integer> esmEmotionRecordMap = (HashMap<Integer, Integer>)session.getAttribute("esmEmotionRecordMap");
	 		
	 		for(int i=0;i<esmEmotionTargetList.size();i++) {
	 			esmEmotionRecordMap.put(esmEmotionTargetList.get(i).getEsmEmotionId(), Integer.parseInt(request.getParameter(esmEmotionTargetList.get(i).getEsmEmotion())));
	 		}
	 		session.setAttribute("esmEmotionRecordMap", esmEmotionRecordMap);
	 		
	 		RequestDispatcher rd = request.getRequestDispatcher("/DoEsmTest");
			rd.forward(request, response);
	 	}
	 	
	 	//감정 문항 전달
	 	ArrayList<EsmEmotion> esmEmotionList = (ArrayList<EsmEmotion>)EsmEmotionDAO.getEsmEmotionListByEsmType(conn, esmType);
	 	request.setAttribute("esmEmotionList", esmEmotionList);
	 	
	 	RequestDispatcher rd = request.getRequestDispatcher("/esmTest.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
