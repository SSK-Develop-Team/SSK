package controller.sdq.test;

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

import model.dao.SDQResultAnalysisDAO;
import model.dao.SdqReplyDAO;
import model.dto.User;

/**
 * @author Seo Ji Woo
 *
 */

/**
 * Servlet implementation class GetSDQResult
 */
@WebServlet("/getSDQResult")
public class GetSDQResult extends HttpServlet {
   private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetSDQResult() {
        super();
        // TODO Auto-generated constructor stub
    }

   /**
    * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // TODO Auto-generated method stub
      
      response.setContentType("text/html; charset=UTF-8");
       request.setCharacterEncoding("UTF-8");
       
       HttpSession session = request.getSession(true);
      
      // for DB Connection
      ServletContext sc = getServletContext();
      Connection conn= (Connection) sc.getAttribute("DBconnection");
      
      SdqReplyDAO sdqResultMgr = new SdqReplyDAO();
      User currUser = (User)session.getAttribute("currUser");
      String id = currUser.getUserLoginId();
      String name = currUser.getUserName();
      int userid = currUser.getUserId();
      //String date = (String)session.getAttribute("date");
      //System.out.println("date: " + date);
      
      //int numberOfSdqTest = Integer.parseInt((String)request.getAttribute("numberOfSdqTest"));

      //int sdqNum = SdqReplyDAO.getTimesOfSdqTest(conn, userid);
      session.setAttribute("currUser", currUser);
      //int testNum = currUser.getTotalNumberOfSdqTest() - 1;
      
      ArrayList<Integer> scoreList = new ArrayList<Integer>();
      
      for(int i = 0; i < 10; i++){

         // sdq_test_log_id 임의 설정해 놓음. 수정 필요.
    	 //int timesOfSdqTest = SdqReplyDAO.getTimesOfSdqTest(conn, userid);
    	 int testlogid = SdqReplyDAO.getRecentSdqTestId(conn, userid);
    	 System.out.println("testlogid : " +testlogid);
         String result = SdqReplyDAO.getSDQ(conn, testlogid, i+1).getSdqReplyContent();
         
         if(result.equals("전혀아니다")){
            scoreList.add(0);
         }
         else if(result.equals("조금그렇다")){
            scoreList.add(1);
         }
         else if(result.equals("그렇다")){
            scoreList.add(2);
         }
         else if(result.equals("매우그렇다")){
            scoreList.add(3);
         }
      }
      
      int social = 0;
      int excessive = 0;
      int emotion = 0;
      int behavior = 0;
      int peer = 0;
      
      for(int i = 0; i < 10; i++){
         if(i < 2){
            social += scoreList.get(i);
         }
         else if(i < 4){
            excessive += scoreList.get(i);
         }
         else if(i < 6){
            emotion += scoreList.get(i);
         }
         else if(i < 8){
            behavior += scoreList.get(i);
         }
         else if(i < 10){
            peer += scoreList.get(i);
         }
      }
      

      request.setAttribute("social", social);   
      request.setAttribute("excessive", excessive);   
      request.setAttribute("emotion", emotion);   
      request.setAttribute("behavior", behavior);
      request.setAttribute("peer", peer);      
      
      // SDQ 분야별 결과 확인
      /*System.out.println("social : " + social);
      System.out.println("excessive : " + excessive);
      System.out.println("emotion : " + emotion);
      System.out.println("behavior : " + behavior);
      System.out.println("peer : " + peer);
      */
      
      int socialIntervention = (int) request.getAttribute("socialIntervention");
      int socialBoundary = (int) request.getAttribute("socialBoundary");
      int socialNormal = (int) request.getAttribute("socialNormal");
      int excessiveIntervention = (int) request.getAttribute("excessiveIntervention");
      int excessiveBoundary = (int) request.getAttribute("excessiveBoundary");
      int excessiveNormal = (int) request.getAttribute("excessiveNormal");
      int emotionIntervention = (int) request.getAttribute("emotionIntervention");
      int emotionBoundary = (int) request.getAttribute("emotionBoundary");
      int emotionNormal = (int) request.getAttribute("emotionNormal");
      int behaviorIntervention = (int) request.getAttribute("behaviorIntervention");
      int behaviorBoundary = (int) request.getAttribute("behaviorBoundary");
      int behaviorNormal = (int) request.getAttribute("behaviorNormal");
      int peerIntervention = (int) request.getAttribute("peerIntervention");
      int peerBoundary = (int) request.getAttribute("peerBoundary");
      int peerNormal = (int) request.getAttribute("peerNormal");
      
      request.setAttribute("socialIntervention", socialIntervention);   
      request.setAttribute("socialBoundary", socialBoundary);   
      request.setAttribute("socialNormal", socialNormal);   
      request.setAttribute("excessiveIntervention", excessiveIntervention);   
      request.setAttribute("excessiveBoundary", excessiveBoundary);
      request.setAttribute("excessiveNormal", excessiveNormal);
      request.setAttribute("emotionIntervention", emotionIntervention);   
      request.setAttribute("emotionBoundary", emotionBoundary);   
      request.setAttribute("emotionNormal", emotionNormal);   
      request.setAttribute("behaviorIntervention", behaviorIntervention);   
      request.setAttribute("behaviorBoundary", behaviorBoundary);   
      request.setAttribute("behaviorNormal", behaviorNormal);      
      request.setAttribute("peerIntervention", peerIntervention);      
      request.setAttribute("peerBoundary", peerBoundary);      
      request.setAttribute("peerNormal", peerNormal);
      
      RequestDispatcher rd = request.getRequestDispatcher("/sdqresult.jsp");
      rd.forward(request, response);

   }

   /**
    * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
    */
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      // TODO Auto-generated method stub
      doGet(request, response);
   }

}