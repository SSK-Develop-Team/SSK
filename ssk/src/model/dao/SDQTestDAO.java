package model.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.dto.SdqQuestion;

/**
 * @author Seo Ji Woo
 *
 */

public class SDQTestDAO {
	
	private final static String SQLST_SELECT_SDQTEST = "select * from sdq_question";
	
	public static ArrayList<SdqQuestion> getTestList(Connection con) {
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<SdqQuestion> testlist = new ArrayList<SdqQuestion>();
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(SQLST_SELECT_SDQTEST);
			
			while(rs.next()) {
				
				SdqQuestion bean = new SdqQuestion();
				bean.setSdqQuestionId(rs.getInt("sdq_question_id"));
				bean.setSdqType(rs.getString("sdq_type"));
				bean.setSdqQuestionContent(rs.getString("sdq_question_content"));
				bean.setSdqScoringType(rs.getString("sdq_scoring_type"));
				bean.setSdqTarget(rs.getString("sdq_target"));
				testlist.add(bean);
				
			}
		} catch (Exception e) {
			System.out.println("Exception " + e);
		} 
		return testlist;
		
	}

}
