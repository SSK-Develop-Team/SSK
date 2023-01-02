package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.dto.SdqTestLog;

public class SdqTestLogDAO {
	private final static String SQLST_INSERT_SDQ_TEST_LOG = "insert sdq_test_log(user_id, sdq_test_date, sdq_test_time) values (?,?,?)";
	private final static String SQLST_SELECT_SDQ_TEST_LOG_BY_USER_ID = "select * from sdq_test_log where user_id = ?";
	
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
	
	public static ArrayList<SdqTestLog> getSdqTestLogAllByUserId(Connection con, int userId){
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_SDQ_TEST_LOG_BY_USER_ID);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<SdqTestLog> sdqTestLogList = new ArrayList<SdqTestLog>();
			while(rs.next()) {
				SdqTestLog sdqTestLog = new SdqTestLog();
				sdqTestLog.setSdqTestLogId(rs.getInt(1));
				sdqTestLog.setUserId(rs.getInt(2));
				sdqTestLog.setSdqTestDate(rs.getDate(3));
				sdqTestLog.setSdqTestTime(rs.getTime(4));
				
				sdqTestLogList.add(sdqTestLog);
			}
			return sdqTestLogList;
		}
		catch(SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

}
