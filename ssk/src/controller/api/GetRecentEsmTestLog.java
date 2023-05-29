package controller.api;

import model.dao.EsmTestLogDAO;
import model.dao.UserDAO;
import model.dto.EsmTestLog;
import model.dto.User;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.Time;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.ArrayList;

import static controller.api.GetUserInfoServlet.getBody;


@WebServlet(name = "GetRecentEsmTestLog", urlPatterns = "/esmTestLog")
public class GetRecentEsmTestLog extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        ServletContext sc = getServletContext();
        Connection conn= (Connection)sc.getAttribute("DBconnection");

        JSONParser jsonParser = new JSONParser();
        JSONObject requestBody = null;

        try {
            requestBody = (JSONObject)jsonParser.parse(getBody(request));

        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

        int userId = Integer.parseInt(requestBody.get("id").toString());//식별 아이디 가져오기

        Date currDate = Date.valueOf(requestBody.get("currDate").toString());//현재 날짜
        Time currTime = Time.valueOf(requestBody.get("currTime").toString());//현재 시간

        EsmTestLog recentEsmTestLog = EsmTestLogDAO.getRecentEsmTestLogListByUserId(conn,userId);//사용자의 최근 검사 기록


        /* 응답 데이터 */
        String message = "required";
        String date = "";
        String time = "";

        if(recentEsmTestLog==null){//최근 기록이 없는 경우
            date = "-";
            time = "-";
        }else{//최근 기록이 있는 경우
            //최근 기록이 현재 검사 범주에 포함되는 경우
            //포함되지 않는 경우
            date = recentEsmTestLog.getEsmTestDate().toString();
            time = recentEsmTestLog.getEsmTestTime().toString();
        }

        JSONObject result = new JSONObject();//전체 result
        JSONObject data = new JSONObject();//user data

        result.put("message", message);

        data.put("date", date);
        data.put("time",time);
        result.put("esmTestLog", data);


        PrintWriter out = response.getWriter();
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        out.println(result.toJSONString());
        out.flush();
    }

}

