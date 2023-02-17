package controller.expert;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.dto.export.SskExcelByUser;
import model.sevice.ExportChildResultExcelService;
import org.apache.poi.ss.usermodel.Workbook;

/**
 * @author Jiwon Lee
 * 아동 결과 엑셀 파일 export
 */
@WebServlet("/ExportChildResultExcel")
public class ExportChildResultExcel extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ExportChildResultExcel() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");

		int childId = 4;
		//int childId = Integer.parseInt(request.getParameter("childId"));

		SskExcelByUser sskExcelByUser = ExportChildResultExcelService.getSskExcelByChild(conn, childId, true, true, true, true);
		Workbook wb = sskExcelByUser.getWorkBook();
		String fileName = new String(sskExcelByUser.getFileName().getBytes("KSC5601"), StandardCharsets.ISO_8859_1);//encoding

		response.setHeader("Set-Cookie", "fileDownload=true; path=/");
		response.setHeader("Content-Disposition", String.format("attachment; filename=\""+fileName+"\""));

		wb.write(response.getOutputStream());

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
