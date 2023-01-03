package model.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.dto.SdqReply;
import model.dto.SdqTestLog;

/**
 * @author Seo Ji Woo
 *
 */

public class SdqReplyDAO {
	
	private final static String SQLST_INSERT_SDQ_REPLY = "insert sdq_reply(sdq_test_log_id, sdq_question_id, sdq_reply_content) values (?,?,?)";
	private final static String SQLST_SELECT_SDQ_REPLY_LIST_BY_SDQ_TEST_LOG_ID = "select * from sdq_reply where sdq_test_log_id = ?";
	
	public static boolean insertSdqReply(Connection con, SdqReply sdqReply) {
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_INSERT_SDQ_REPLY,Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, sdqReply.getSdqTestLogId());
			pstmt.setInt(2, sdqReply.getSdqQuestionId());
			pstmt.setInt(3, sdqReply.getSdqReplyContent());
			
			pstmt.executeUpdate();
			
			ResultSet rs = pstmt.getGeneratedKeys();
			if(rs.next()) {
				sdqReply.setSdqReplyId(rs.getInt(1));
				return true;
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static ArrayList<SdqReply> getSdqReplyListBySdqTestLogId(Connection con, int sdqTestLogId){
		try {
			PreparedStatement pstmt = con.prepareStatement(SQLST_SELECT_SDQ_REPLY_LIST_BY_SDQ_TEST_LOG_ID);
			pstmt.setInt(1, sdqTestLogId);
			ResultSet rs = pstmt.executeQuery();
			ArrayList<SdqReply> sdqReplyList = new ArrayList<SdqReply>();
			while(rs.next()) {
				SdqReply sdqReply = new SdqReply();
				sdqReply.setSdqReplyId(rs.getInt(1));
				sdqReply.setSdqTestLogId(rs.getInt(2));
				sdqReply.setSdqQuestionId(rs.getInt(3));
				sdqReply.setSdqReplyContent(rs.getInt(4));
				
				sdqReplyList.add(sdqReply);
			}
			return sdqReplyList;
		}
		catch(SQLException e) {
			e.printStackTrace();
			return null;
		}
	}

}
