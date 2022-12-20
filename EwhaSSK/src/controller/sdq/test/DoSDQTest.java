package controller.sdq.test;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dto.SdqTestLog;
import model.dto.User;
import model.dao.SdqReplyDAO;
import model.dao.UserDAO;

/**
 * @author Seo Ji Woo
 *
 */

@WebServlet("/doSDQTest")
public class DoSDQTest extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    public DoSDQTest() {
        super();
    }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      response.setContentType("text/html; charset=UTF-8");
       request.setCharacterEncoding("UTF-8");
       
       HttpSession session = request.getSession(true);
      
      // for DB Connection
      ServletContext sc = getServletContext();
      Connection conn= (Connection) sc.getAttribute("DBconnection");
      
      User currUser = (User)session.getAttribute("currUser");
      int userid = currUser.getUserId();
      
      ArrayList<Integer> scoreList = new ArrayList<Integer>();
      
      /*현재 sdq 테스트 횟수 받아오기*/
      int sdqNum = SdqReplyDAO.getTimesOfSdqTest(conn, userid) + 1;
      // sdqNum 확인
      System.out.println("<sdqNum : " + sdqNum + ">");
      
      for (int i = 1; i <= 10; i++){
         scoreList.add(Integer.parseInt(request.getParameter("answer"+i)));
      }
      
      boolean isTesting = false;
      session.setAttribute("isTesting", isTesting);
      
      System.out.println(scoreList);
      
      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
      String ss = sdf.format(new java.util.Date());
      java.sql.Date testDate = java.sql.Date.valueOf(ss);
      
      Date today = new Date();   

      @SuppressWarnings("deprecation")
      int hour = today.getHours(); 
      @SuppressWarnings("deprecation")
      int minute = today.getMinutes();
      @SuppressWarnings("deprecation")
      int second = today.getSeconds(); 
      String hours = Integer.toString(hour);
      String minutes = Integer.toString(minute);
      String seconds = Integer.toString(second);
      
      if(hour < 10) {
         hours = "0" + hours;
      }
      if(minute < 10) {
         minutes = "0" + minutes;
      }
      if(second < 10) {
         seconds = "0" + seconds;
      }
      
      String timeStr = hours + ':' + minutes  + ':' + seconds;
      
      System.out.println(testDate + " :: " + timeStr);

      
      int timesOfSdqTest = SdqReplyDAO.getTimesOfSdqTest(conn, userid);
      SdqTestLog log = new SdqTestLog();
      log.setUserId(userid);
      log.setSdqTestDate(testDate);
      log.setSdqTestTime(timeStr);
      boolean insertLog = SdqReplyDAO.insertSDQTestLog(conn, log);
      
      for(int i = 0; i < 10; i++){
         String reply = "";
         if(scoreList.get(i)==0){
            reply = "전혀아니다";
         }
         else if(scoreList.get(i) == 1){
            reply = "조금그렇다";
         }
         else if(scoreList.get(i) == 2){
            reply = "그렇다";
         }
         else {
            reply = "매우그렇다";
         }
         
         /*응답 삽입*/
         // sdq_test_log_id 임의 설정해 놓음. 수정 필요.
         
    	 int testlogid = SdqReplyDAO.getRecentSdqTestId(conn, userid);
         System.out.println("sdqtest : " + timesOfSdqTest+1);
         boolean result = SdqReplyDAO.insertSDQResult(conn, testlogid, i+1, reply);
         
         // 응답 삽입 확인
         if(result){
            System.out.println("success");
         }
         
      }
      

      session.setAttribute("sdqNum", sdqNum);
      
      PrintWriter out = response.getWriter();
      out.println("<script>location.href='../EwhaSSK/getSDQAnalysis';</script>");
      session.setAttribute("currUser", currUser);
      out.flush();
      
   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      doGet(request, response);
   }

}