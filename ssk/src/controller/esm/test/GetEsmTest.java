package controller.esm.test;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
