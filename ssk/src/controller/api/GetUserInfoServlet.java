package controller.api;

import model.dao.UserDAO;
import model.dto.User;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.sql.Connection;



/**
 * User Info API for ESM Alarm APP
 * -- POST /ssk/user
 * 사용자 로그인 아이디, 비밀번호 존재 여부 확인 
 */
@WebServlet(name = "GetUserInfoServlet", urlPatterns = "/user")
public class GetUserInfoServlet extends HttpServlet {
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
        String userLoginId = requestBody.get("loginId").toString();
        String userPw = requestBody.get("password").toString();

        System.out.println("POST /user --- ID: "+userLoginId);
        System.out.println("POST /user --- PW: "+userLoginId);

        User user = UserDAO.findUser(conn,userLoginId, userPw);

        String message = "";
        JSONObject result = new JSONObject();//전체 result
        JSONObject data = new JSONObject();//user data

        if(requestBody == null){
            message = "Invalid Request";
            result.put("message", message);
        }
        else if(user==null){ // user가 존재하지 않는 경우
            message = "User not exist";
            result.put("message", message);
        }
        else if(!user.getUserRole().equals("CHILD")){//user가 아동이 아닌 경우
            message = "Not Child Account";
            result.put("message", message);
        }
        else{ // user가 존재하는 경우
            message = "success";
            result.put("message", message);

            data.put("id", user.getUserId());
            data.put("loginId",user.getUserLoginId());
            data.put("password", user.getUserPassword());
            data.put("name",user.getUserName());

            result.put("user", data);
        }

        //String encodingStrResult = new String(result.toJSONString().getBytes(StandardCharsets.ISO_8859_1),"utf-8");

        PrintWriter out = response.getWriter();
        response.setContentType("application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");

        out.println(result.toJSONString());
        out.flush();
    }

    public static String getBody(HttpServletRequest request) throws IOException {

        String body = null;
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;

        try {
            InputStream inputStream = request.getInputStream();
            if (inputStream != null) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }

        body = stringBuilder.toString();
        return body;
    }
}
