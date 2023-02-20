package controller.expert;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletOutputStream;

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
	public static final String FILE_SEPARATOR = System.getProperty("file.separator");
	
    public ExportChildResultExcel() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");

		ServletContext sc = getServletContext();
		Connection conn= (Connection) sc.getAttribute("DBconnection");

		boolean lang = false, sdq=false, esm = false, esmRecord = false;
		
		String[] childIdStrList = request.getParameterValues("childId");
		String[] categoryList = request.getParameterValues("category");
		
		for(String x : categoryList) {
			switch(x) {
				case "lang":
					lang=true;
					break;
				case "sdq":
					sdq=true;
					break;
				case "esm":
					esm=true;
					break;
				case "esmRecord":
					esmRecord = true;
					break;
			}
		}
		try {
			String dirPath = getServletContext().getRealPath("ssk/");
			File directory = new File(dirPath);
			
			if(!directory.exists()) directory.mkdirs();
			
			for(String c : childIdStrList) {
				int childId = Integer.parseInt(c);
				if(childId==0) continue;
				SskExcelByUser sskExcelByUser = ExportChildResultExcelService.getSskExcelByChild(conn, childId, lang, sdq, esm, esmRecord);
				Workbook wb = sskExcelByUser.getWorkBook();
				
				String fileName = new String(sskExcelByUser.getFileName().getBytes("KSC5601"), StandardCharsets.ISO_8859_1);//encoding
				
				FileOutputStream fos = new FileOutputStream(new File(dirPath+fileName));
				
				wb.write(fos);
				fos.flush();
				fos.close();
				wb.close();
			}
			
			
			String[] files = directory.list();
			
			if(files != null && files.length > 0) {
				byte[] zip = zipFiles(directory);
				ServletOutputStream sos = response.getOutputStream();
	            response.setContentType("application/zip;charset=utf-8");
	            String headerKey = "Content-Disposition";
	            
	            String filename = new String("테스트용 파일".getBytes("utf-8"),StandardCharsets.ISO_8859_1);
	            String headerValue = String.format("attachment; filename=\"" + filename + ".zip");
	            response.setHeader(headerKey, headerValue);
	            
	            sos.write(zip);
	            sos.flush();
	            
	            boolean isDel = deleteFiles(directory);
	            
	            if(!isDel)
	            	throw new Exception("Fail to delete files in server.");
			}
		
		}catch (Exception e) {
			e.printStackTrace();
		}
		/*response.setHeader("Set-Cookie", "fileDownload=true; path=/");
		response.setHeader("Content-Disposition", String.format("attachment; filename=\""+fileName+"\""));

		wb.write(response.getOutputStream());
		 */
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private byte[] zipFiles(File directory) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ZipOutputStream zos = new ZipOutputStream(baos);
        
		searchDirectory(directory, directory, zos);
		
		zos.flush();
        baos.flush();
        zos.close();
        baos.close();
        return baos.toByteArray();
	}
	
	private void compressFile(File parentDir, String fileName, ZipOutputStream zos){
		byte bytes[] = new byte[2048];
		FileInputStream fis;
		try {
			fis = new FileInputStream(parentDir.getPath() + FILE_SEPARATOR + fileName);
			BufferedInputStream bis = new BufferedInputStream(fis);

	        zos.putNextEntry(new ZipEntry( parentDir.getName()+ FILE_SEPARATOR + fileName));
	        int bytesRead;
            while ((bytesRead = bis.read(bytes)) != -1) {
                zos.write(bytes, 0, bytesRead);
            }
            zos.closeEntry();
            bis.close();
            fis.close();
	        
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void searchDirectory(File file, File parentDir ,ZipOutputStream zos) {
		if( file.isDirectory()) {
			
			File[] childrenFile = file.listFiles();
			
			for( File child : childrenFile ) {
				searchDirectory(child, file ,zos);
			}

		}else {
			compressFile(parentDir, file.getName(), zos);
		}
	}
	
	private boolean deleteFiles(File directory) {
		
		File[] fileList = directory.listFiles();
        for(File f : fileList) {
        	if( f.isDirectory())
        		deleteFiles(f);
        	else {
        		if(!f.delete())
            		return false;
        	}
        }
        
        if(directory.delete()) {
        	return true;
        }else {
        	return false;
        }
	}

}
