package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.dto.EsmTestLog;
/**
 * @author Jiwon Lee
 * 정서 발달 기록(esm_test_log) DAO
 * 테스트 기록 삽입
 * 테스트 기록 조회(사용자 별)
 * 테스트 기록 조회(아이디로)
 *
 */
public class EsmTestLogDAO {
	private final static String SQLST_INSERT_ESM_TEST_LOG = "insert esm_test_log(user_id, esm_test_date, esm_test_time) values(?,?,?)";
	private final static String SQLST_SELECT_ESM_TEST_LOG_BY_USER = "select * from esm_test_log where user_id = ?";
	private final static String SQLST_SELECT_ESM_TEST_LOG_BY_ID = "select * from esm_test_log where esm_test_log_id = ?";
	
	/*정서 발달 기록 삽입*/
	public static boolean insertEsmTestLog(Connection con, EsmTestLog esmTestLog) {
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_ESM_TEST_LOG, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1,esmTestLog.getUserId());
			pstmt.setDate(2, esmTestLog.getEsmTestDate());
			pstmt.setTime(3, esmTestLog.getEsmTestTime());
			
			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				esmTestLog.setEsmTestLogId(rs.getInt(1));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	/*사용자별 정서 발달 기록 조회*/
	public static ArrayList<EsmTestLog> getEsmTestLogByUserId(Connection con, int userId){
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_TEST_LOG_BY_USER);
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<EsmTestLog> esmTestLogList = new ArrayList<EsmTestLog>();
			while(rs.next()) {
				EsmTestLog esmTestLog = new EsmTestLog(rs.getInt(2),rs.getDate(3),rs.getTime(4));
				esmTestLog.setEsmTestLogId(rs.getInt(1));
				
				esmTestLogList.add(esmTestLog);
			}
			return esmTestLogList;
		}
		catch(SQLException e) {
			e.printStackTrace();
			return null;
		}
	}
	/*정서 발달 기록 조회*/
	public static EsmTestLog getEsmTestLogById(Connection con, int esmTestLogId) {
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_TEST_LOG_BY_ID);
			pstmt.setInt(1, esmTestLogId);
			
			ResultSet rs = pstmt.executeQuery();
			
			EsmTestLog esmTestLog = null;
			while(rs.next()) {
				esmTestLog = new EsmTestLog(rs.getInt(2),rs.getDate(3),rs.getTime(4));
				esmTestLog.setEsmTestLogId(rs.getInt(1));
			}
			return esmTestLog;
			
		} catch (SQLException e) {
			e.printStackTrace();
			return null;
		}
		
	}
}
