package model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import model.dto.SdqReply;
import model.dto.SdqTestLog;

/**
 * @author Seo Ji Woo
 *
 */

public class SdqReplyDAO {
	
	private final static String SQLST_INSERT_SDQ_TEST_LOG = "insert sdq_test_log(user_id, sdq_test_date, sdq_test_time) values (?,?,?)";
	private final static String SQLST_INSERT_SDQ_REPLY = "insert sdq_reply(sdq_test_log_id, sdq_question_id, sdq_reply_content) values (?,?,?)";
	private final static String SQLST_SELECT_SDQ_REPLY = "select * from sdq_reply where sdq_test_log_id = ? and sdq_question_id = ?";
	private final static String SQLST_COUNT_SDQ_TEST = "select count(distinct sdq_test_log_id) sdq_times from sdq_test_log where user_id = ?";
	private final static String SQLST_SELECT_SDQ_TEST_DATES = "select sdq_test_date from sdq_test_log where user_id = ?";
	private final static String SQLST_SELECT_SDQ_TEST_TIMES = "select sdq_test_time from sdq_test_log where user_id = ?";
	private final static String SQLST_SELECT_SDQ_RECENT_TEST_ID = "select max(sdq_test_log_id) from sdq_test_log where user_id = ?";
	
	public static boolean insertSDQTestLog(Connection con, SdqTestLog bean) {
		boolean flag = false;
		try {
				PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_SDQ_TEST_LOG);
				pstmt.setInt(1, bean.getUserId());
				pstmt.setDate(2, bean.getSdqTestDate());
				pstmt.setString(3, bean.getSdqTestTime());
				
				if(pstmt.executeUpdate() == 1)
					flag = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public static boolean insertSDQResultArray(Connection con, ArrayList<SdqReply> bean) {
		boolean flag = false;
		try {
			for(int i = 0; i < 10; i ++) {
				PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_SDQ_REPLY);
				pstmt.setInt(1, bean.get(i).getSdqTestLogId());
				pstmt.setInt(2, bean.get(i).getSdqQuestionId());
				pstmt.setString(3, bean.get(i).getSdqReplyContent());
				
				if(pstmt.executeUpdate() == 1)
					flag = true;
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public static boolean insertSDQResult(Connection con, int sdqtestlogid, int sdqquestionid, String sdqreplycontent) {
		String sql = null;
		boolean flag = false;
		try {
			sql = "insert sdq_reply(sdq_test_log_id, sdq_question_id, sdq_reply_content) values (?,?,?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, sdqtestlogid);
			pstmt.setInt(2, sdqquestionid);
			pstmt.setString(3, sdqreplycontent);
			
			if(pstmt.executeUpdate() == 1)
				flag = true;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
	
	public static int getTimesOfSdqTest(Connection con, int userid) {
		int count = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_COUNT_SDQ_TEST);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("sdq_times");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public static int getRecentSdqTestId(Connection con, int userid) {
		int testlogid = 0;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_SDQ_RECENT_TEST_ID);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				testlogid = rs.getInt("max(sdq_test_log_id)");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return testlogid;
	}

	// SDQ 결과 불러오기
	public static SdqReply getSDQ(Connection con, int sdqtestlogid, int sdqquestionid) {
		SdqReply bean = null;
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_SDQ_REPLY);
			pstmt.setInt(1,  sdqtestlogid);
			pstmt.setInt(2, sdqquestionid);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new SdqReply();
				bean.setSdqReplyId(rs.getInt("sdq_reply_id"));
				bean.setSdqTestLogId(rs.getInt("sdq_test_log_id"));
				bean.setSdqQuestionId(rs.getInt("sdq_question_id"));
				bean.setSdqReplyContent(rs.getString("sdq_reply_content"));
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return bean;
	}
	
	public static ArrayList<String> getSdqTestDates(Connection con, int userid){
		ArrayList<String> dates = new ArrayList<String>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_SDQ_TEST_DATES);
			pstmt.setInt(1,  userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String date = rs.getDate("sdq_test_date").toString();
				System.out.println("SdqReplyDAO :: dates : " + date);     
				dates.add(date);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return dates;
	}
	
	public static ArrayList<String> getSdqTestTimes(Connection con, int userid){
		ArrayList<String> times = new ArrayList<String>();
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_SDQ_TEST_TIMES);
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String time = rs.getString("sdq_test_time").toString();
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
	
	
	/*
	public static ArrayList<String> getSDQDates(Connection con, int userid) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<String> dates = new ArrayList<String>();
		try {
			String sql = "select * from user_sdq_reply where user_id =? group by reply_date";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String date = rs.getDate("reply_date").toString();
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
	
	public static ArrayList<String> getSDQTimes(Connection con, int userid, String date){
		ArrayList<String> times = new ArrayList<String>();
		try {
			String sql = "select * from user_sdq_reply where user_id =? and reply_date = ? group by reply_time;";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setString(2, date);
			System.out.println("getSDQTimes() : " + userid + " " + date);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String time = rs.getString("reply_time").toString();
				times.add(time);
				System.out.println("times : " + time);
			}
			return times;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	*/
	
	public static ArrayList<SdqReply> getSDQResultValue(Connection con, int userid, String date, String time){
		ArrayList<SdqReply> results = new ArrayList<SdqReply>();
		SdqReply bean = null;
		try {
			String sql = "select * from sdq_reply where sdq_test_log_id = (select sdq_test_log_id from sdq_test_log where user_id =? and sdq_test_date = ? and sdq_test_time = ?)";
			PreparedStatement pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, userid);
			pstmt.setString(2, date);
			pstmt.setString(3, time);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				bean = new SdqReply();
				bean.setSdqReplyId(rs.getInt("sdq_reply_id"));
				bean.setSdqTestLogId(rs.getInt("sdq_test_log_id"));
				bean.setSdqQuestionId(rs.getInt("sdq_question_id"));
				bean.setSdqReplyContent(rs.getString("sdq_reply_content"));
				
				results.add(bean);
			}
			return results;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static ArrayList<SdqReply> getSDQResultsAll(Connection con, int userid){
		ArrayList<SdqReply> results = new ArrayList<SdqReply>();
		SdqReply sdqResult = null;
		try {
			PreparedStatement pstmt = con.prepareStatement("select * from sdq_reply where sdq_test_log_id = any(select sdq_test_log_id from sdq_test_log where user_id=?)");
			pstmt.setInt(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				sdqResult = new SdqReply();
				sdqResult.setSdqReplyId(rs.getInt("sdq_reply_id"));
				sdqResult.setSdqTestLogId(rs.getInt("sdq_test_log_id"));
				sdqResult.setSdqQuestionId(rs.getInt("sdq_question_id"));
				sdqResult.setSdqReplyContent(rs.getString("sdq_reply_content"));
				results.add(sdqResult);
			}
			return results;
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}

}
