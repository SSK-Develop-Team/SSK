package controller.user;

import model.dao.UserDAO;
import model.dto.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.Connection;
/**
 * @author Jiwon Lee
 * 계정 수정 페이지 가져오기
 * - 관리자, 전문가가 아동 계정을 수정하는 경우
 * - 관리자가 전문가 계정을 수정하는 경우
 */
@WebServlet(name = "GetUpdateUser", value = "/GetUpdateUser")
public class GetUpdateUser extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        ServletContext sc = getServletContext();
        Connection conn= (Connection) sc.getAttribute("DBconnection");

        int userId = 0;
        if(request.getParameter("latestChildId")!=null){
            userId = Integer.parseInt(request.getParameter("latestChildId"));
        }else if(request.getParameter("latestExpertId")!=null){
            userId = Integer.parseInt(request.getParameter("latestExpertId"));
        }

        User user = UserDAO.getUserById(conn,userId);

        request.setAttribute("user",user);

        RequestDispatcher rd = request.getRequestDispatcher("/register.jsp?role=child");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
