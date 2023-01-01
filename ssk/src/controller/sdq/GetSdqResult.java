package controller.sdq;

import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.dto.SdqReply;
import model.dto.User;

/**
 * @author Jiwon Lee
 * 
 * SDQ 검사 직후 결과를 보여주는 서블릿
 */
@WebServlet("/GetSdqResult")
public class GetSdqResult extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GetSdqResult() {
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
		
		ArrayList<SdqReply> sdqReplyList = (ArrayList<SdqReply>)request.getAttribute("sdqReplyList");
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
