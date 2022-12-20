package model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.dto.EsmReply;
import model.dto.EsmTestLog;

/**
 * @author Seo Ji Woo
 *
 */

public class EsmReplyDAO {/*REPLY!=RESULT*/
	private final static String SQLST_SELECT_ESM_RESULT_DUMMY = "select user_esm_reply from SDQResult where user_id = ? and number_of_esm_test = ? and esm_emotion_id = ?";
	private final static String SQLST_INSERT_ESM_RESULT_LIST = "insert user_esm_reply(esm_test_log, esm_emotion_id, esm_reply_content) values (?,?,?)";
	private final static String SQLST_INSERT_ESM_RESULT = "insert esm_reply(esm_test_log_id, esm_emotion_id, esm_reply_content) values (?,?,?)";
	private final static String SQLST_SELECT_ESM_RESULT = "select * from esm_reply where esm_test_log_id = ? and esm_emotion_id = ?";
	private final static String SQLST_SELECT_ESM_RESULT_GROUP_BY_DATE = "select * from esm_test_log where user_id =?";
	private final static String SQLST_SELECT_ESM_RESULT_GROUP_BY_TIME = "select * from esm_test_log where user_id =? and reply_date = ?";
	private final static String SQLST_SELECT_ESM_RESULT_BY_TIME = "select * from esm_reply where esm_test_log_id=?";
	private final static String SQLST_SELECT_ESM_TEST_LOG_ID = "select * from esm_test_log where user_id=?";
	private final static String SQLST_SELECT_ESM_RESULT_ALL = "select * from esm_reply where esm_test_log_id = any(select esm_test_log_id from esm_test_log where user_id=?)";
	private final static String SQLST_INSERT_ESM_TEST_LOG = "insert esm_test_log(user_id, esm_test_date, esm_test_time) values (?,?,?)";
	private final static String SQLST_SELECT_ESM_RECENT_TEST_ID = "select max(esm_test_log_id) from esm_test_log where user_id = ?";
	private final static String SQLST_SELECT_ESM_TEST_DATES = "select esm_test_date from esm_test_log where user_id = ?";
	private final static String SQLST_SELECT_ESM_TEST_TIMES = "select esm_test_time from esm_test_log where user_id = ?";
	
	public static boolean checkResult(Connection con, int userid, int testid, int emotionid) {
		boolean flag = false;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RESULT_DUMMY);
			pstmt.setInt(1, userid);
			pstmt.setInt(2, testid);
			pstmt.setInt(3, emotionid);
			flag = pstmt.executeQuery().next();
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public static boolean insertESMTestLog(Connection con, EsmTestLog bean) {
		boolean flag = false;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_ESM_TEST_LOG);
			pstmt.setInt(1, bean.getUserId());
			pstmt.setDate(2, bean.getEsmTestDate());
			pstmt.setString(3, bean.getEsmTestTime());
			
			if(pstmt.executeUpdate() == 1)
				flag = true;
	}
	catch(Exception e) {
		e.printStackTrace();
	}
	return flag;
	}
	
	public static boolean insertESMResultArray(Connection con, ArrayList<EsmReply> esmResultList) {
		boolean flag = false;
		try {
			for(int i = 0; i < 10; i ++) {
				PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_ESM_RESULT_LIST);
				pstmt.setInt(1, esmResultList.get(i).getEsmTestLogId());
				pstmt.setInt(2, esmResultList.get(i).getEsmEmotionId());
				pstmt.setInt(3, esmResultList.get(i).getEsmReplyContent());
				
				if(pstmt.executeUpdate() == 1) flag = true;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public static boolean insertESMResult(Connection con, int esmtestlogid, int esmemotionid, int esmreplycontent) {
		boolean flag = false;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_ESM_RESULT);
			pstmt.setInt(1, esmtestlogid);
			pstmt.setInt(2, esmemotionid);
			pstmt.setInt(3, esmreplycontent);
			
			if(pstmt.executeUpdate() == 1)
				flag = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public static int getRecentEsmTestId(Connection con, int userid) {
		int testlogid = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RECENT_TEST_ID);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				testlogid = rs.getInt("max(esm_test_log_id)");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return testlogid;
	}
	
	/*ESM 결과 받아오기 - 단일 결과가 맞는지 확인 필요*/
	public static EsmReply getESMResult(Connection con, int esmtestlogid, int esmemotionid) {
		EsmReply esmResult = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RESULT);
			pstmt.setInt(1,  esmtestlogid);
			pstmt.setInt(2, esmemotionid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				esmResult = new EsmReply();
				esmResult.setEsmReplyId(rs.getInt("esm_reply_id"));
				esmResult.setEsmTestLogId(rs.getInt("esm_test_log_id"));
				esmResult.setEsmEmotionId(rs.getInt("esm_emotion_id"));
				esmResult.setEsmReplyContent(rs.getInt("esm_reply_content"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return esmResult;
	}
	
	public static ArrayList<String> getEsmTestDates(Connection con, int userid){
		ArrayList<String> dates = new ArrayList<String>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_TEST_DATES);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String date = rs.getDate("esm_test_date").toString();
				System.out.println("EsmReplyDAO :: dates : " + date);
				dates.add(date);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return dates;
	}
	
	public static ArrayList<String> getEsmTestTimes(Connection con, int userid){
		ArrayList<String> times = new ArrayList<String>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_TEST_TIMES);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String time = rs.getString("esm_test_time").toString();
				times.add(time);
				System.out.println("sdqReplyDAO :: times : " + time);
			}
			return times;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*public static ArrayList<String> getESMDates(Connection con, int userid) {
		ArrayList<String> dates = new ArrayList<String>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RESULT_GROUP_BY_DATE);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String date = rs.getDate("esm_test_date").toString();
				dates.add(date);
				System.out.println("dates : " + date);
			}
			return dates;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// esm_test_log_id 받아오기
	public static ArrayList<Integer> getESMTimes(Connection con, int userid, String date){
		ArrayList<Integer> logids = new ArrayList<Integer>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RESULT_GROUP_BY_TIME);
			pstmt.setInt(1, userid);
			pstmt.setString(2, date);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int logid = rs.getInt("esm_test_log_id");
				logids.add(logid);
				System.out.println("getesmtimes : times : " + logid);
			}
			System.out.println(logids);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return logids;
	}*/
	
	public static ArrayList<EsmReply> getESMResultValue(Connection con, int esmtestlogid){
		ArrayList<EsmReply> results = new ArrayList<EsmReply>();
		EsmReply esmResult = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RESULT_BY_TIME);
			pstmt.setInt(1, esmtestlogid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				esmResult = new EsmReply();
				esmResult.setEsmReplyId(rs.getInt("esm_reply_id"));
				esmResult.setEsmTestLogId(rs.getInt("esm_test_log_id"));
				esmResult.setEsmEmotionId(rs.getInt("esm_emotion_id"));
				esmResult.setEsmReplyContent(rs.getInt("esm_reply_content"));
				results.add(esmResult);
			}
			return results;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static ArrayList<Integer> getESMTestLogIds(Connection con, int userid){
		ArrayList<Integer> logids = new ArrayList<Integer>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RESULT_ALL);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int logid = rs.getInt("esm_test_log_id");
				logids.add(logid);
			}
			return logids;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static ArrayList<EsmReply> getESMResultsAll(Connection con, int userid){
		ArrayList<EsmReply> results = new ArrayList<EsmReply>();
		EsmReply esmResult = null;
		try {
			
				PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RESULT_ALL);
				pstmt.setInt(1, userid);
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					esmResult = new EsmReply();
					esmResult.setEsmReplyId(rs.getInt("esm_reply_id"));
					esmResult.setEsmTestLogId(rs.getInt("esm_test_log_id"));
					esmResult.setEsmEmotionId(rs.getInt("esm_emotion_id"));
					esmResult.setEsmReplyContent(rs.getInt("esm_reply_content"));
					results.add(esmResult);
				}
			return results;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 * 
	 * public static ArrayList<EsmReply> getESMResultsAll(Connection con, ArrayList<Integer> ids){
		ArrayList<EsmReply> results = new ArrayList<EsmReply>();
		EsmReply esmResult = null;
		try {
			for(int i = 0; i < ids.size(); i++) {
				PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_ESM_RESULT_ALL);
				pstmt.setInt(1, ids.get(i));
				ResultSet rs = pstmt.executeQuery();
				if(rs.next()) {
					esmResult = new EsmReply();
					esmResult.setEsmReplyId(rs.getInt("esm_reply_id"));
					esmResult.setEsmTestLogId(rs.getInt("esm_test_log_id"));
					esmResult.setEsmEmotionId(rs.getInt("esm_emotion_id"));
					esmResult.setEsmReplyContent(rs.getInt("esm_reply_content"));
					results.add(esmResult);
				}
			}
			return results;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	 */
}
