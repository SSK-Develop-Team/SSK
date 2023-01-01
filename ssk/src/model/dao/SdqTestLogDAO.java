package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model.dto.SdqTestLog;

public class SdqTestLogDAO {
	private final static String SQLST_INSERT_SDQ_TEST_LOG = "insert sdq_test_log(user_id, sdq_test_date, sdq_test_time) values (?,?,?)";
	
	public static boolean insertSdqTestLog(Connection con, SdqTestLog sdqTestLog) {
		try {
				PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_SDQ_TEST_LOG,Statement.RETURN_GENERATED_KEYS);
				pstmt.setInt(1, sdqTestLog.getUserId());
				pstmt.setDate(2, sdqTestLog.getSdqTestDate());
				pstmt.setTime(3, sdqTestLog.getSdqTestTime());
				
				pstmt.executeUpdate();
				
				ResultSet rs = pstmt.getGeneratedKeys();
				if(rs.next()) {
					sdqTestLog.setSdqTestLogId(rs.getInt(1));
					return true;
				}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}

}
